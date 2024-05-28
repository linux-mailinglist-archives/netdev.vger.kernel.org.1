Return-Path: <netdev+bounces-98439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D498D16F8
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4931F1C22781
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807D713D29A;
	Tue, 28 May 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/4nEVAI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619914594A;
	Tue, 28 May 2024 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887600; cv=fail; b=FdFk8PHUKWfv/wCLORpw6/QAwJtzRWEW1pfUaaRVkw2Uk86LNW5zHPtcAQsjYQ+YxFIIIK/vkvEJ0s2RaHZMlVA3W2ZdlBEXmypn3YkMoWknjfcigs9iFVc3vhGl6z7dMKk24qV2OD9NSp7dvrX1m92LqDYjsxnA4U104kj5ILM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887600; c=relaxed/simple;
	bh=h61pj3bJa7fyl5wjlLT3wDgFdbseW6lzlfW+0OhnkSg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a8AgM+H8vBGHrE0ZEO5J2b2oTlezyd4Q1I52NxzU44gAlovCmNryw259rapuMbLDph2Z/9cN835eg2c3LNMDV2BlTjtBtD6t91ToAigvw5I4YnH2c/TTEwpuK6cr2R2quqBQfL5y6Enq6Ugs8+xmt3EyCLlTv8q+FRdc/BWzlWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/4nEVAI; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716887598; x=1748423598;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h61pj3bJa7fyl5wjlLT3wDgFdbseW6lzlfW+0OhnkSg=;
  b=b/4nEVAIrS04OYqzU/GowXbFxoM/3i41SFopQ2XxPYO8z7YJyzH3R2NO
   /RkyHlym4FbJEORD0VbLUiBAkolI/Kc7QL0RZzMEu1TXxN8K/HH1n7E50
   LWFxIIq6dUc8/qNGuDPnGWZ0dn7QW4HuugvOeaWc79RqpVMHxtFn6qBAN
   4a0N4mwxkL6jtaz25Ep75xV4uTDeIY/OUzlMSAaTzKXE5pcnnpiG0/EZ8
   Q0K4Yp4H1jv71UAL1R/TR8a2WMJ7BFrGeg/TCeT6Ysg+RAYXUeiEgCQYj
   5+nwLgAxpH2xnj+y/ldtUrPe3Ut2iT7dNprZ4KQBnMEtGfyOQlvuwrBQx
   g==;
X-CSE-ConnectionGUID: hdb1NEicTNGLgp6v97Jrgg==
X-CSE-MsgGUID: lbWabgrmTQKFRLxBMmkVgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13440715"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13440715"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:13:17 -0700
X-CSE-ConnectionGUID: 11VF1YacR/eG+F+uPaNm4w==
X-CSE-MsgGUID: 15v7tUn6TfWPsP/bLTAevg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="39443796"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 02:13:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 02:13:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 02:13:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 02:13:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 02:13:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRtNr0kHcjuzx4lncOhZ6gQ+BweOMircEICSNl5tOswzkG2ncn/F+PLmKqawhxKcdNkEAkTjM/HpGn7/NBkiB81j0TM0kaMA4/jlwfUm04DlFcNRp+t5QmtJYP+pXW3PjASyqVJWntTJ9Nh/sqMQH7jJQ5ky6GlWodb82c8NFserbK2KL8szcSz9BeUk0Z5nGjMWYaWIV7R5mdFLxZ4fUo78PMMZNsvPq+ALKiauVrfogZCas66TBQ2OuLzbuQzMWpOHlt0RHcKlWVrLo+9BYMyJeaeb4l21x5Q0JC7+Xxk1WQoQ1DbSyzI1HUAdPaiHGirJeOf4pHLTNBcMbrwV2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4Ylyu0zKzEYSPJd8CmOaQsJKT9CfSFHi3mg+bbnRfE=;
 b=RUO26kLBpdcNQoOdDYs4Q6NDQVnHhEe3hvdAAgJjAcV71phiDtKa8fIryMOdOS622lWN8GtwEIRseq/2QFRwJEGowXM+pfnPILlp1g+Lew2m1bca7QTTulXY7i0TwZNp7pc8kZhnmS211CyvHxn/u3lFZiry/Qub7DvsvAR54IUWRdTDsHQGoKi+tTWnVVyt1rNFLvXV8CjmpJ3OBz+HlEf6ruqNnHYNNHCheVJZoLTJIS3Vlo6rq+0lhcxVtUj7NrMhDlMmRSABdqPYkNKew3LBFELV4nr02xyEq46Ep4kaAphOfOVZkdKX0STrNWUtYakVjrqnxpoil7C+sTRC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH8PR11MB7022.namprd11.prod.outlook.com (2603:10b6:510:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 09:13:14 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 09:13:14 +0000
Message-ID: <c0febdc2-d533-4fbb-8f8a-1da13775ab91@intel.com>
Date: Tue, 28 May 2024 11:13:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v2] octeontx2-af: Add debugfs support to dump NIX
 TM topology
To: Anshumali Gaur <agaur@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240528085614.10974-1-agaur@marvell.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240528085614.10974-1-agaur@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::16) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH8PR11MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 23045630-25db-4dcd-f103-08dc7ef66747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Lzk5cnI2Z3BlaURJQWdrUzhKbWRFVU5XdERQVGxxWHZMQVYvVTR1Yk81NGZE?=
 =?utf-8?B?eVU5dXRUZkdqYTRLSHpjRXVZU2FRelVwbC9BRUx2RGFkOE1PamVtSkl6dmFG?=
 =?utf-8?B?aklSV2JXVnpsUlVQY25NNFFHV0FQdy9aSGpSMXlEbFdpK3ozOVRWbFNwc0Fn?=
 =?utf-8?B?VEJxTGlVMjdDb21qRlNKVTNWSlZqMk5BcHlRcnlDSFA1STJOWEc2NGVObUIx?=
 =?utf-8?B?UUczajVzc1Mzajc4dFRzSFpkRVo3allrQUFZNHQ1MmhFUk1pZUloM1FTampj?=
 =?utf-8?B?d2MwL3lGU2VBV0xVdkZFa0xSdlRoV2p6L1ZYSm1GeEx3SDV2c1JUNHRSdStx?=
 =?utf-8?B?dkhWc0UrSnZsQjJXaVZsVjNOQys0NUlZZzFUMUlKc0U5NThZWi8ybzlsUVgr?=
 =?utf-8?B?VjUrbllzOTZudk5XY2pjeTRreGtFRXJkVk5udlBuSDl3VDYvMkhpVmU0eWRz?=
 =?utf-8?B?UVhlSzRDQmU2TmNqWXErTURZTys5MnZ1b3NUelFGR0FrNzJwZVRKRVk1eWZy?=
 =?utf-8?B?RXFmNWdSOTFQOW9ER1pzR2Q0dEtsb2tST295NTdkTFZ3T1N1a04va3dCSlZD?=
 =?utf-8?B?eTNuN3JaMmxHZ0ZxbkdKUVJZNnJmWDZja0toUGZqQ042M3BvT1Z5clZjUjda?=
 =?utf-8?B?M1FqWmxEd00xc0lJWVhLdm9VMktsSVBTM2lCL0E3MW9vSjVUdzVMZUt2M3hi?=
 =?utf-8?B?S0Z3clh2akxZNWtwdnNGRXpJOHVwQjJsS0tVY210SXZGZEV4a01OZ2daa1Zx?=
 =?utf-8?B?TUczTjNlZWk1QXh2OUxmYzlsSTNCelBlSmduT0k1WlZnbjhjVDJSNHZBd1Mw?=
 =?utf-8?B?SjhxT1I5SnVmWFhoYSt0T2gvMFM4Um9ZdVdnSFFySEtocTNWRVF3Y044aHNr?=
 =?utf-8?B?a2xzRjRWM20zeHR3c3JBWHVzMW5nSElVMFM0N0k1blJSZWVHdTZ0czBNWjA0?=
 =?utf-8?B?U1p4SEpncmZJZkl2WS92ZTNxRVdkRlIxcDR4cFhJS0I0QnJkTHlFZk40SVlG?=
 =?utf-8?B?d25jVE5renpRRElONWhRNVlKMzNpR1hvdWxnWFd1ckwyN1ZwQ3NFSUNOcStk?=
 =?utf-8?B?bE9OM3lwc1h3eldBMk1SK3pBYkhoYmNMQmlBUk14ZzJpYjlsRGJyeU9vbmZK?=
 =?utf-8?B?NFpvbkVUWHVjZDdrQStxczBCcmNjV3N3K04xazFXbTY0YytGbDNub1FucC9t?=
 =?utf-8?B?NGoxZUUvMk9zT0swWk5vb3ZnMXNOSzN6aGhOUEhKS3R2Qnl0YmhGOFd3Yktk?=
 =?utf-8?B?MlNvZHY2Q21IMUl0MFlyRFdYSmRkbmFtVnAvWnIySlpTdzJ4MTJxanFUSEpu?=
 =?utf-8?B?dlE4bW90bWVETWNUaWJXU2gvaHh5MFRpRnlDMDlFbk42VzdxSFV0aVJhcndz?=
 =?utf-8?B?UWhISVFyTGp2RWtVNzlKNEtFUldFWjA5bXVlN0Y1T1orOVBRZjBralU4VjVp?=
 =?utf-8?B?UThYWnVOVzgzS0d4bGQ2c2RVSmgzeUw4ektOb21mZEZjOUxXRmJvTDA1NThG?=
 =?utf-8?B?MXdiYTN3alRzZytXU2VZTUZOaDJRSWxrM1ozUE9PL3g3K2dUQ0lUS3djREdP?=
 =?utf-8?B?K1FzRjlPeGltcjdtejJtaG5hdGl2Yk9HL1NxSE9zTysyMUt2WE1ycEhONFM3?=
 =?utf-8?B?WkVVd0RTeFV0Zi9UUU9aRHlTbTBMcXFTeGZlejg1MzUyejRpZjVGUEZYOCsz?=
 =?utf-8?B?dDlBcG9Ob1ErUmNRdTdqQnppejlUMnNnOW1WYzFiZFViRnNnZ2E2VWJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjVSUDE1Yi9RUCsxaVp5VzZqYmc3WWZzNEhJMHp5eE9GNGhURVlTT0t4NjVO?=
 =?utf-8?B?QlRNTm5JNUNiMHlLeExTWEZaeXhJa0d4MWhramNzdHMySElmWmZCVGdSVUw0?=
 =?utf-8?B?U1JnWnN2NnVMdG9pM1dTeFVqVkV6SGZOenVMNVhQRXZRR2RiN1NlYUZTVkp3?=
 =?utf-8?B?VTNXSE1oSE93YU5Lek1pVGVMak5tUDE4eVdvTXQrcml5S0c5UFMxa2xJZ2Ix?=
 =?utf-8?B?UGh1dm56bDh0MEpzRDNzRnF6am1HYjAvVDN5UGdTenI4Zis3TC93ekpyM25r?=
 =?utf-8?B?TnpDZ2o5N2hUWnFLNHJVT3IyK0ZPZm9xamtXQVVQazhPb2pqNVRMN2trYXdx?=
 =?utf-8?B?UGl5SjZxQ3IvaHZzSmwrQlY2bk8yNWtOc3NGQ3laaHJRL2hYYnplaVBjUkdM?=
 =?utf-8?B?VGphUW9YNnNtT0JVYTFnaUtjMTUxUWs3MzNidUlZa29SZmoyeElTMXZDYjJI?=
 =?utf-8?B?SURLUitoNTV4V3RDREt2QkVoQ3p6ZVJYVUJueStDb1FEd2FlQTY1UGNNQ3gx?=
 =?utf-8?B?ajV3NENwTVBWd3pWTHpaajNWeUtWYUthcFdJbWNJSTBBL1M5OXAvdFZaZ1BM?=
 =?utf-8?B?MnFIeUN0V0JtTUVHSHhjQWJrRWEwTUwxMnhZK2FLWGpBOGE4Sml5NmF0eFZZ?=
 =?utf-8?B?TDl2SWdJaGJxWDJhMnZ0RHFxdDZURzJVOU9oVzFjamN2NHVxS1dhdWU1b2xw?=
 =?utf-8?B?SGw5YURvdlQyQTU5T3RsbkNqQUNIWjNvS0FaZmwvWFJSL21Sc2d2UUNSZzZO?=
 =?utf-8?B?QlZWNk1yTFhHeUhvWmhZUzBZK3FvNU90dE5EYXUyczZVZEIwMlRtbWJ1RVJu?=
 =?utf-8?B?K2RjZ2llODd1L3NJVUJrY2NPYTM4UVpBdk5iTkcrOWRnQkVmeDFTZXFndzl3?=
 =?utf-8?B?dnQyc09XVzUxbU5rM3IyNHF3MXcyZndTSW9XdnBpa0NCczZVaHN4aUJBeDJm?=
 =?utf-8?B?Y3dadjdKT0VmVmdiZTM2c3Z6V1F1RFlEZEgyM090RkhMQkIyWkpYUWlrZmh1?=
 =?utf-8?B?NTVhZndrVDVudFk2ckZJYlUyaTNZL2thQjdGb2VqVGxKWWVGcXIzek1Gck9h?=
 =?utf-8?B?cmV3ekNIdlpnbE5lSjNTek1LeVJVSVlDQ3dSclQvUlNBM2V1UXN4bGdtQk5P?=
 =?utf-8?B?VzVjbFFiTkM5bG9WWUxiVnFBd0wrZ3BNaURrZ245WDdmMHhMSGpNM3RmNXQ3?=
 =?utf-8?B?a1N5VWhrNW54bjVTd1J1Z1d4bE1WaDNOYnI3SmhVTHdxc09lUHZpSFYvd2hI?=
 =?utf-8?B?MGMxOUR6ckRJMlVaMDc5NVpQUnlaQ1VhWWg0dGxiUllJbkpmYU50Z0ZjVE9a?=
 =?utf-8?B?Z045Wmk1alVORVNHektucitrY3U0RHE0UkY1RDNidzJvL05DeWFMZTlqZGlC?=
 =?utf-8?B?TDRGVVg3Ylp2dllFZ0ZGT3NLQWIwc1BRSUc2QmUrbGtlRm15d25mNVdsdHFG?=
 =?utf-8?B?VWZpcThZaE8rNGVPZ1owTWpHSGl4K0xRWUNvOG9CTThoU2NoUkJacld4Q3Z0?=
 =?utf-8?B?MmJCaU1SYk9wZE1ZWG5ncTRzS2JrWElMeG5WVllncHNVU0NFK2NaUW8wVk5J?=
 =?utf-8?B?SlhUMzdNMFBwTzJYbHk1QkpwaVdSRTU5aXVIblgxMDZHMXZkcENxMDFjNHJw?=
 =?utf-8?B?NFBWUHFERnF5ZDlQNEtOQi9DUURqcGtsZThudWFGWUU5UkI4WVREL2haQjlN?=
 =?utf-8?B?dU5mQXcwVHcwREJNQ1NRQ2VRNlplZHRyMkEvQzZHZDlKNHQ2U1FVVFhyTFFR?=
 =?utf-8?B?WW5rRXZqdzBSaE1abzArbnFDbm1OSGdxNmRJNTBGTDlmTzVRR01oK1pMcVFT?=
 =?utf-8?B?M1NOYXdrTEM0RWNYc29GMjhHY0lxbTJhK29FeU9iZnJ0Z2g5eVhERGJjU0w4?=
 =?utf-8?B?U09rK2d6ck52OU9UclVZRk5PeFlXZHl4SjViTlB6azRpb003cFlTVHpsM1Q0?=
 =?utf-8?B?YVI2OVp6S3czY051RHZuVHE4ZDJBZFAvQXZ5UzJSZ0o3Z0RYa1IxZ2VBeTZJ?=
 =?utf-8?B?WC9sMGdzZ1NwbDFsRVZrbXdXUzR0cXhONjRBM2dNUCtIalA1ZGxoVFFBVys3?=
 =?utf-8?B?MzhQZm1wWWtoK0gwTnRBdUhtVTErMStJZWNwM3BGOHJCMVdwdVlFeGZXQ1ZC?=
 =?utf-8?B?eGpXVFU1SG84bVZoSWtBZENnRnR5SityWmpEd2grcWVieGxZK01oZHRuSk5h?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23045630-25db-4dcd-f103-08dc7ef66747
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 09:13:14.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V66pfBMdjfRknP43nk4ZXGjFwQzpdmGDi8jR/Y4agE/0VPyeaZhS4nrIJiJm0Ui23QFxxPk1adDOb0mw4LvAOn6sjl1mrgVIK+JmMB5yUtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7022
X-OriginatorOrg: intel.com



On 28.05.2024 10:56, Anshumali Gaur wrote:
> This patch adds support to dump NIX transmit queue topology.
> There are multiple levels of scheduling/shaping supported by
> NIX and a packet traverses through multiple levels before sending
> the packet out. At each level, there are set of scheduling/shaping
> rules applied to a packet flow.
> 
> Each packet traverses through multiple levels
> SQ->SMQ->TL4->TL3->TL2->TL1 and these levels are mapped in a parent-child
> relationship.
> 
> This patch dumps the debug information related to all TM Levels in
> the following way.
> 
> Example:
> $ echo <nixlf> > /sys/kernel/debug/octeontx2/nix/tm_tree
> $ cat /sys/kernel/debug/octeontx2/nix/tm_tree
> 
> A more desriptive set of registers at each level can be dumped
> in the following way.
> 
> Example:
> $ echo <nixlf> > /sys/kernel/debug/octeontx2/nix/tm_topo
> $ cat /sys/kernel/debug/octeontx2/nix/tm_topo
> 
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>
> ---
> v2:
>   - Addressed review comments given by Simon Horman
> 	1. Resolved indentation issues 
> 
>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |   1 +
>  .../marvell/octeontx2/af/rvu_debugfs.c        | 370 ++++++++++++++++++
>  .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   7 +
>  3 files changed, 378 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index 35834687e40f..3063a84a45ef 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -76,6 +76,7 @@ struct rvu_debugfs {
>  	struct dump_ctx nix_cq_ctx;
>  	struct dump_ctx nix_rq_ctx;
>  	struct dump_ctx nix_sq_ctx;
> +	struct dump_ctx nix_tm_ctx;
>  	struct cpt_ctx cpt_ctx[MAX_CPT_BLKS];
>  	int npa_qsize_id;
>  	int nix_qsize_id;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index 881d704644fb..272b9dd1acb6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -1603,6 +1603,372 @@ static void print_nix_cn10k_sq_ctx(struct seq_file *m,
>  		   (u64)sq_ctx->dropped_pkts);
>  }
>  
> +static void print_tm_tree(struct seq_file *m,
> +			  struct nix_aq_enq_rsp *rsp, u64 sq)
> +{
> +	struct nix_sq_ctx_s *sq_ctx = &rsp->sq;
> +	struct nix_hw *nix_hw = m->private;
> +	struct rvu *rvu = nix_hw->rvu;
> +	u16 p1, p2, p3, p4, schq;
> +	int blkaddr;
> +	u64 cfg;
> +
> +	blkaddr = nix_hw->blkaddr;
> +	schq = sq_ctx->smq;
> +
> +	cfg = rvu_read64(rvu, blkaddr, NIX_AF_MDQX_PARENT(schq));
> +	p1 = FIELD_GET(NIX_AF_MDQ_PARENT_MASK, cfg);
> +
> +	cfg = rvu_read64(rvu, blkaddr, NIX_AF_TL4X_PARENT(p1));
> +	p2 = FIELD_GET(NIX_AF_TL4_PARENT_MASK, cfg);
> +
> +	cfg = rvu_read64(rvu, blkaddr, NIX_AF_TL3X_PARENT(p2));
> +	p3 = FIELD_GET(NIX_AF_TL3_PARENT_MASK, cfg);
> +
> +	cfg = rvu_read64(rvu, blkaddr, NIX_AF_TL2X_PARENT(p3));
> +	p4 = FIELD_GET(NIX_AF_TL2_PARENT_MASK, cfg);
> +	seq_printf(m,
> +		   "SQ(%llu) -> SMQ(%u) -> TL4(%u) -> TL3(%u) -> TL2(%u) -> TL1(%u)\n",
> +		   sq, schq, p1, p2, p3, p4);
> +}
> +
> +/*dumps given tm_tree registers*/
> +static int rvu_dbg_nix_tm_tree_display(struct seq_file *m, void *unused)
> +{
> +	int qidx, nixlf, rc, id, max_id = 0;
> +	struct nix_hw *nix_hw = m->private;
> +	struct rvu *rvu = nix_hw->rvu;
> +	struct nix_aq_enq_req aq_req;
> +	struct nix_aq_enq_rsp rsp;
> +	struct rvu_pfvf *pfvf;
> +	u16 pcifunc;
> +
> +	nixlf = rvu->rvu_dbg.nix_tm_ctx.lf;
> +	id = rvu->rvu_dbg.nix_tm_ctx.id;
> +
> +	if (!rvu_dbg_is_valid_lf(rvu, nix_hw->blkaddr, nixlf, &pcifunc))
> +		return -EINVAL;
> +
> +	pfvf = rvu_get_pfvf(rvu, pcifunc);
> +	max_id = pfvf->sq_ctx->qsize;
> +
> +	memset(&aq_req, 0, sizeof(struct nix_aq_enq_req));
> +	aq_req.hdr.pcifunc = pcifunc;
> +	aq_req.ctype = NIX_AQ_CTYPE_SQ;
> +	aq_req.op = NIX_AQ_INSTOP_READ;
> +	seq_printf(m, "pcifunc is 0x%x\n", pcifunc);
> +	for (qidx = id; qidx < max_id; qidx++) {
> +		aq_req.qidx = qidx;
> +		rc = rvu_mbox_handler_nix_aq_enq(rvu, &aq_req, &rsp);
> +
> +		/* Skip SQ's if not initialized */
> +		if (!test_bit(qidx, pfvf->sq_bmap))
> +			continue;

Maybe this test should be the first thing we do in the loop or calling
rvu_mbox_handler_nix_aq_enq is required for this test to work?

> +
> +		if (rc) {
> +			seq_printf(m, "Failed to read SQ(%d) context\n",
> +				   aq_req.qidx);
> +			continue;
> +		}
> +		print_tm_tree(m, &rsp, aq_req.qidx);
> +	}
> +	return 0;
> +}
> +
> +static ssize_t rvu_dbg_nix_tm_tree_write(struct file *filp,
> +					 const char __user *buffer,
> +					 size_t count, loff_t *ppos)
> +{
> +	struct seq_file *m = filp->private_data;
> +	struct nix_hw *nix_hw = m->private;
> +	struct rvu *rvu = nix_hw->rvu;
> +	struct rvu_pfvf *pfvf;
> +	u16 pcifunc;
> +	u64 nixlf;
> +	int ret;
> +
> +	ret = kstrtoull_from_user(buffer, count, 10, &nixlf);
> +	if (ret)
> +		return ret;
> +
> +	if (!rvu_dbg_is_valid_lf(rvu, nix_hw->blkaddr, nixlf, &pcifunc)) {
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	pfvf = rvu_get_pfvf(rvu, pcifunc);
> +	if (!pfvf->sq_ctx) {
> +		dev_warn(rvu->dev, "SQ context is not initialized\n");
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +	rvu->rvu_dbg.nix_tm_ctx.lf = nixlf;
> +done:
> +	return ret ? ret : count;

I don't think we need goto here, just return err code under each if statement
and return count at the end.

> +}
> +
> +RVU_DEBUG_SEQ_FOPS(nix_tm_tree, nix_tm_tree_display, nix_tm_tree_write);
> +

<...>

> +
> +/*dumps given tm_topo registers*/
> +static int rvu_dbg_nix_tm_topo_display(struct seq_file *m, void *unused)
> +{
> +	struct nix_hw *nix_hw = m->private;
> +	struct rvu *rvu = nix_hw->rvu;
> +	struct nix_aq_enq_req aq_req;
> +	struct nix_txsch *txsch;
> +	int nixlf, lvl, schq;
> +	u16 pcifunc;
> +
> +	nixlf = rvu->rvu_dbg.nix_tm_ctx.lf;
> +
> +	if (!rvu_dbg_is_valid_lf(rvu, nix_hw->blkaddr, nixlf, &pcifunc))
> +		return -EINVAL;
> +
> +	memset(&aq_req, 0, sizeof(struct nix_aq_enq_req));
> +	aq_req.hdr.pcifunc = pcifunc;
> +	aq_req.ctype = NIX_AQ_CTYPE_SQ;
> +	aq_req.op = NIX_AQ_INSTOP_READ;
> +	seq_printf(m, "pcifunc is 0x%x\n", pcifunc);
> +
> +	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
> +		txsch = &nix_hw->txsch[lvl];
> +		for (schq = 0; schq < txsch->schq.max; schq++) {
> +			if (TXSCH_MAP_FUNC(txsch->pfvf_map[schq]) == pcifunc)
> +				print_tm_topo(m, schq, lvl);
> +		}
> +	}
> +	return 0;
> +}
> +
> +static ssize_t rvu_dbg_nix_tm_topo_write(struct file *filp,
> +					 const char __user *buffer,
> +					 size_t count, loff_t *ppos)
> +{
> +	struct seq_file *m = filp->private_data;
> +	struct nix_hw *nix_hw = m->private;
> +	struct rvu *rvu = nix_hw->rvu;
> +	struct rvu_pfvf *pfvf;
> +	u16 pcifunc;
> +	u64 nixlf;
> +	int ret;
> +
> +	ret = kstrtoull_from_user(buffer, count, 10, &nixlf);
> +	if (ret)
> +		return ret;
> +
> +	if (!rvu_dbg_is_valid_lf(rvu, nix_hw->blkaddr, nixlf, &pcifunc)) {
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	pfvf = rvu_get_pfvf(rvu, pcifunc);
> +	if (!pfvf->sq_ctx) {
> +		dev_warn(rvu->dev, "SQ context is not initialized\n");
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +	rvu->rvu_dbg.nix_tm_ctx.lf = nixlf;
> +done:
> +	return ret ? ret : count;

Same, no need for goto

> +}
> +
> +RVU_DEBUG_SEQ_FOPS(nix_tm_topo, nix_tm_topo_display, nix_tm_topo_write);
> +
>  /* Dumps given nix_sq's context */
>  static void print_nix_sq_ctx(struct seq_file *m, struct nix_aq_enq_rsp *rsp)
>  {
> @@ -2349,6 +2715,10 @@ static void rvu_dbg_nix_init(struct rvu *rvu, int blkaddr)
>  		nix_hw = &rvu->hw->nix[1];
>  	}
>  
> +	debugfs_create_file("tm_tree", 0600, rvu->rvu_dbg.nix, nix_hw,
> +			    &rvu_dbg_nix_tm_tree_fops);
> +	debugfs_create_file("tm_topo", 0600, rvu->rvu_dbg.nix, nix_hw,
> +			    &rvu_dbg_nix_tm_topo_fops);
>  	debugfs_create_file("sq_ctx", 0600, rvu->rvu_dbg.nix, nix_hw,
>  			    &rvu_dbg_nix_sq_ctx_fops);
>  	debugfs_create_file("rq_ctx", 0600, rvu->rvu_dbg.nix, nix_hw,
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
> index 086f05c0376f..5ec92654e7ad 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
> @@ -429,6 +429,8 @@
>  #define NIX_AF_RX_ACTIVE_CYCLES_PCX(a)	(0x4800 | (a) << 16)
>  #define NIX_AF_LINKX_CFG(a)		(0x4010 | (a) << 17)
>  #define NIX_AF_MDQX_IN_MD_COUNT(a)	(0x14e0 | (a) << 16)
> +#define NIX_AF_SMQX_STATUS(a)		(0x730 | (a) << 16)
> +#define NIX_AF_MDQX_OUT_MD_COUNT(a)	(0xdb0 | (a) << 16)
>  
>  #define NIX_PRIV_AF_INT_CFG		(0x8000000)
>  #define NIX_PRIV_LFX_CFG		(0x8000010)
> @@ -442,6 +444,11 @@
>  #define NIX_CONST_MAX_BPIDS		GENMASK_ULL(23, 12)
>  #define NIX_CONST_SDP_CHANS		GENMASK_ULL(11, 0)
>  
> +#define NIX_AF_MDQ_PARENT_MASK         GENMASK_ULL(24, 16)
> +#define NIX_AF_TL4_PARENT_MASK         GENMASK_ULL(23, 16)
> +#define NIX_AF_TL3_PARENT_MASK         GENMASK_ULL(23, 16)
> +#define NIX_AF_TL2_PARENT_MASK         GENMASK_ULL(20, 16)
> +
>  /* SSO */
>  #define SSO_AF_CONST			(0x1000)
>  #define SSO_AF_CONST1			(0x1008)

