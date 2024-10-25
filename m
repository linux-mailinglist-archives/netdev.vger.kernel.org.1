Return-Path: <netdev+bounces-139159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8209A9B083B
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0833C1F2128D
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950FD21A4C4;
	Fri, 25 Oct 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0Qqa9Q5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F921A4C3
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870152; cv=fail; b=CYKNNHaMJr4LPXIFFXHjzPb86I8E60OS5hjaNLMU8bXsihkf7ZSwzAPeDmuCj8zAVryc037kQ6a4TPj6p/RH6rN2ojWbTQlbn7F2lxbfgFeY0WxH/ksyYmJOTRwrzwqUwXX/Ex3y21y/evw0EChYqz05f7TNZy5LuDuYDSsGz/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870152; c=relaxed/simple;
	bh=0YWcbLsIoCRHSW7F3b0XKvE5kqcfvZTXY9TvzBJ0wN0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UQDSfm/5kFZrRhQqMH3m8rrmcvXZ0PX97sMelHm2NZQwY1HMLL+8JXk5tAkjuieYHctpy9Q8nPUt7aEZfsiESO+pborQvZ8zIthhwH5zXbowh8VdCaJugXBKNyp+wkhfwODlVHD+wzz3E0WTpArL833S+MT3NDMh/ET0l3eiYkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0Qqa9Q5; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729870150; x=1761406150;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0YWcbLsIoCRHSW7F3b0XKvE5kqcfvZTXY9TvzBJ0wN0=;
  b=k0Qqa9Q5LffBH1cD2EvTLIhANUi2+OzxH3HmsXFpMPfOE7+W7EnAXidm
   R5Phg18Q73Cfg4wY3vTu1nNXQO4e5CU5I27B0aI2wTvS96nMnTjGW/z1T
   QMlZYgqDTnFlx7vlxBWjAeYO8GxcBM9K6TB7fplSSVDo7Cp79M2L45yH6
   DGmlfTf6LKC4HSWx2CrDHvIwqyHZxqy+F6Gb7xbZR15b7Lt3aCX2RkxnW
   4q+cFEs9MuL8v+wU+NrN/MpdydBudXu5M+NZJsBmoEUV6CRLtsdx7d4KB
   Cn+hP1x13xfH0yJgRi7a/Rio44+r9Ehhb8XGpiSlX2ktrNjEFIPwsyfUx
   w==;
X-CSE-ConnectionGUID: R6J4WinzS5aw+NCuMiekiQ==
X-CSE-MsgGUID: k5I0MXfyTpmD6TFB4XCEEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29660848"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="29660848"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:29:09 -0700
X-CSE-ConnectionGUID: kontOVwRR22q78x9N/c0rg==
X-CSE-MsgGUID: 09RunfHMS6SrAxwyF+NOGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="104246981"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 08:29:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 08:29:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 08:29:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 08:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joF6IqZjMrUF5OiYsU+OqRtyFmzF3ypNRISBoS6MHZ9U8r0OKQ3L4PArlGIJkUQKcsl9GoJbMxo8aJ8/l+R3+Uh/FcieCP9OGl9iO8hF82jh+ItFg5kaTvVA1qCI1iXDcSzmf/Zr/bqPbSYk/J7wRmqGej+vIj0tCdc7B+t02xmBQC7FLqm/ePhbyT4+yUwEM3dsi2NdvUuUCAgwIiQu+L5eZ19/qRZe+V+DQtsRlxSuIa8OC/5VrzMMPXMP8SKZhH166J5s7FAwVDmUATCbZyIv+XMvTmWcPcaVQZbM3o1ipEOZ4yV9w93J8/w9ZAqQ1UIRgRg0/+N6x5x+DgtiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHDTpTl5gbDIixljZzQPW3VliH16m0dfBWHZUIFHs84=;
 b=xEF/D34WKTdL++N7u3v+8jNPvKruZxEx7uxa4lyA0dF9ikswkU1C5kVg4U6HO0eqgiIgK+SCcA6MFBF7L8ngb1tdOhJTUH3eL73PHAS4eK/t6E2NP1FHZM513Yu8CBWYDGYOYyP/4s00Jh97O6KA2rBwnrvWiPHf3B9h7YJOhXPTx2utuAbTF6WvDKbuUq4h0+5riOcOC9xHgSx0XbHEeSwaj3Dt/FjPyN9xMl/bMmstNB+LLGStfcX0d+6s9kl6JYMtkM23XiXVKSvqwI5sCyfXIBABO2nIX6ONYgjmtp2dHvewSeqcuNdY+nVgqanBooIT/XJ4q/L3GdQ5u4RL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB4832.namprd11.prod.outlook.com (2603:10b6:a03:2dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22; Fri, 25 Oct
 2024 15:29:05 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 15:29:05 +0000
Message-ID: <116b608e-1ef5-4cc8-95ac-a0a90a8f485f@intel.com>
Date: Fri, 25 Oct 2024 17:28:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qed/qed_sriov: avoid null-ptr-deref
To: Chen Ridong <chenridong@huaweicloud.com>
CC: <manishc@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <chenridong@huawei.com>, <wangweiyang2@huawei.com>
References: <20241025093135.1053121-1-chenridong@huaweicloud.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241025093135.1053121-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0043.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::29) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c7e5ec-d94a-41cb-085a-08dcf509c2e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnJZeFhEdzFUWDAxekRqekJWcUl4UjhsY1VidXVJZVRjalVJelR5cjBSV2pj?=
 =?utf-8?B?MjNXeGxLUTdUYmJNNlhBZTRsbHFNV2t0eHc5RWxDMmNzOTVQQ2lPbkhFeTJq?=
 =?utf-8?B?cXJpbWpaQXl5VU1ibmk3L2hoQlU0ZGgxVkJ4QlhpSjVaeklKOXBabHY1bXlI?=
 =?utf-8?B?QmdES2p4NVdaa1ExZ0tlRWNHTXAvaGxSZk8rTmJLZDJwQmk2MjhnSDU0SEYv?=
 =?utf-8?B?WGIwTzBoR1BkOXpYT3RyTEM5aUltWjhLVHFtQ1hvRXBqOHFnQzVVQkJLRHlE?=
 =?utf-8?B?aUl5d2VudnAxazFYblBuRmxSQnArS1g4cHVjSlJDdDJnc2hhMG5qcytvR0Rx?=
 =?utf-8?B?M0Y4aHlrUFlYeFR0OW1yNXRJNHJ5dUc0d2RLRWlnL2dwTU10UFkzdTkvUnV1?=
 =?utf-8?B?dFFVM01sRDFvNnRtVUt5UGJEL0Q4VlEvQ2I1anpFRXpWQTUwSzdTSUZPbi84?=
 =?utf-8?B?aVJ2Uk9IZUI5OUhOTm45VGJvaVRuV2l1KzNJUjVQRE93TlV1ZEgwUUlBWW5C?=
 =?utf-8?B?bEFjS0p0L2h0UVcybzJZSVYzUHdyTGYwb1oxeURoY0FNWE40amJKQi9OMzh3?=
 =?utf-8?B?QTVxdzI3Nlp1Ukd6TVJvSVRtYkREUlhSZVZYL011VDM0NWNiSzI3MmFVdXg4?=
 =?utf-8?B?SElqYkw0TDYrTmlDVUVvSHJBWEpNdktXRElyVUwreFBjS0dQQ0RVOG5UQW1v?=
 =?utf-8?B?RHFRY3pScWtkTFh4RWRtWGNkTUtYWlJzSVRDRml3T2xMcmt4LzBrSHBRQ1hH?=
 =?utf-8?B?SDZvRlhVNkZaZzZpMU00dFlNakFSaHRGRFVhU1JGWVVudUtrYzAwc0NnMEF5?=
 =?utf-8?B?YVJqcW1Cc3Z3amN3RVhMSWlNb2JVbFE5SGhRYWx3SkVFU3VkWmc0WG50MW0w?=
 =?utf-8?B?K2kvTTRaUnlJK0hDV0xqTGlYbXlxcWQzTEN6cU0vV1pxTkNYb1cwb2lNdTNz?=
 =?utf-8?B?QUlZbU5WVlAzN0VFZk1RYjdtVThCQjkzdkVRNXlZOVVPSS9lNTVtNTZMYWdL?=
 =?utf-8?B?UlZnZFpJWWQ3aldmTGlZU1hzN0VMOVQwamkvaTRBVWdYdUdtbmpLekkzT2V3?=
 =?utf-8?B?bEJkZTMxeDBMblN1UHo2RzNDS1JseTVmWHY2aFl3Q3pKS1lXQjg3UHlRRHFN?=
 =?utf-8?B?RWIyNGU1Vjg3UndKWTdmRER0c1l0ZWlKanZKMkp2NmlMVGNRSGlBaGVyY0d6?=
 =?utf-8?B?SGx3SW1kd3ZrTlI1T0E1UnM3YW5kNUs2R2lJRzZoSGFTSStzVTNuY0FSWFMr?=
 =?utf-8?B?S2RkQThjeDFlZEJ4Ny9vRkFnVWNTZ3kxZ05KbmNxeUVPdFdWUG1SMFVKeVhq?=
 =?utf-8?B?b3FITlVKM2xLcTB2NUgrQ1BKVytFMnlwY2NGTG9VbFVrZEQvdkk3Ujh2dDFQ?=
 =?utf-8?B?SlFpMUd2ZkdmR1BDQm41MW03ZkNJMHJLdHlBaU1RNERnVyswUFhHUzJKWllS?=
 =?utf-8?B?WVg4eXhoYnVpdXh3MHhya0Zad2xtOGJ2aUhDQmUxUDJFU2x6LzFyVWJZY2Rq?=
 =?utf-8?B?ZjdkVG9ITkJwWGJoemUrSzJubEM3NHRqdFZCVkNLY0JScW1YWThQQkZEK0dn?=
 =?utf-8?B?MXdxaVg3RXR5Uy84S0hWa1N6Q1cvMzhTN0RxUld3aklTd3h6Q09xKzE2QWFt?=
 =?utf-8?B?aFZjSlVWTTA1UWFzaWMzYzBYaXU5amx4QnBpc1dRMWphZTBxQ1VkRUZwcjBv?=
 =?utf-8?B?SUs3bmhOMlhhS3p0TEZxeWw3aUlUdk5kRCs5TWY5VytlK1dWL2pWejArSU9C?=
 =?utf-8?Q?37jRA2zaNnp1G0H4ZZgbLIAbzbeYfPcUCgtKNQd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVBvWGtZVDAxdjQrVmo5YmVpUGNRRDZrV3g5OWZYTVAyWWRWVmRBR3hQM1Zu?=
 =?utf-8?B?TWpPTzkxbDNxUThBeTNQUmI4a1luSFVXZGlYRnh4QjBGRHpsb0JON2VjcE1n?=
 =?utf-8?B?VUZpdk9UY3dlSHdtQnFrcTlLOURBUUZNb2hUTGo2SU5wSFdva24zK3NGbXNO?=
 =?utf-8?B?bE5WZzh2YkhQditaM2pYMjMrZGphempINkprbnFhNFM2UlJhemhCUWowN29i?=
 =?utf-8?B?ZFhDUFZRQzhOc1ViNHlwUEdqUFc5Z0V3empmejA5V0xWZFp2clNQd0FBMDd0?=
 =?utf-8?B?NDE4TDBlVUI4eTRUUTJtNHFFUHBtcmF2RU5kL2pLcmNNL3Y4L3hENTJ5T0VJ?=
 =?utf-8?B?ZHdQb3MzVGVXOVlNTThDWWxtM0ltaTlmN1ozOU5tSWNmM0NrOHBSbzFFVUI2?=
 =?utf-8?B?Z1pOOXBpYzRreFd0SVVRNkdwNi8vbndoMllpQXovSU1RSG9CQ09TbXlMamJr?=
 =?utf-8?B?bE1WMlMyRXFCNVBLVU5ESGZiRWxmYmJ1TmV0OGhBNkpvT2VwbWpKRHZER3Nw?=
 =?utf-8?B?ZVZ0ZnhFaUg5ZUZmOWRHY2xQOW5oandNTjdHbGVoMFJJeXJEaGpnby81N0RK?=
 =?utf-8?B?SmxNODAzTFIvNnhJRmh4VUdvbGhmWVg1WHNPcEYrMTQyT0s0KzlVV1h6Q2ll?=
 =?utf-8?B?VUl4TTRIcmF5OE5RVlk2ci9uNzUwUld3NXRGOEc4Qmo3TytiMHVtMk9ncFFj?=
 =?utf-8?B?OGdwQWtLTUdud2tmSWJBK09OUUhHeWRuVkkwTG9KK0VHTUlXZXB1eHp4OWx2?=
 =?utf-8?B?d1J2dmdnTmR6ZTZLZHl3QlBlWVEzekxHWStSQ1p3VGttdXNldHUrZ01Vanho?=
 =?utf-8?B?ek5oaklKazQ5bHFaNFpheTBUSXpjTXZWaWQ2Tmc3am5jQUlMQ3F3OXUySUNl?=
 =?utf-8?B?dWlwbHVZTWhmaHdxdmo5a29Ob0NIU3NDNWNBbmFGeEpxam9DUXlqdVhaR1Zp?=
 =?utf-8?B?dGlmYUw1aEFhTzlxMlJOMmpHSmdydGJRbEJUZ0MrTUEzM1pKL1Z2VW9xS2E2?=
 =?utf-8?B?aVYrVGdDWFZ4eFpMd0hUSjlMb3NtbEtBQjdpK1ZIc2QyOVJVdzVlNWROZmVY?=
 =?utf-8?B?dE9ydXBvZEpVNm1mVE12N015Z0M3YkRVWk90Ry9PZ0srMW9MT2RjNm5KbVlD?=
 =?utf-8?B?bGxacG92RU02L3Z3dHdqcEhXTFo4cUh1blFtWjU2dC9XT2NlMHhSV2VIYWFW?=
 =?utf-8?B?VFdtdVVVQ1RZQzBVKzI1L2hXSHFlNGtxQndLNVZpVjFtQjJPVGtGaytJQ3FF?=
 =?utf-8?B?M0pNM3dONi9MaWhIVXZxN0VOVFVQUXNDWVFNTytCZzBmUkJGMW1NeTFvS2Fa?=
 =?utf-8?B?L3k3M1dvcGlGRGN1bWZ3aEdHWnQzRmh0ZEx1Z1lKai90SHd2RmdLai9DVU1N?=
 =?utf-8?B?bkN2SWJLOFBMakM2dnJpVTBnTE1NTFRUOUcwZy9iWjlxc2N4S3pOdmNpM2dQ?=
 =?utf-8?B?NlhFN3pScHdSRFlBYzQvcDA3UFRuaWFwNWIrdzBvR2ZHVFNFQ0Y2ajYvV1BE?=
 =?utf-8?B?VDJrYktSWWZidG1DbVllQWxsVW5tc2NvT1JLZDNISVEwSnZnRS9qcG1VUFlQ?=
 =?utf-8?B?SnBuTFhhYjRjTG43cnFoMjNQTzVKMkR2ME1RN3BOMkZLeDBMT2VGYndBdXYx?=
 =?utf-8?B?SEFMamJxMWhjVVpnekhjMXQvaEVqeDByTks0WDUzUlVDU0puTGJCajB6TExz?=
 =?utf-8?B?eEJIaVdMbXFLQTRXRTdSczNEazMxUDZFckNmSWNsTHdkT0FNUDRaSkRkcjFp?=
 =?utf-8?B?OWc4N21YRTVmaGZrRWkyc2hJNVBiK3RKNVErUjBWWk1vdmhzQzRrNFE0VTRH?=
 =?utf-8?B?b0s4T3Ftd2xHSjRyZG1LblZ4Z0pwdDRIWEpscVV4L1JrS0hsMzJTRnJDUEMy?=
 =?utf-8?B?NnRVVzFFdFFsQUJqVEJ3d0wyRlFsTllpVHgyRitQWGZ1alA3OExrclRTRnQv?=
 =?utf-8?B?VzZlSXg1cmxxZWNzanBHWE01Mk1BTktaM21Lczc0YTdBbHYxK1ByazZUcHB2?=
 =?utf-8?B?Y3huMjZVQUloQ0lOTkxqZG84bWNaTVQ3REZBa0ZhQS8rYTJwU1VEajVkQlVQ?=
 =?utf-8?B?WkJUdU12cTY4OUFIdXZITk54dExkZTJXUkxBUDllUG9XZ2UreTI0RUlpQmFY?=
 =?utf-8?B?UHBDVSt0KzZTTG0yVGozZUdMMDc1cFIrTlBVMWdyemh6dXplU1RNTWMwY2cv?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c7e5ec-d94a-41cb-085a-08dcf509c2e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 15:29:05.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YDS8EUwx1OFANpOO7r4ihlNSH/zcHySOLCYvI0V286mn8hvGWJLL819kg+FCNkpXexjl5VxP2276oWStSNdcu7GwV0Q52n9ljORt3hhUAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4832
X-OriginatorOrg: intel.com

From: Chen Ridong <chenridong@huaweicloud.com>
Date: Fri, 25 Oct 2024 09:31:35 +0000

> [PATCH] qed/qed_sriov: avoid null-ptr-deref

Use the correct tree prefix, [PATCH net] in your case.

> From: Chen Ridong <chenridong@huawei.com>

Why do you commit from @huawei.com, but send from @huaweicloud.com?

> 
> The qed_iov_get_public_vf_info may return NULL, which may lead to
> null-ptr-deref. To avoid possible null-ptr-deref, check vf_info

Do you have a repro for this or it's purely hypothetical?

> before accessing its member.
> 

Here you should have a "Fixes:" tag if you believe this is a fix.

> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_sriov.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
> index fa167b1aa019..30da9865496d 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
> @@ -2997,6 +2997,8 @@ static int qed_iov_pre_update_vport(struct qed_hwfn *hwfn,
>  		return 0;
>  
>  	vf_info = qed_iov_get_public_vf_info(hwfn, vfid, true);
> +	if (!vf_info)
> +		return 0;

0 or error code?

>  
>  	if (flags->update_rx_mode_config) {
>  		vf_info->rx_accept_mode = flags->rx_accept_filter;

Thanks,
Olek

