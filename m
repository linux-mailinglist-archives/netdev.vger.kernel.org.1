Return-Path: <netdev+bounces-86035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2348189D525
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 11:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CCB1C21463
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8242A7EF02;
	Tue,  9 Apr 2024 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moBoBHiI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EF77E777
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653767; cv=fail; b=T9H6O1bX+DoKAZxIXEK7IL3zIuQKCV91bBvcVhBQsU+xLAbcaGdAjWmXktR19uwDYsW4yhvnnQLhPOCOKZaAPoVJW9E2dGeLxvv0UR+uXhI5f3UO0GYlQ2mT55RdyhXyd4SG3K5n+i5urGDun6RLPPbpv5WPEmrtOsvCTmi+/qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653767; c=relaxed/simple;
	bh=/Y7yDPUSb7DM25q91kbHjxpGwaZP4w31w+dhSml2HKE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uBUH7rLXchn8bQLfaiJeudTeXEhAf5hWddSJCBkBA9XkB2FFOaV6NHE0JWyL9uqCMM3yfI7rnzNf8oY7weeQfJ0iANAnnamunRFAN7TdCMlecSU3kvCrA8PlD29FtiTqJ7x/r3JgBGE54MpeoONfb26VE7kFjiJ2vymE3Hjp3eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moBoBHiI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712653765; x=1744189765;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Y7yDPUSb7DM25q91kbHjxpGwaZP4w31w+dhSml2HKE=;
  b=moBoBHiI4VoLWRdj+44amXLhbUxbpF4bEKE7czECDj2ELhpuqfSX3nLQ
   qhCIhPDsFAW6DVb9o4kyBLIYQ4lYyIil4DGKHBiLORm6tIlRhdnOBdRSD
   RrcsFvCf9F3+RufhighKo8fuGoQphYmDlxEopx/Kqk9cM5Z/7y6klgcHA
   mGol2RCoQ57+ivi3aGpZ6+0ioiP0vUh+9fAGTrGOVwb75Xh2CzIlP3SDu
   6+Wyh2lzU/DcC3rRNOMFnkBzWk3XZt6OfrW9tJgfEt0JWjjVarT33Jbgs
   3mK0OXmBFA3U9W5FtppbpMS66pGNyU7L6MkbzOhKmzjQMs4k/A8vi1REs
   g==;
X-CSE-ConnectionGUID: XWcMCHJfRMOwBPQxanZlFA==
X-CSE-MsgGUID: /QVQun3jSF+KELFA3E97GQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8531766"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="8531766"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 02:09:24 -0700
X-CSE-ConnectionGUID: bCZG+o61TZ+BDFJRusYn0Q==
X-CSE-MsgGUID: 8IkFw6slSk2RmKymGJ6SSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20212435"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 02:09:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 02:09:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 02:09:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 02:09:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwyS9SXOo5k2r3xfm+qL0Dbjld4exn2jnsKWaG+srgh7LMlTwePjophdAO1/ADbTamNLEbTZhx7kzN/c2AooqeTyaKwsbwJFaVbantngwG86/OCPmbh5b/gVuiQsjjjWmoIXYTsGeCDOajl+drIqExdHVfFY4yUDc55w5qmxCfCcV1C9oIrhECORHcFMj5evGp2FWUEipx5xWLa6DuA2yj8gt/IvPLaShTZ2uB0YBxKH5+RXCp/sMF+m2/qJqpOOsGL/fNOx8L50Af3/6l7l3tSATE2nLVocEwNENOMAKQ4fe193QcDxLXiHwiUpLOWGZffw0NNfzGbw4Zu2uhsMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nD9K3XZAdCXNyT+f/GL4BWIlJ9KbRBP+sWsGLZH8L4=;
 b=JqiovgfaLRum4K3HLQIZ9XuUbVpinl7lJ2RYUeaQBT7/tW7z1NLiLNR5H6Hifk5tXsHMPUqxt+EKx0VfWL0n5PsG4ZOn1xMzrvkhb7HdgTWkrUeuQdE0OPeXLQc88zkbeg7zA7W/Irecq2zktSwKPFAj5vbxT9nNn/wdvyVXL/bbinVRE63QJThBi3LJhiDvnAmD3f+tqOnRp/MfG0NUYNWHPLEa1ls8jvuJF85L4foaq11hf5t8u4f0Bs/PeacnCIHeTXgmGETP6GiAb6Sa31t/8pYscjqF6nbqXVUO1REiSL0/OfjER397jtkq7MtVxWLn2PRJGoymtFdrXXdYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6521.namprd11.prod.outlook.com (2603:10b6:510:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 09:09:21 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 09:09:21 +0000
Message-ID: <03660271-c04c-4872-8483-b3a1bfa568ef@intel.com>
Date: Tue, 9 Apr 2024 11:07:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 02/10] eth: Move IPv4/IPv6 multicast address
 bases to their own symbols
To: Diogo Ivo <diogo.ivo@siemens.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
	<danishanwar@ti.com>, <rogerq@kernel.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
References: <20240403104821.283832-1-diogo.ivo@siemens.com>
 <20240403104821.283832-3-diogo.ivo@siemens.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240403104821.283832-3-diogo.ivo@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::27) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6521:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnGrpM4juHWhqSjjb2A5vR9YekCfVXNL9knPBLreRfZbCvRZV+tokOpB8lxL4bVFyurQG2CgDrAdQ14RCKk/5k4O2+15VRbDfXv3D2y01LArBgZVIWoKrpA2xZUwKX1HQlu0mlILBOV1FkSdldXZAHRpT65ecVP3BfO1W+SxyKbSXlDq/GZfVDiY1MD+qmp73P71K3dd9zbgccIIV+G0VayDn5rFsKvFAKB7JlxQAFGLpPu6uHkcLVp1XpNk1/qj92hKPhtpFxbdNHj1CGy081fFgKJts7E1YmNSSO86xXSEJWKphDaYaw+MNPzJtafD2FMyfddqaZgMFKjgFtjba/CtzmgIDrJejJdWQ+CtU+OJBLQ83c100og89slYOl+K5FcUNtttr9TFnZL6XLjpRqCU2SyHTwGvU7xg5qV4rnUIEly0xQSWURGF/rb6hbx9YGK2GBDahJEDCkqVfWCVYb9RtVuJa/YjHNWO1PY15uMbYEVuLPOW7prthqEa9NBJygwLltrUn5AZW2LXc/wd+5I2BtJdBcx+5fxPC3SwH1sBwUrZJSm1hIlKeCdEdmDplIzPyd1HkS8T5oOOphknf3bBY5VGnn4emE7Dq5ZDQ2f0P5nrnK+ql4XLU/We6Ner2Eqpb8OoGqOJT8C97yonDswP79/7qJZt7qHR/gCjH8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW1EWGhZQVZVdC9iUmtXbTZIL291djQ2MEkyWENrTVpYMDF5cDBNQXJWK2lm?=
 =?utf-8?B?UlVCcGp3OUpJbXlnZEZVL0NTN1ZROUk5c0I3cmFjYTNsSE5aaU02ZmZmVDhz?=
 =?utf-8?B?aERTNmZ4OU96SzUvay9qVWJERnQxN01Sc3hxL1prL2YxeDBJT01vdUxZN3g2?=
 =?utf-8?B?R1JNV21zOW50OUhBQ0Mra3JpMlE1K3JZWkhucHR5b1FnbDUyMkxLRVU3Q2J4?=
 =?utf-8?B?cnVpYjNYZS9kS3F4ZzBiMEs5ZjZhdjl4WUZKVjl0NmZEcm1HUVZnQ1d6bTNB?=
 =?utf-8?B?Q2xvbEFJVzVTeElJeHU3TVhra1QwTy9xdnE2bGZWTjZ1QXVRTFpaVmx0VW9S?=
 =?utf-8?B?RWdZbTczN1FuOFh4aGthVVY2Z1hnL1BoOFREL3FMNnBVK09iTE9qcGx3Tktt?=
 =?utf-8?B?MUp6alpST1VDVG5qM0NheVJ6aURtRW5mVlYzRktVMW1tWTZDaFNBL25HQWd6?=
 =?utf-8?B?NERFWUNUNGhCam54SVByK0FyeVQ5eTBaVWdZL2ZoRmZhOGVQSmc1QlhSeGYx?=
 =?utf-8?B?cmw2S1UvL1ZiYjdIbVd3VEMzK2NyZ1dsVFZYKzFNRWR2VXlWTFYxWUZJd2xU?=
 =?utf-8?B?SnQxVHpXUlBsNDBOcnBMQWtsSnJwSFJpUHkxdmxaK1l1S0o3S2tydHl2clFH?=
 =?utf-8?B?TjErRzR5eUhSeUZXT3hoUWRIQmx5OGpobGFYQlNEOFMyL1RqRGo3NFJkcGto?=
 =?utf-8?B?N2hieTk2bmtvcGEwOFFBbEhzQWNjWXlxdDhpbDNHZzBjVllteWRGLzJGWWQv?=
 =?utf-8?B?amNuVjh4ZHFROWxrN3lDb1lJNzIxM3RKTEF5YTYrbWJ2d2ZOSGZCNDM2Ymt6?=
 =?utf-8?B?cWF2OUduWVpRY1FOb3NLMTZNbXRyc3g4WnREMExZcG05Rkt3SXpjQmlnK2pm?=
 =?utf-8?B?aU9HRzk1d2hXSDhRdnpzYkhvWmd1MkltYXo2TFV2UGIzV0Q0Qm15TG8xcFF0?=
 =?utf-8?B?M3pxbUxpMlBoYW1aSjZCUzVzdk5qOURhRHg5MWV5TmF2MFNNTThjNWszaDYx?=
 =?utf-8?B?UEVra0ZiWmxQMGVGQTZTOUhmTDN2Vmw3Q3hzanBnWTR4Nk94NGxMZG9STlNl?=
 =?utf-8?B?SzVDbVpleVJESDIrQWhIZlZhT0xaYzN0cThyN0FyYnhqMkZ5dHpjekZOVE9M?=
 =?utf-8?B?dmFCd0p4NWxYeVE3Um5UdElKazB5QTg4MXpOa3BvR1NGMGs0OHp6OGNSbUlm?=
 =?utf-8?B?dEcyNW1STGdzc0NTeE5LV0pqdHlHUkpYMHViNi8vZFF3cFlxR0ZsenZlVFJD?=
 =?utf-8?B?K0pXQXM3OG94ZW9JYTQ5eDN6VmYwWFZ4YUNiSDJ6WXVqalJuT2RaMmllb3lJ?=
 =?utf-8?B?OUUvcVIwM0RzbS9JMnBRSGIrMFpraU0yN2NkcDdGZUVsbTZRUFpSdllsSzVi?=
 =?utf-8?B?NjVNc3M5T0VlUmo2bE9kZERiT2hGZzlYLzJyUndFSkVTYzFqcFloNzcySUhV?=
 =?utf-8?B?bzh5eW4wQ0ZZalA4dnVuOHpMZmlIZ0dRTFFqQ2tiSUNSQ0VZQ1p5QUFHb2Nv?=
 =?utf-8?B?aW81MHJkYUlCRkF4dUdQY0tVTVBEdWt5czZGM3RSaHhUWmVmeVkzbHlGWEx6?=
 =?utf-8?B?VmFLdDZ4ejErYWZ5TS82NjZVKzBwQjlYK0N3MDFhVExtTzhWNW43S2F3L1U1?=
 =?utf-8?B?MzZtOWJpWVA4RVo0bXNsZUJpam55eHdYR1pXbUlTL2dlZ0Vnd2RIUDNRUEs2?=
 =?utf-8?B?NVRYcVdTeXJoL1hURkdrVXJJM0NGamtmall6cmpkYnVlVzQzdUxyQnJobktG?=
 =?utf-8?B?UlFhYWdESDRmTGFBRnkvT0cxWi9GcnZDSHFWSnJ2WDA5UFliZFpteE5JVlBo?=
 =?utf-8?B?MEdJbmNTV3BzMG8zNU93M3FiTDZicmJ0MFNpVHVBamJHSUZRblp4MURMOHU5?=
 =?utf-8?B?WU95eUZzU3IwY04rN2FURnYxMVczejd4UGpKMjkwMU16WUJKeGYxdlpMWTZi?=
 =?utf-8?B?RmxndTc3ZlVIaG9tWVJ6YnhrUjBaSDRmNi9HSndVc1h0akdLQVg0Sk00aHgw?=
 =?utf-8?B?QTdwY1FTcmkxZHZQSXVWZ1o1QXpCSDNySytXaHhWK2NDUVFhbjJKS1JYbmtO?=
 =?utf-8?B?ZHB1MU8rOTMydzYzMkRyb3N6aU5OUE1KL2JsWGxJR21BTk5Nb3p2OWVUU2FT?=
 =?utf-8?B?WFFDTFQ3cGhXZFUyenNsSlorek9yb2JTS09tanM1RTkrR3lmSVVrZFB5ZU5n?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9130bce-d909-41b7-953f-08dc5874be09
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 09:09:20.9759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dhoTTa3lmZrv+e41tiJwdOaeMw0F60SBypx3hbK4FKajqNMgRzL0dnKm0qOWyi/4oBrcl3+jO3G4pgmysJjHAba/SkbTj5N2vDiM/KBtU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6521
X-OriginatorOrg: intel.com

From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Wed,  3 Apr 2024 11:48:12 +0100

> As these addresses can be useful outside of checking if an address
> is a multicast address (for example in device drivers) make them
> accessible to users of etherdevice.h to avoid code duplication.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Changes in v5: 
>  - Added Reviewed-by tag from Danish 
> 
>  include/linux/etherdevice.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
> index 224645f17c33..8d6daf828427 100644
> --- a/include/linux/etherdevice.h
> +++ b/include/linux/etherdevice.h
> @@ -71,6 +71,12 @@ static const u8 eth_reserved_addr_base[ETH_ALEN] __aligned(2) =
>  { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 };
>  #define eth_stp_addr eth_reserved_addr_base
>  
> +static const u8 eth_ipv4_mcast_addr_base[ETH_ALEN] __aligned(2) =
> +{ 0x01, 0x00, 0x5e, 0x00, 0x00, 0x00 };
> +
> +static const u8 eth_ipv6_mcast_addr_base[ETH_ALEN] __aligned(2) =
> +{ 0x33, 0x33, 0x00, 0x00, 0x00, 0x00 };

I see this is applied already, but I don't like static symbols in header
files. This will make a local copy of every used symbol each time it's
referenced.
We usually make such symbols global consts and export them. Could you
please send a follow-up?

> +
>  /**
>   * is_link_local_ether_addr - Determine if given Ethernet address is link-local
>   * @addr: Pointer to a six-byte array containing the Ethernet address
> @@ -430,18 +436,16 @@ static inline bool ether_addr_equal_masked(const u8 *addr1, const u8 *addr2,
>  
>  static inline bool ether_addr_is_ipv4_mcast(const u8 *addr)
>  {
> -	u8 base[ETH_ALEN] = { 0x01, 0x00, 0x5e, 0x00, 0x00, 0x00 };
>  	u8 mask[ETH_ALEN] = { 0xff, 0xff, 0xff, 0x80, 0x00, 0x00 };
>  
> -	return ether_addr_equal_masked(addr, base, mask);
> +	return ether_addr_equal_masked(addr, eth_ipv4_mcast_addr_base, mask);
>  }
>  
>  static inline bool ether_addr_is_ipv6_mcast(const u8 *addr)
>  {
> -	u8 base[ETH_ALEN] = { 0x33, 0x33, 0x00, 0x00, 0x00, 0x00 };
>  	u8 mask[ETH_ALEN] = { 0xff, 0xff, 0x00, 0x00, 0x00, 0x00 };
>  
> -	return ether_addr_equal_masked(addr, base, mask);
> +	return ether_addr_equal_masked(addr, eth_ipv6_mcast_addr_base, mask);
>  }
>  
>  static inline bool ether_addr_is_ip_mcast(const u8 *addr)

Thanks,
Olek

