Return-Path: <netdev+bounces-131615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C75A98F09D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 195BEB24094
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464A719D8B5;
	Thu,  3 Oct 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYnNQWlJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999A519D885;
	Thu,  3 Oct 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962738; cv=fail; b=NHQncV9RKRkVlNUart3o7F6B9+S2GRZNObjdN8lNhRPjRDaRZswhbayhRZ+XA1c/KKTmKk+ciE9CK8MRJjwp6wGN3W86/HxGnFInGieuaTFvyH89bb1cj/RZmapG1xwloIuVO/Q/mnp+pgms66aEt0pTEjzDxpy8orygf4R0IqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962738; c=relaxed/simple;
	bh=3f0ERnGlKJPGqBndiEK/sSwoqCqbRT9aIO+MlkWF7yI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SCCJwVOK29iI6M5xz9o7BuuXYU/ZowCHygh2qqDm/J+wSZIRyx2+h9y49vwOeOfZCPDjgyDFLsuEwNoH8HTWwuFInYnenTLnysL/QcI+zA2ITfonPdUZ/lxJqQaM82vgGgKE63zXBP1GNeztXG5qZiO4d6+Hxe6lb6bVrZXgdLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYnNQWlJ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727962737; x=1759498737;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3f0ERnGlKJPGqBndiEK/sSwoqCqbRT9aIO+MlkWF7yI=;
  b=iYnNQWlJXavG6w5F4pSPoNDk5Dwr5aAKRdrbgC2xZma3yJohLoAQBFYz
   iADt4tQ2Q1grul1purm0YGCGuNQaTOBkNW24lTuUCVhRKf2ihs+7MZefq
   +Mc0WlhhPEaKmJOmgMlxHnWWsQg3ZNVUm+ARg1W69MCsbZ6W19RwcKsNd
   ABF1j6sj41O3Ho2V8raDLacjw51Y2Qolr8ecG9FhAgIU8kSWgkxTIqV/D
   hfRS++6u1FdWf65uABLFivHlUoYd44r7J3IKfASnIf1i4qLMug6FlPQdD
   PS8EgPQBAGdsjhvNPDoRA3Xyxahpf7uS+pV54SyFMJUKNAXiM6yE++3ej
   A==;
X-CSE-ConnectionGUID: yQyjnUJyQiuTWC4C7RaTLA==
X-CSE-MsgGUID: zskegcZYSPeaj2fmGRCkWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="38515004"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="38515004"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 06:38:56 -0700
X-CSE-ConnectionGUID: CTLrjG0PQtaeZcJX7AzFUg==
X-CSE-MsgGUID: okuruxzPRSGrVd0lAwcedw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="75143470"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2024 06:38:55 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 06:38:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 06:38:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 06:38:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 3 Oct 2024 06:38:54 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 06:38:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSMDehmXqUGr8v2k4sqB0oZAZU0HzfS2BU9oSDbyO6ysAm9FIUVOiuvQTxxmLpSXY4mBcnUv1T9SHlKL42o12Shzqh8vYxTVp42ldCqpyHnPnWglLbECjJSMBJFM/pkkzluQe2ejxoIqVjLyHf5zqlRMi9oCwnzgryszpaT1wYiVxNcwNwwfClCrUdYiOHin87bhat1iNS5H/BjGddyFhqQsBINLtv+iaaN+cowUkrwzicCJBIeXHRBVLKVsnfMVD5jSlX6Lb+wuOOX8xIlRcms4tzyXJKXxHVo1aW+uS6m2+tTnOxXuM6aiILyLFFv6RPixMW+OhaRkNDwC6XUzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69WreUVp+bF9w0YiiwG+imLXICO2cgPcMH1QgJt/JVw=;
 b=jn4oHAcLGzfsS52WXRgmqZtmkkwIRvwBVV1L9oudmnKz4u4HB2/H8lNdVCqXPvgJU6uxpCWj5/8r577yPiXqBleg/pHCG70jHztsIZk8bXr7lKUuka/vAs1s1+8g9YP3tdX0GGpdupkUGhEo3TfSXvk0CAhGv2ynyYciWqRG/zK4ZH2p+c8uYHH7Ycmo50ouWoSOM/pk/3Tvzr53j2FlIWnaicDwnAK3Oebfh4E85wnUNSWEjEhF/IzNUizQGl3V1sZhiEwmOqFvfM22cvhH6xD/LEDT/TAlckc6222uFf+EkhAszU+H7mpvKYU78I68/SDBUc1gesv3vmgXu6xsdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ0PR11MB5136.namprd11.prod.outlook.com (2603:10b6:a03:2d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 13:38:52 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 13:38:51 +0000
Message-ID: <e242741e-2f9f-4404-93f9-83e8971ace7a@intel.com>
Date: Thu, 3 Oct 2024 15:38:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cleanup: adjust scoped_guard() to avoid potential
 warning
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: <linux-kernel@vger.kernel.org>, <amadeuszx.slawinski@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	Markus Elfring <Markus.Elfring@web.de>, Kees Cook <kees@kernel.org>, "Dmitry
 Torokhov" <dmitry.torokhov@gmail.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Peter Zijlstra <peterz@infradead.org>
References: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
 <Zv6RZS3bjfNcwh-B@smile.fi.intel.com> <Zv6SIHeN_nOWSH41@smile.fi.intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <Zv6SIHeN_nOWSH41@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::26) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ0PR11MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bfc400-a96f-4050-8195-08dce3b0b7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW9tSW1YUTBablBiL2pDaER3V09nTEdqMTgrZzJRa01Za2tlclE1UXdNUHlR?=
 =?utf-8?B?MXB2Sy9RTDZtQlFsa1Z5NEJwOHhzK2VGUXZVdU9WTTByUElLcy9KL1ZvbjdY?=
 =?utf-8?B?WDgybHE2ZUpQdUQxaWpOekN0RVJwR0MvR09pZ1U5d1ZzNDhFVTFTREdoTFdn?=
 =?utf-8?B?bnJRSzQ1QjZrcHFiQ2RXSXhFdVR1YUVpaE5Ud2VVcDFlcjJ1RVY3YW4xUjFj?=
 =?utf-8?B?bVFrMWI3TjlkaVNpWEEwS0JBcFp2WWRmMndMd1pHNUE1UjJIdm9OVGdTRTRO?=
 =?utf-8?B?UmZqR2JiejF2aXVrbUQ4TStWdWxRenhPbmdjZU55cldKak1PTVFHZVFtck9x?=
 =?utf-8?B?QXJUNFpnOXhNbGt0eGVXUHJlR3BEejRSd2ZQVlFVbEpFams1Qlh6aWdLeTA1?=
 =?utf-8?B?TFZqQ2JlbTN5YzlFdTd6U09rWFcwNC9GZDFmc2pCZ2lObk9WRWI2OGJhdTJC?=
 =?utf-8?B?YnhKVFA1eW95OGp5ZDMxRFNCSmNDNlpWcXY0REhmRjFKZVpudE9NMEtnamtD?=
 =?utf-8?B?V09FZzBQL1dpYUdRYmNCSXFncnJSdUVjWXpzZUJwelY0ZjdrYTlFRGFtdCtp?=
 =?utf-8?B?YzVGRGZjT1FWU3ZDbUlOMytrQmd3YTNFM3Z5QWZsVUlTN0kzZjY5N2lNTVZt?=
 =?utf-8?B?RDArbDUweEJXSUpsUFZiR2hBbkxtdCtIM2hrVWRWb1pSMDJ3V3RSQjlxblJE?=
 =?utf-8?B?Q053dzg2Vy9oRVEvc1dGeU1TRGkrTjEzZm5wd1lHOGxCYWtqT3VhdmxMVFZI?=
 =?utf-8?B?anlyelB2WjBzUTVlcWE3TUxBSndRZ0VQWnlXejRwYzFNT2o5dlZreGlMcW1S?=
 =?utf-8?B?cE1uTmhoOWoxNVloMTdhWDFyODZieC94VkM1OGhaY280YWtqM0xuVmZsczQx?=
 =?utf-8?B?bnl4QXZkcmlSK1VSbTRFeWNMbmxVbnBJTFByeGhnNkNaQndKUTNXUko1bzBy?=
 =?utf-8?B?SDRoQjZrVjdBaHNzQ1RaaTdhQTVydThONERrZWxQYnYyVzQzR1JvQjRnb2th?=
 =?utf-8?B?bzJ3WWl2bFRsa2QwRlBTbFQ0VmRoK29acVpNcVQ0Z3RnRE93UkxpdVNQMlRU?=
 =?utf-8?B?NStINFpLZUtPS1lUdmdWMjk5SkV1TExPUnJwb1RrLzVBRVArSXZnMkRWOWx1?=
 =?utf-8?B?TXRSaE1lRjZwLzBOVmVqMDEyR3BadnIzQ3AwczBKYkNSYzE1T0crMVJYKzQv?=
 =?utf-8?B?SnBTL3I1b09GaXRIcGtjMGtxK1BPMUZPY0hBT1hPVnN0R1N4eVp3c0o0aVJz?=
 =?utf-8?B?RHY1TCs3NnJTc3F5N1lsOTB5YVhRd05BWnpYYU5JT2dPYUJCVm5MZGtCRXU2?=
 =?utf-8?B?WWlHYTF2V3FvSHV6UGZHV2ZaNFN0K21TcFJ1d3l4SU81dldWY1BEcGpIVk9P?=
 =?utf-8?B?V1Z5QVhDdnVyVTF4NEhORG90YVowVjlCUVBQM0gvYS9rRVlVWnBHanE0QXBx?=
 =?utf-8?B?MHhNRUpsWjFGY0VIUmU1NzV6ckpyZ0tucmdPVjlzY29NbnpPM2VteEkxUlNs?=
 =?utf-8?B?bm1jcVpOU1lWbVUxM09MQ29BamZ4TDlLU3VlVFdxWXpmYjFLM1MweWEvbkx0?=
 =?utf-8?B?WE9YSUowWVhWOXAzRFF1NTV0b0JKQUdhSVhFTXpmd1E1Ynh2OGVpN3VCV3Uz?=
 =?utf-8?B?a3dBWHo2bFhTVUFPbjVVRktTV3JKVWFxMGxpSVoyb05aZ1FCT1MwSXUvUEE5?=
 =?utf-8?B?UFJiYWp2WXdyMDZRVVk4Z0kwV1VCT2NVUHZPcW95dkFPcE5TMFg3RHhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWU2b1VWakFqTzl0czJsazRzL2pRSGlhUnBhTVE0Y1dNaEJCTEpzNWlvOU43?=
 =?utf-8?B?VGttMmNlelRIanVsM3plaVQ5TlJwV0hVQXg1WFBkbk1WdDk5dVRrb0doYVlr?=
 =?utf-8?B?cE93b2ZhMHlxUzR5V0RiUnd0MTUwTk1kcUZkcjhremtoUXcySGV3dTh0a3Zq?=
 =?utf-8?B?SC95QTJNUDNUNThxVndSbDI3am5TTXNid3BvTGdsaG5YazJEUzJJUmlJckZQ?=
 =?utf-8?B?QVppVjdqTHJMd1JZbkVKRUVrUDlmMDVpZG1oeFQ2YW1XeUpnN2pvYTJKZnYw?=
 =?utf-8?B?U1VDa1U5a3Rodk5HVTJPTlNzWEVidll6WFBuRXpMM3dmTFM0bDFJSXg2M2hR?=
 =?utf-8?B?S2hZY21GT1pGN1JLb2wzdDVTV1pVWW5sM25yelRDSk9oLzN5NW1TQlY2QVUw?=
 =?utf-8?B?d0lTeHVqY290cDlNemFaUmZMeWFhbGxFZ0ZXeVlkZGo1Mzc1VXVObEdveGRa?=
 =?utf-8?B?c3A5K3htLytQQnYzdmVTUm9sMWt4T2FWOWF6djh1RVlEdkNQSkJzenFVZGVj?=
 =?utf-8?B?OVVQeWp2cGxNbEJUcGtFWVplRThUUmpqb2JTTmZHMUpiYmc3aVZnUjBVTmtn?=
 =?utf-8?B?dEVHRDJkVzVzSUZtWll3bEpqUE1qVjRrZXN4M05EL3hTQmx2Nm1Cdk9EVWVz?=
 =?utf-8?B?TkxQNFBwQlhmalFGajFwN1FhMlcwMUJCbGZBbnJNbUYxTyt0N0VCdVlRUHRV?=
 =?utf-8?B?K0l1WCtXWlZPa295cklQTi9zZ0I3S3pGQ1VKalNFZm80OWNSVGdYVVZ1SkdQ?=
 =?utf-8?B?NVRBZEJEZ09CTCtKSE9aUXZNUExDQTM2Q1g3M2VGVUVmaDdrSVpvY1pTcXNq?=
 =?utf-8?B?dnhzTTFURU5EYkY5MDFTSEFyM3E2cUZGQWZPQ0sxU1lYNnF2aHNVaXdZdW9l?=
 =?utf-8?B?Q0tPaXFxWHRkRTd3ZW8zR2FzYkhTNXUzZWpPa0UzSUxrR2twWTluZTFFdmVu?=
 =?utf-8?B?cjdNTE1XRzZNK3EvNXNBZ1pza0NIYWpOR2hDRzdUTXFLSElNWDFuUndVNGF2?=
 =?utf-8?B?bm1USFJwN0lHaFk3WjdKbGU0YmdGSnBGZlRkOHg1YUovcVVKczdFam9PRWNP?=
 =?utf-8?B?MmxNU2RlYlNXczFZTXBtTTBvRUdkS3dyeXI3UkhxeURWK3RNTFRXWmp0c0dJ?=
 =?utf-8?B?cE1rNCs5Tm85QisvRmlpM2JQNm0weUpvSFJWWkxLVDZWUkYwbHk2MXNWMGpQ?=
 =?utf-8?B?c0lpeCtrS0F5SnNabUFSa2F6SzdoTW1DZW9UdUpLaThpVkZseTFWS2tvQ1B3?=
 =?utf-8?B?dWwxVlRUSkxmZkFZVDViZzJVVWk5VFlYTHpoR1IyVGx3RW1ISVNBcFhCc01Y?=
 =?utf-8?B?MWRkdnZrSEFBUWRocnlESlJ6US94bUhkUmJxSFdzbHpDOEtYWkhKTGQzckxz?=
 =?utf-8?B?TytoSlJualE0UDF3YXNweHJPeXUvRmh5SURTeElGanhkSTV5b3ZPclNTdndP?=
 =?utf-8?B?YVFyeXQ2T2JJMFhKQWIrZGNhdWV3TzgySk5mMStQbW9JL3hoNjVaQktxTkdx?=
 =?utf-8?B?ZUI4eFY0UDJTUWN2bWpPUkk3WldNYy8yL1pNd1Y5aWhMRERSeFJpZHdhcERX?=
 =?utf-8?B?emFITFBSa0FBdERwZ3FMNkZNNUx1MlhOdHNmTDIzd1ZPUjJNWVg2KzQwb3BI?=
 =?utf-8?B?OEQ3WEcwMmFaZURsUVNPakljckgrU2ZLRDU4dHhtSDBnQ0VsMWdWOWEyWnpP?=
 =?utf-8?B?Vy9wMDlhd2tnNnZmdXJpWndTRFVvOFFab2VTSXUwbGsvdHdBV0lKYWMwRGNt?=
 =?utf-8?B?bE9sZ1lTbU00dHFjYkxwdXBVTG1rYjhrR1BveTZzZEY5VWh2a3BNRVR1cGQ1?=
 =?utf-8?B?Q3k2SHBLWTBSRHNQdFFvRHpzUjZDS2Qyano1N0c0c2FMWjB4VnBxY2hNU0oy?=
 =?utf-8?B?bjlkRW5VR2s5YkgxbldkMmN0b2EyN3AvWFZ2aXBrQnFkVjdDZ1Fva1dRRWpR?=
 =?utf-8?B?cHkxNi92N25LVEl5NFRxd3U4MHF3OW0ySEZjS0FSUWdqdmFkaHQwUEJZVTZ6?=
 =?utf-8?B?T24wWmVUbi9GRHhOS1NjVHVnbEJSR1VhVGRkRG9PQ2Q0Vk1WUmFDM2VrbjZJ?=
 =?utf-8?B?VzhJcnM5K1dZTG03bXhMR1BoQktBVjNnREEzV0RWb3ZTbHR5cHlxYm5LQy9n?=
 =?utf-8?B?bjdKRWM0cnlZYXk3U1hWQVJ1ampIWWJFWGM5end5TFo2d1gxTFRTckhMbi84?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bfc400-a96f-4050-8195-08dce3b0b7c8
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 13:38:51.7973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nDtbHf/keM+vYkk5i/g3USuVbmmjs+IHcdwru9Ww/kZkw1loJYhbHaD+DAhkihA/kz9g8+EWDdPii7tzyoxgE/jGy8yO20za+5cChMqO6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5136
X-OriginatorOrg: intel.com

On 10/3/24 14:46, Andy Shevchenko wrote:
> On Thu, Oct 03, 2024 at 03:43:17PM +0300, Andy Shevchenko wrote:
>> On Thu, Oct 03, 2024 at 01:39:06PM +0200, Przemek Kitszel wrote:
> 
> ...
> 
>>> +#define __scoped_guard_labeled(_label, _name, args...)			\
>>> +	for (CLASS(_name, scope)(args);					\
>>> +	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
>>> +		     ({ goto _label; }))				\
>>> +		if (0)							\
>>> +		_label:							\
>>> +			break;						\
>>> +		else
>>
>> I believe the following will folow more the style we use in the kernel:
>>
>> #define __scoped_guard_labeled(_label, _name, args...)			\
>> 	for (CLASS(_name, scope)(args);					\
>> 	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
>> 		     ({ goto _label; }))				\
>> 		if (0) {						\
>> _label:									\
>> 			break;						\
>> 		} else
>>
>> ...
>>
>>> -	     *done = NULL; !done; done = (void *)1) \
>>> +	     *done = NULL; !done; done = (void *)1 +  	\
>>
>> You have TABs/spaces mix in this line now.
> 
> And FWIW:
> 1) still NAKed;

I guess you are now opposed to just part of the patch, should I add:
# for enabling "scoped_guard(...) return ...;" shortcut
or keep it unqualified?

> 2) interestingly you haven't mentioned that meanwhile I also helped you to
> improve this version of the patch. Is it because I NAKed it?
> 

0/1 vs false/true and whitespaces, especially for RFC, are not big deal

anyway, I will reword v2 to give you credits for your valuable
contribution during internal review :)

