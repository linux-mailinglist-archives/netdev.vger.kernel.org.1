Return-Path: <netdev+bounces-122939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D529963393
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71680B222A7
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 21:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70CE1AE055;
	Wed, 28 Aug 2024 21:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ex1WfUjb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881B1AC891;
	Wed, 28 Aug 2024 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879153; cv=fail; b=l3rScBqammFHJk7MjHx1xAPqo+dAKtp+eG5gAek/oVUH7eHn+HHl3Tksa2JqigGMh+Tuy7s5ItNby731MC6BpS3Fq+SOi1ioncgF4QC7jkc0BsB1aLeGjPV1/S/rV06u7/JFk1NuVd0ayKvvdE3pbaZJAzJete7MeG8NjyeyPZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879153; c=relaxed/simple;
	bh=VgYPzy9DG2QmNYEyg3cDwrFwlRoi95NvHYqpeW6Ieps=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TnFgO8ntFkQhhnlDwbPhUMQ0QCsoUTqRaBkuNpFcc970vl2g2AizEAZ1PIMQNhN/IxK31/+ghT/cWWpUcUA0TzlAJGp1fnS554u/3L13bHOTXQc5zypvl9elQi5yg0+/p2ND5BHYrXdgOpFqQdc3709tJlpB12DLdvGftjVvGqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ex1WfUjb; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724879152; x=1756415152;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VgYPzy9DG2QmNYEyg3cDwrFwlRoi95NvHYqpeW6Ieps=;
  b=ex1WfUjbmeZo2L87gFLfj3AQhpKuKXl6vQawIa7fedFZM0lozGBP1KQq
   88c50P3WmRkd+2GwDh64VGqSCXKZVH1SW9sUrXmZqVFczABNF5g8+lVxc
   5mXeaxd42T8KtfxblQHoHrC0ghvX8AnW9+jrgZgAIT1Ne2uI8+MnOL+EA
   0LAORYhgkbx31WHVnF6d0KcKQs3SPUtQEXXAaMBe74TZ90H/sqtMVfICO
   a5w/CYTTfwrLRatAI/vSezXygpi9W9R4Too9u9yDgJxPp/ga3XhwHIMk4
   bPeUnG0sdegEJKejD27V8o8ozRxNmt9OkCUj5WCkJpJlbNwMrDZlwjry2
   A==;
X-CSE-ConnectionGUID: H0jGeMKcR9WSvR4iNUn6hQ==
X-CSE-MsgGUID: CM1IX3D3R6O1SMiH1c9tQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23607444"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="23607444"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 14:05:52 -0700
X-CSE-ConnectionGUID: 7XLW3xR8Rvi+MbxksL3Sbw==
X-CSE-MsgGUID: k2Zbo3MQS1y7DlxOIrG9/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="63864184"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 14:05:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 14:05:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 14:05:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 14:05:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qO+kUWMPp+utg/kFUvXG3oI/0XtyMwiqJwfKanAUZBwcBrV7CA35ffD8C+p/SGg1j/eCo5eiikT3CxaIqrirB8y4TV3u1Jh8poW8CCcMtiIRRPzN26I19a2f+OUn2X5T1rMRUNv/W99GEmPV8efcnDfDSxtd5ekSOUosmY1r5BxsFAtLkH4hTrHaVZQqq7ZySSMbUFzDkVlifSwEEVhNrhSIywFDY89DjxuR6Gj+uWLqSiHuhhQ7+3bh6eDcLSeTADYN/D1pqy9p9EVic6S7JsXcuO0rPqqzU9Cq6SF9ASFNnB3GFxW1u56Sx3g/uO3hMDQDuz0ROnK/znUEl9B0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yvzgart6YesDK0zGZp0nuAr/JVJgu8i/PcRjU/7rejo=;
 b=Rr9RemrKvk/b+/k+sczfjsFYHpEBLFZSasguTRsS4nUhtPkpOejBOY2z0Z2T+WeBq5ilVn0E04DAK/njWd0BAhI1UQoB0nWPoSH5WEMS/i4l4WEK02RSRJDvJiF/lNczAhYfhgz93uCPLxKpYcFIr39F30I8QIKIcA2es7oWZng6b9dssqcyyQ0L45NsI6YGk3vceX6LH5zObz/WQzKE/iTgf/p/Kav0XHROXa1PgojkV0BsK6LWVnUXgtN1McR1oh8xlnpxFIh0UANdtOZsHT6HmaeKh/mRbPzSW31DvYU4F/SgGKuiZSCbKa4OMsV4t0EimGGJO3n+XmhNsF8+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5307.namprd11.prod.outlook.com (2603:10b6:408:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 21:05:48 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 21:05:48 +0000
Message-ID: <cabb111b-37b4-493c-ad6c-c237c7091bf6@intel.com>
Date: Wed, 28 Aug 2024 14:05:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ag71xx: disable napi interrupts during
 probe
To: Rosen Penev <rosenp@gmail.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>,
	<o.rempel@pengutronix.de>, <p.zabel@pengutronix.de>
References: <20240828204135.6543-1-rosenp@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240828204135.6543-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:907:1::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d9dd0b-9c1b-46d4-1a19-08dcc7a530f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3FqY0x5ZWdLTkg3cWdoSENlYzVWZFdoczFMZHZRYnRneEZoS2Q4QjdJR0tw?=
 =?utf-8?B?d0Vub0FFN3kxMWt3NHpQS040c3JzMjhGNHp5dUJaS3NmOURLYmEveUtIL2ZI?=
 =?utf-8?B?c01TTXpJeW9jQUpyeHlUUHJ1NS9nLzlZWlhtRTNZUCtEVC9FV2ViTE5IQUZs?=
 =?utf-8?B?LzNVcVEwdTh3RTdPK0R6NGE5YmtSd0JMVFZlcVViTDFSbDV4MEYveElCaVVC?=
 =?utf-8?B?VHJHL2FpeDZOVjBtQ045b1VZTHhETmVDSUl2RXcvMjYwN1lJZE84UExjemRI?=
 =?utf-8?B?YmM4bmVRZll5MEQ5eHlNSWh1ZEFlVzNnditMQ3dzMVJ6dlZQSGJaQWhNSW9z?=
 =?utf-8?B?clhHSWFNdXVjUGJmdVN3RS9YOXpIdDMrVFh5c2ljNVZNSUZXcU55Qk5USkJH?=
 =?utf-8?B?TWo2ZEdBWUFXNFU3YUdBRXlNaWZUN2EzYUNRQWwvV3hWbDRucnMwdmNSZ0Rr?=
 =?utf-8?B?dm50SG9yRTk4MjFDWm9WVHpTOGZ0S3BWcFJtSnNSbk01QUxHYmVBUWlWbWgw?=
 =?utf-8?B?bHlDNVJ5b01xeFZ6aFV2RmNXZVF2WERWOXNjRWU0Q0V3QTZXMWNubXd3Mm5x?=
 =?utf-8?B?NUNXV01CQjhHNy9rWi93TVhwallBb01xTzFnV3BubGhVd25QdG5VUFBkdC9N?=
 =?utf-8?B?d1JxVW1ZWjFzUmNvZ0VnSG9sUytyS0ZLODhtR29OMWc3VEpMMFJBVUx2SXhC?=
 =?utf-8?B?aXQzK0pUZ3lUL2pyUDlmd1JsM3pUMXQxbmxMckRzY0xrZlpzeU1xZFNteGZK?=
 =?utf-8?B?Rmk5UStXWkQ5cUZpYUdzZndhWDRycUhuTldreEN1OXQwbEVpNlJNclM4V0k3?=
 =?utf-8?B?UW9iTU9JcCtwTThpNVZoYy9tbUVkbVJGcjZ5TWNVTVdZNmlNN04rZExoWUl2?=
 =?utf-8?B?N2ZuUmt2bENnRnFLd2NuQTltZFVVcUhPclgyd0FtQkpLZjlVY29MZE4ySDdZ?=
 =?utf-8?B?d3U3Tzdzemlnazl0cHlTTVJ4UDNEVTJpSFplc1E1bFFWeURsdDBXTC9Ic2VJ?=
 =?utf-8?B?L2RhVE9WTGtGTUpvQmNsdEs0dGs2eGpXNzhxTjk2WEVocWNwTlROZTczM3l6?=
 =?utf-8?B?YnFLK3g2U2x1MGdmcFdqYUxVNzM0OTJKOGt0WWhYMEVKaE44cStRdUs1bllF?=
 =?utf-8?B?R1NETWdubVVqNy95ekhKVzhXdHZ3U0dMbkRweEVJaEdQaWlGUXZDOWJUZzAv?=
 =?utf-8?B?cTJ1ZzFrcVF4T2ZicVhZc3NCYjRjZlZyTTdlYVVFWTgyS3ZheXpqa1lzU3BE?=
 =?utf-8?B?K09URW5UV3JPSzlEQm1kRFBWbEE0ejZmT0lOMkVDSlY2ay91bW1SM0VSREw3?=
 =?utf-8?B?eE55UkxhRXZNdndIalRVSndWNzdlS25vZVcxRUpSSVltNU1SWHhFeUFMRkhF?=
 =?utf-8?B?Y1ZGZUljVFU1MmpvUVdiZFNONm4vbjNWcE1QeVc4dFZQdHc1Y01jbmZJTkFw?=
 =?utf-8?B?citzR3VIM3pKVk95NXgxOG5DRS8yOWVpdkc3cHBoWE81M3dkWW5tbVFhaWhj?=
 =?utf-8?B?MkhZdHl6TjNkSU14MGM5dUFWd1ovakx5OVg0UHhpbEtjelZIR1dPRGVjVE9F?=
 =?utf-8?B?TE1kcmtvMFZ4SnMwRDNKMnlrZmJWY014RjlHUTIzZE0rQnVlR1Z3S0dHWEd6?=
 =?utf-8?B?clZaT2JpUUMvZGtlcWhiV0JzY1hTUE1kRUJwMzVLdU5FZnAwbmlzbmJMbUdO?=
 =?utf-8?B?WXRhaHZYbm5vNDBPQ2kzd0gzWlhrSDdVdzQxMmhLSWErWmZ4cjJiMzIzYlRG?=
 =?utf-8?B?VnZ1MW1GZklwZGpBU2xVSFl5TkZVbStvYzdxdFB0bGM2d0tGNTRyejRYbkN0?=
 =?utf-8?B?aSt4MDYzeXZPTkJsU29QQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnZ5TTg5ckovT1ladmdoSW1sbVJJZkQwc2J6dWVVTUxoNkl6RU5xbjlUSFVL?=
 =?utf-8?B?U3VacFpnTWpYYTgrNVd1N0ZXUE0rUGNQa1Ntb1paa3NneE9vSTJPWnl1UlJ1?=
 =?utf-8?B?a0FsTndrTHh6QnlRT0R5YUpXWURVT25KMzJWMTFWWHNOWHM0RVdCeHZTSjV3?=
 =?utf-8?B?UE0xYTNqT3J6T0p0c2JYd3NoallDWC9IdGRWeHJWdTVobk1PbnhBekVKVHB1?=
 =?utf-8?B?YmRSNHg2aUEvenU0cFVoL3VOVkNpT3AxSVFVVkZuNHl6YjBEQVM0Q29jOStm?=
 =?utf-8?B?V05xWlk2U2kvZ0lYMGZxN3BWVWc5aHB6aGlWUXN3UzlFZjZubG9pQXhNYzU5?=
 =?utf-8?B?NlJaa1FFdENxb2FvMHB0dmlFeG1WNzVnVkl0RzlFS3BTSmhmK2dRQ0NZSThY?=
 =?utf-8?B?WmhGNVdjSFVkL0VQNDNCZ0dJRUlWeUZjVTJGa1VBZzQrM3M3QkFWMkRtZEFH?=
 =?utf-8?B?WGUxSldKTk1mQjVQQVJxR0thSkJKUVpPWHRTS3ZGT043WjErRGpBS05SbW05?=
 =?utf-8?B?azVvcmhBYUYxbVFZajlnbmkvb3lHSUdES3RlUHNkTmJja2Q1dEwwdktZVEZ3?=
 =?utf-8?B?Z3FySFdtS1Q0VWNCamtKY2pyeHNsN2RSc2NXODR0QndWK3hiQ0poSzdNcVFJ?=
 =?utf-8?B?YWthVlE3b2JDeUphL1QxajJROHR1QUxRTnE4SU1hbUVGMWsxWU1TZ3h2S3Rx?=
 =?utf-8?B?OGxZZXVkOVZXd3lRNVJ6R1F1ZTN5RGp6eWJVZjN1UTdwTnZDNWdWcHFUQllz?=
 =?utf-8?B?N3dUczloRHoyaytGVXMxZlVoUkFITmVxcTlldDB0aTltTEdrQlJHT0kzS2tS?=
 =?utf-8?B?VG5rWDk1THY1Z1c2MHdpQjJQT25BTnd5cXkrVXdvcmFQZk9DUExzUGZHcmxu?=
 =?utf-8?B?WHlqdFVFTEw4ZDBlM0VxTXd4czNHWUJiVUFOcnlScTV0Vk1iaDA3UTRkOEVm?=
 =?utf-8?B?UEdLNzYvMVdTbWRhWGY0aVpOcGlYZmhtdTd1Sis1b0NsdHZlMXdib2E3ZVJi?=
 =?utf-8?B?Yi9nZEJnQmxrMThIMk54Y0F1NXA3U1NaVUZvT1UxMUtPaWM0bEpjQU1BQUVK?=
 =?utf-8?B?cEE1M2M1MmtaYXA2VDk5NS9IR3NMSEpFWWxMcytGOTRaRkRYZHNXTUIrNlNY?=
 =?utf-8?B?VUFsbVZyeUFvNEJUb0I2NlRqem1wdGEvMUtlZGZIZDJ2bnFwN21FTytKQisx?=
 =?utf-8?B?cVYza2NUL2w4ZnNOenIxVWdFY0ZIV3h2cGlNM3RJbElMOExYUi9tMFlmUmE3?=
 =?utf-8?B?ZjFUNDhpMCtXRjcycHRUNjdvMFRSVy9HbkRuQkRZdUxBY0VaeXo3VkVxczNC?=
 =?utf-8?B?bm1sajE5ZmFiUTJaRUNoUFVJYWZRbnZvTEJXeVptbWF4Zk90ZzhZb0F5L04w?=
 =?utf-8?B?NEVvN3IrSGxTWm1HdnVEUVNpanZONHhBTGV5OVgxU2hIcC9qSi9IU3gxT09Z?=
 =?utf-8?B?K1huR2J4TDFiaTROYTZvYVJLTmpqcEh1WnJ1MytRbHpuN21QMXRZdEdsSDhZ?=
 =?utf-8?B?VGE1MVp2SFQzNHVmOWhIeTRPYlF6TDV6SWhMRkJiWkgzM1VPcW43aHRPZTl3?=
 =?utf-8?B?elFEbXpYSHp4VjFuY3JvTHJKWHllUkpDY3g5NXFZeU1Fcm44K2E1ejA0RWdp?=
 =?utf-8?B?ZUZpa0t2M3pEWTBIVmpqSGg3TDQ4SWNPdEdxWTc3c1J3VCtNMjIvWmhTT3R2?=
 =?utf-8?B?VStZbEg5VDZJWi80T0dySlNIT2xsMTR5S1JVRDZBZXQvSjFHZy9OTnJvSHZ0?=
 =?utf-8?B?dC8zYkpuclhHY3dqRXdkckFGQVF5S3IwRUpxUm1pMlJSNTY2eU9DUHhzckdW?=
 =?utf-8?B?WDFDTUFNa1F3YjIxRllmSWhwaXppSFh3dWZHbUcxM21RNW5QQXNDUnRpbk9O?=
 =?utf-8?B?M0ZuOUVUdGlZMEJtRm9tWlpKcUlTRm5xT1ZhR0dHVVBaZEprYzBzMERIM0tp?=
 =?utf-8?B?cHdyMTU3MUJ3NnE5b255NE5jdjQvRzFiZ1dxM2tmUzUrTGR6YThrTVB2RWg0?=
 =?utf-8?B?SFprdDFMWEFmc1p1YVR0R2xVaTg5NEJmSVJDSlRRckZLZ21kamVxVW43UlRE?=
 =?utf-8?B?Szl1TUtZWGsvY2ZnVjcwTDJZc2VkTDNNR21DQnhjd085Yy9qZjdvTEFGVDRF?=
 =?utf-8?B?dXp4TmZobGdIbkVraUR4NWVNWGRvSnoxOUdVemlNTVlEMWcxaFFBcWJNa1V4?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d9dd0b-9c1b-46d4-1a19-08dcc7a530f4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 21:05:48.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nH6QaGeYGzJ4Xex6C6jd+UnoNt4DpDcOAg4grxxXDFmuFm5MZ9DVW9G45Iovb9kMCdIgnf9INDwUICX1tVHl066i9f9fxxiMForY08h80vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5307
X-OriginatorOrg: intel.com



On 8/28/2024 1:41 PM, Rosen Penev wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> ag71xx_probe is registering ag71xx_interrupt as handler for gmac0/gmac1
> interrupts. The handler is trying to use napi_schedule to handle the
> processing of packets. But the netif_napi_add for this device is
> called a lot later in ag71xx_probe.
> 
> It can therefore happen that a still running gmac0/gmac1 is triggering the
> interrupt handler with a bit from AG71XX_INT_POLL set in
> AG71XX_REG_INT_STATUS. The handler will then call napi_schedule and the
> napi code will crash the system because the ag->napi is not yet
> initialized.
> 
> The gmcc0/gmac1 must be brought in a state in which it doesn't signal a
> AG71XX_INT_POLL related status bits as interrupt before registering the
> interrupt handler. ag71xx_hw_start will take care of re-initializing the
> AG71XX_REG_INT_ENABLE.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

The description reads like a bug fix, so I would expect this to be
targeted to net and have a Fixes tag indicating what commit introduced
the issue, maybe:

Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")

The change seems reasonable to me otherwise.

>  drivers/net/ethernet/atheros/ag71xx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
> index 0674a042e8d3..435c4b19acdd 100644
> --- a/drivers/net/ethernet/atheros/ag71xx.c
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -1855,6 +1855,12 @@ static int ag71xx_probe(struct platform_device *pdev)
>  	if (!ag->mac_base)
>  		return -ENOMEM;
>  
> +	/* ensure that HW is in manual polling mode before interrupts are
> +	 * activated. Otherwise ag71xx_interrupt might call napi_schedule
> +	 * before it is initialized by netif_napi_add.
> +	 */
> +	ag71xx_int_disable(ag, AG71XX_INT_POLL);
> +
>  	ndev->irq = platform_get_irq(pdev, 0);
>  	err = devm_request_irq(&pdev->dev, ndev->irq, ag71xx_interrupt,
>  			       0x0, dev_name(&pdev->dev), ndev);

