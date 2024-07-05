Return-Path: <netdev+bounces-109457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0539288B4
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8387D1F23876
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34321143726;
	Fri,  5 Jul 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4TfqglL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BDE81E
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182756; cv=fail; b=jMuS9gG4kQ+okQgvr2RG0R9V88xrs5WG9prjU87N3548xPm00ka2zdybhYVM6D1BaJ9OalPdeS7SPkISPKJGZCLFvrQc0d+8TISRQ2iXFC0JmHqOGZEcj7HDOVWMQHr75KDGM4kx3JzjbsBnbRpB2qFIt93q5SQEJxvAGZNkMak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182756; c=relaxed/simple;
	bh=nUtP+h2J7v+MpGfnB6wcMPq/wLdDAWCrssuGSMc+l2w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JV2jn+eVqOKK5SoYhYiS36miyiCiz1LKwHt45pkICh7c46dsu+EBU6Qu3w38dNbvwOAzsaP0TYdSDYYZZ5/Z3M6p10tqtUuuWNhQ+/oVPNXxCsNfd9zUYk5+8VvK+s0C37ila24aUEYz5eedeFAilAXyRbi9HfNdyQ9fkN7lnVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4TfqglL; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720182754; x=1751718754;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nUtP+h2J7v+MpGfnB6wcMPq/wLdDAWCrssuGSMc+l2w=;
  b=S4TfqglLWEXIdPs5z58PUHUuJUZ10HAq/UIUmtrXamjmGqHjRLi8kWWC
   lhjgaZZmuWPQpDSnEnP3jWU0GiYVbn4/jpM3G5vcDmK8wYgL/bUR57ZZR
   vBgLja9RqpFfqen8aUlsv85LljciHybu6YmjzJVicw0+fXav/27dYPHJx
   wj2nscWcOejIBn/jt76R3no2mXz4TKPkbGJxxhCVZK2iMRchs7a/bHU2k
   N4ieB/J2DicDLci1c3I1RjRKCwN/xbTLYxbW42IB9BNBMs03nEzaB0YDe
   5DcqMAsfIbzYcvlUBvwBP3zjBBC6DbjkhAxj6/xpy3judTrN4++kmUhH2
   Q==;
X-CSE-ConnectionGUID: qa/NfZvsQ2uq3bcV9Tk7dA==
X-CSE-MsgGUID: 6Jo12hQ/TYKYR41zuHdntw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="20379959"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="20379959"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 05:32:33 -0700
X-CSE-ConnectionGUID: YppS2Jj7SBSxBmiSY2ifWg==
X-CSE-MsgGUID: agic7uxAQeeaWwmvOy5ojQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="46866878"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 05:32:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 05:32:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 05:32:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 05:32:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 05:32:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdhP03NqdIwLRLyTRVOZ9DXT8//5b85PkQ5L77wfLWhS7DfCIDB1uWKqsDKJ6BSY3H7SKQJ9gWQFLyyVH3FSdfdgwHLqb9HaBh5b1FTXSMJCuCdCXinTRCtJ5hK+TIJjLHI/OVLcbNDTqDkQuGRUR/0Hp253tnaj6kVW+j3K/j79wuz09ms5F55UBFcy225LKuZwbEm4WLJSE7tZAHHBwEbteGYg9oERatX/diU8vHxLuRS23DRKkcKnt1aQ/swwZ7ieH688QtONVoycnPUDCL/yx44NbL60kBTiqaTIBh5hyoVgu+InZdZm04y5sVVx4/AgPz6fEbfAJ/kVObcjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRqFhVug9Xs8GOZhTlqLeLeYFBKwQUaIrmZqzt8Wex0=;
 b=kiZpK6U8LQjK0M1yrL/+lW3P6MrfBdonejtZ2rPu0Q7SAxa6I53l+6/qOo9UMsCkrMZZCrTl3vodsYdwcGNv8TA2R+Tr00OBIAP9h7nGLP3RSZTNip2ykg1oxivokRRZKRspNQuUJb0VH80+hwAjw2ritiUGBMCrl3F7Nm0df6R/ElixwFnrKTO6ND7RncZ85CA2hFSvrRaQO7G7N4nmb8qMvnCRT/OlzDW9DBs+IURCWkoX01h9+k2tjWsjrWHTwcHiSED708opAJ1bR/QzvKoXTWgY5c+nYqE5B72pBvkCwTdTYdT28SbsvzDtqtsoWxlvnsujHtWiDiBnyXAmUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY8PR11MB6940.namprd11.prod.outlook.com (2603:10b6:930:58::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 12:32:29 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 12:32:29 +0000
Message-ID: <50291617-0872-4ba9-8ca5-329597a0eff5@intel.com>
Date: Fri, 5 Jul 2024 14:32:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: page_pool: fix warning code
To: Johannes Berg <johannes@sipsolutions.net>
CC: <netdev@vger.kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Johannes Berg
	<johannes.berg@intel.com>
References: <20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY8PR11MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b01892-089f-4a0f-2c65-08dc9cee88c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFJKL0dsemdkeTdLU0RnRzhkVTgxemkyNHA2b0c0bGNzQzFzK0RlcVp1V2Q5?=
 =?utf-8?B?MVkzN21kVzNQWjMwdko2bHlyeC9xdEYza0NDeVp1QXl2TlJuREZmS1poWTJo?=
 =?utf-8?B?VVV4YUp3Rk94MEMvYkptTzV2SkZORVlKRkFPZmJYdnRZWkpoYThSYWdMbTdE?=
 =?utf-8?B?VVdvSnhBZTA3cjJibXZhUjExaWc2VDV1MXFDQXU0YmZaQVpsanh0Q0hLTEUx?=
 =?utf-8?B?cHZmK1BiT1cyRDkrNzRwdGlpays3aFN6YllUc3dsc3NKN1VycXV5eFEvWE5T?=
 =?utf-8?B?eU5WVFNWa0ZBUHpySWdSOG1wUGNidTZYNUY2MjJsSWQ0ZlZ3L09KdXRKQUkz?=
 =?utf-8?B?QU81VGhDUkpTWnRmWFM1VFpsSWY4dURZY0V2UUtFbUt5ejJMQU5vVVdUNi9x?=
 =?utf-8?B?UWYyeC9aMi82c1JkK2xab0ZNNTN5M282Zk13aXhTYkthbERtYlpYR0FIOVgy?=
 =?utf-8?B?dFd2SkJrZklueEE3b1JzQXBHOWtyZUc2cEd4NWl2dWFzdDRqK0tMNzFwOGpV?=
 =?utf-8?B?WCtWRmJ1VGlUb1JGbEZYNW9FM0ZZdE9rUzNUSDMyWjgrSXFMQ3RGQTh4L0cy?=
 =?utf-8?B?d0hmV3c3dzBNcG1rTlpPazEvSFZ5dmZwbkN4N1ZvQ0lXUjdpeWpaNDZjR1BO?=
 =?utf-8?B?OEFqRWs5UGN5VklKZ2ltMUVnNVZUem15a2IraituTit2OUU2YVpraisxTFVh?=
 =?utf-8?B?eFpxcUFDNmRrUnROZlR0TUE0Z3BJMVZ3MVdMZ3llVXpXcmlZK3QwSFh5OE9U?=
 =?utf-8?B?WEJTeXRpQ2xWVXA1TW1GV2p2aTltbklkU1VCT0lrNDNqL3F1Ulo4MHhlYTU1?=
 =?utf-8?B?eWZzNWRaZC9seHo4V0haaDFvUVUwcC8yczBQQTQrMTdXWTlnMEJJL3dsZGg5?=
 =?utf-8?B?TUlxUmh0Z0hoTzRrVWh6VnN6THAvWjFubnhiYVpWUkRpYUI2bDFuZTMyV05T?=
 =?utf-8?B?YURPdE43N1l3M2oyaXJ4U2YxeWlpS3BJMGd0a3Y5R2wza3dsT1RRUTMvYzNy?=
 =?utf-8?B?YnVILzRoT3UvbUFJREhodmxCWU4rSUpzZU1YZmxFUU5RWmNwUHAvRkNnUFJT?=
 =?utf-8?B?RFNBN2N5QW5uZE1lM1VZY2Z4QU9JQUNBNDJmUlJSNTZONEdrS3RoNnE2QlZn?=
 =?utf-8?B?aUtiM3diZVN3dDdySGhlT0RscFA0ZTNOc0J2WWkwWGMrMEhVeE1HNHNlL3Q5?=
 =?utf-8?B?U09zRVVpUjNubjdWT0tHbXpucys1UVZoWndQZkt2NGE0QThuUE9GQkhhMFZm?=
 =?utf-8?B?TmRxOXFGeFhtU2hhN2FOMm9Qa2pXWnJyZzVBZEpORzhPTzBFbUFQSEhjanhB?=
 =?utf-8?B?MzRBcVRYT3Rrd0NVOHlnVVh4ZTVWVHQ3MVpKa3lGNGl1S2FiRkZMOUJWZEVu?=
 =?utf-8?B?OG0zeGFnMG5LZ1IxVVBPUkIzNVFKNjZ1UnZ1Zjk5NDhMWUZoUmpPRXc2U3ha?=
 =?utf-8?B?ZlUyRVBnNmoyMll1eTNJbjFPNThrajRvOTN0czJiMTg5MktwOVRGazYvT0J3?=
 =?utf-8?B?dXhFYzlKWlloVEhCYTBaSXh2aEFkVmI3VVVVOUJPQ2hBVThPczlYWGdaZGRy?=
 =?utf-8?B?cm5uVWVFSFVPK2g5TWlXSlhzbG9tRWFkWnc0ZlpKcGJuV25YL1dsQ3dlc2ZG?=
 =?utf-8?B?MkovZW0zRFAwVk9BOGNUWU1DVzBkTmdVL3NkSk40RStSWmw5bm5ON0wzL096?=
 =?utf-8?B?dTdZdmtmSDR1ZzJCUjZVSmxOMWhNZFhQNVJnM3hjb3hPK1Zod1daTFZIQlVH?=
 =?utf-8?B?RGJER0ErYUZwdTBwcFN5VnRrbnAzaThNMElZcmpVYzROUkZJY09XNEZTaEdI?=
 =?utf-8?B?NlFxUHQ2d1FHdHUwMFk3QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzFBOW5qWk9tb0V1Nm45UVJPYmtqKzVIYmJhNi9uSkRpM3pvU2FzQ1hHOWRH?=
 =?utf-8?B?ZXpGYlFteU9lc3pGdk82SG05Tlgxc0FDT0k2bmVnRlhwOUtUZSt0aktUMWsz?=
 =?utf-8?B?K2xNbEUwSTdMSjYzZDllUWtHcVNJTnB6bWFaZXRMUThRS2cwUDBYMENhemQ0?=
 =?utf-8?B?dWdRQkZWUmc4YlhqaHM5b083anQyWXpwcEF5djVXV3FQT2NHbUQwbEFidkc2?=
 =?utf-8?B?am9QdmNpM0xXQkxpZFV6anVGeE5tN3QxdHVkRHpudjNoaFE4K3hpZWVheFhS?=
 =?utf-8?B?RkJXQU45N1c0dUJBM3FjeE5oakFiVDZWWUdUa1lGRDRsUlk1MFN0emJHZWZq?=
 =?utf-8?B?eTJZNzEzODg3Ym9mbkp0aUxaMUZtcS9EZEFLdDNWMFFxUlMzVGxEN1JJZWJH?=
 =?utf-8?B?dFVERVdQdEN0aTNWZGNDZllnWEJtVllKdmp4SkRSZksrS1NDT3FqeEdNQlB0?=
 =?utf-8?B?Tm01Z1hRNTNiSWpXQTFNUnpXbDliS2p5NTJ4dDdxQ0R4S0FhUEx6NmdpM28r?=
 =?utf-8?B?bk5OKzZqQXR5RjJHSjNIUldJR0ZEaEVhMnpJOWdYUnRKTDZjWFJhbkFtejN0?=
 =?utf-8?B?TUJDcisyZHQxMDBxaGFEZUFxSG94amxwb0hMNTZwRXpZRGZ5ZzFRV2xaWnlp?=
 =?utf-8?B?Zzh1ZEgreUZiSEFmeDJVdFRFanp0dkp5RVZ6dnRMa2RPUXMyWFpsMUtuZlJq?=
 =?utf-8?B?WUE5dUNQMThOcFNPUHQyTmliTStqdm4vckJKVWp3a2t3TmxTNWN2OHZIQlg1?=
 =?utf-8?B?VkxCd1ltcXpEaXk2QUZ0UkZlTi9GWnYyYlVIbEdLWm1YT2hvb3VCMmltcWFB?=
 =?utf-8?B?RDNnSm9Sa1JoNlB5K1dveW1YWmwyR0VVRzh6akRMUjdIeCtpRTAzMExBTEli?=
 =?utf-8?B?ZUxnNjN5MjNJODRxajR4QUc4MEM5L3dxejVzQWVBQzFXMjBuVWJnYjdqcXdQ?=
 =?utf-8?B?K1gzL0RESDVXMXRYMS9Tb0UrQUcvc2MyMXlEdXJLM3Z1bjZmUVFva3RSaTdr?=
 =?utf-8?B?d2FpOUQ4YjVxUURacFpROFE0cGdyTzNQTUFEVXhXWndIRzlieGZ1Um50YXpB?=
 =?utf-8?B?TXhOYmtYZklCS2swd0cvN0RlUWN6UENTYjZ0VmxQSmhKSUE3K2NvaFZrSGZs?=
 =?utf-8?B?WDZzOEFnYUZpYlFPWXB5djVKRjJIN1pkOWY2TFdETzlqWDN3QUphSEFEU0pN?=
 =?utf-8?B?SkxNdkUyNU1jR2JIYzBvZzYxcW0wUXFlQUxPY0tQa3N5ZnRwOXEyMVcxdjlI?=
 =?utf-8?B?L21meEszT0VlY1BPa0NnZlhCMnp4RXdzZmFOZ0xYZkUySGlVaDgyVnczelVk?=
 =?utf-8?B?Um92OTcxUjBMcXNLdUFZaHpSam95Y09GWktpM0M3RDN5VWpKd09HUEZodnBl?=
 =?utf-8?B?eGRLYS9VZDBlMXArWmcrL2tNemtHNkZCcS9RdHV1dUNxeDJRYlc5WTduT0VX?=
 =?utf-8?B?MzZXUHlCenVONVVHSmJBSG1HZzFaTnFqeC9HblJRUGxHZnFxYjBDb3ZPclBx?=
 =?utf-8?B?S0lTbXJiUGdJSUczTDh1WExwSWpCMWJHUlBlUGFGTEZsd3dSZjFoSjJuOUVS?=
 =?utf-8?B?VUo4Rkg2VklLNm9nblB6NndaYk0vaFJlWlAvMkM3aUp3ZVJGRVhoeDB1RzB1?=
 =?utf-8?B?REx5SjFJWGpjSktPdkpZU1FFTmJjaFV1cUE0UkdiUmdiRml4TXFrMVZ4VFdI?=
 =?utf-8?B?S2tzRWFYK0VQOUJ6MFAxN1A1anh1d0NWZ0tIbGhsNHMrR3o0b1l3N09FV1FN?=
 =?utf-8?B?MnEzSVVlREdvY2hCeXM2RnlIK25xK2NOTm4wczVudjIra0pSd0VqNGxXamJy?=
 =?utf-8?B?a0pSODQ3ZEVQNUZZQnQwR01wdnJzM1Izbnp5WTNPUFFpRytRYVBVWE5oa1I2?=
 =?utf-8?B?VVdEMzVRTXNIREMxNlRZR0dsbGluaEo1VVNBSm9tUkdTbVhmNXJqTGptay9J?=
 =?utf-8?B?MjZ6dHJCV0g2RDAxNnp6emI1cWdFbEpTWXk3cm9mVVNHSWI0dUl4YjZYcGxX?=
 =?utf-8?B?Ukk2RitQdS9PN05vN1U2ZDI1NCsxZGNrWEN4WWFHZy95cUNGNUNoUGZnTlF2?=
 =?utf-8?B?TmlpYmxjK3B2bjc3UVlwWDMzd2tGY2FSdUdhS2ZINEZEVmc2elpCM3VmU1VX?=
 =?utf-8?B?K2hObXFqUkNBSWlpa2lYUjVFUGFxbDV0R29MMHphN2psUC81TE5yRDlJbFJw?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b01892-089f-4a0f-2c65-08dc9cee88c9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 12:32:29.3349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urW78fSG2YKPDDc/aUV7My1P8jLSC9yCaxPkKkeSeCc/kiK/47jbowmeoEmKA9i6L0mtYuVERi2FPTe/DbzWGeLw4BZD7RuThoqIncOu45s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6940
X-OriginatorOrg: intel.com

From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri,  5 Jul 2024 13:42:06 +0200

> From: Johannes Berg <johannes.berg@intel.com>
> 
> WARN_ON_ONCE("string") doesn't really do what appears to
> be intended, so fix that.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

"Fixes:" tag?

> ---
>  net/core/page_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 3927a0a7fa9a..97914a9e2a85 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -445,7 +445,7 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
>  	return true;
>  
>  unmap_failed:
> -	WARN_ON_ONCE("unexpected DMA address, please report to netdev@");
> +	WARN_ONCE(1, "unexpected DMA address, please report to netdev@");
>  	dma_unmap_page_attrs(pool->p.dev, dma,
>  			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
>  			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);

Thanks,
Olek

