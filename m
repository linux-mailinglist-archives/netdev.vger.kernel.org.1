Return-Path: <netdev+bounces-133608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84941996707
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC6E289533
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0F018E754;
	Wed,  9 Oct 2024 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcNgT35a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7BE18E744;
	Wed,  9 Oct 2024 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469292; cv=fail; b=i/CDO5TE1ju89M2PTnmKVaWmTACtr6CjUVhDFkKOkZi403O4rj5rziot67dstMT182mqsBQQqXwcS7pdcClV3DQFHVC5fSSNWB8WmcTbln7TA0bjLr3kSDP6QLLuZB85pT/T4y9X/5wkiETKTMOSPVRjpBebmrxP4obpGi1sVLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469292; c=relaxed/simple;
	bh=tdhQTV2SRNfH7ag4rxKtjXQFf+uULrxOT5g5GSs0XjQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HB9UynoiYer/pYm6p+GjvWcIxNSFXX1FOuCiozSG2lBmwcBSZLOIj0hvEVwfg/hLrfje20GpYsOnxcnXSlZvBR6WBVhq5oT4pTZN/c0sazBwtGPRPLXIrLmpJdOVQTmKCnK/KRY75PvO3VTQqwTbeTvivkNR0bojW8Fod4T9hMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcNgT35a; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728469290; x=1760005290;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tdhQTV2SRNfH7ag4rxKtjXQFf+uULrxOT5g5GSs0XjQ=;
  b=lcNgT35aNz9RELGeiz2cgReJwW+tQ2m9nzpL/5EKu6GuR1kOuQDgbgGp
   QggvTuK32KQlnnmYAhY0bGpb5cVoUb3LPcVJy7jL+8HhcflXNpnYL7ec1
   n+oiAUGU/WYz/uxvVrGPPZKXkB9Ui4ftRAb32s2ER0XEORmUEyDdSOuVu
   LRJBU/AA9XEN6WDVfv70act+skLG+AB4fVZ/Vdh180TWQGDfPPDubpiry
   XK2i5Ust3VQHrXxcRVWM0Hcy9SnDzX/qRxIJVAN/ZPRTngKxgqJ6i8qmh
   SGX8+4yuJf3wNi9Yul30po5nsRQl1VjvZ3kop6+upQ42r+ONCJTOauF9W
   Q==;
X-CSE-ConnectionGUID: OBeojWRvShS8mRAa06O+Lg==
X-CSE-MsgGUID: iUgdnW0iRSWfdtBplypc4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="45279560"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="45279560"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 03:21:30 -0700
X-CSE-ConnectionGUID: 6ZMmjn9RTamYwhEQh5jjyw==
X-CSE-MsgGUID: EVmVd1WgRJet0o77aqLrmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="99527925"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2024 03:21:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 03:21:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 03:21:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 03:21:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gT2Vn7C4uS5wWYO6y4+Gne9Tm6gxMcvmtgOayahsR8942f6vly61TaCSCYkJOgnDb/Kct9E3pBJ4lHYKn6IRrjyBo/jrhTr/rI26EVHtA/nsWZiNkBYc2vSSxDnHRyjJ0Jx+rlADTr3iEs5T8Qx5Bv9zG3dYlwUOQjluU/WbPcXW9Udg6d3EMuD6W+95l8aIaG9lVf6p/xyDaTv+xvV8XeqhGBc3rO6v1UA7OswYwY9rx9eYYAfYwK3PpPmznPFlWOeJisdV7E5Rh9LpqKMYboajB4KD1YaADJNJoYCt9h6L0TxvhedPXAq/wyYWqEJK2iMXSxyqwzsxuBsju5wbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0NLBbZC0tZtnrpay1xycfrQan/YAuukEAaQdTkEE+I=;
 b=JeOPcNr3d5i/LWFwtQ3H8I0h9mjfvPiCvHt/sbPRBK4s7lG9/diSAJjOvJZkSKmiMso663XbU4q/TZ1LPrQUosXmvhqWCgjOQH6H9gKPGOkWD5bVu7NNmYDauih1Xf2ZoxyCgyww88zS+H/11MeK49Vl1hHIxQiWrePbkIBgq8fPvG+x62KuttrM3hhZDLvaYpnFqlz+n84qRg2R6gxLEsg46tDeDmi8CWw7xSlxqKpO7FfYF5FawwC2wFr3mdTJJc6Lbjm1G/fu53CjrzOpo7igD/PQN2KR4Aq90jWg+Imj6oZApY+NXyharY54aKUO2Up57aQ3hCbSX1Z+ZRtPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB8518.namprd11.prod.outlook.com (2603:10b6:610:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 10:21:27 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 10:21:27 +0000
Message-ID: <9fd99d07-25d9-49ea-a450-bc1140cc7859@intel.com>
Date: Wed, 9 Oct 2024 12:21:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] lib: packing: catch kunit_kzalloc() failure in
 the pack() test
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
References: <20241004110012.1323427-1-vladimir.oltean@nxp.com>
 <CO1PR11MB5089426510DEAF985A5A4CB0D6722@CO1PR11MB5089.namprd11.prod.outlook.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <CO1PR11MB5089426510DEAF985A5A4CB0D6722@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::25) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3fbc28-520e-4cef-e989-08dce84c2244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXRmcFhJdlZCc1c2QWVlaitaOWJyRVllQ2Y3NVFnNVYyVE8vbyt2Z0p2c1ZV?=
 =?utf-8?B?MGhFUld4dS9nTlpHVjlYR0RORmdBdWVncHdVT3hrdmt1V083NEtrUmZoVmdv?=
 =?utf-8?B?VzZsWEd0Uzl0QjN5bGJlK3hLMHBuYVU0NGpnbzAzN3M2VXB1WUhUMkFnNVdp?=
 =?utf-8?B?aHBRdmpPeU5tUlYrcUNnVU90WithZWh3cFJGSi91NWFUOFcxK2pRSjYyRFdr?=
 =?utf-8?B?ZzBoS1d6cGV0RGgwYk9ObCt3UTJFejVwOEJsQ0dSV2xabzVoVkZ0d2ZTVmxY?=
 =?utf-8?B?VVlDUmVQZEJTeUZzNmZxVjV6SzRJVXdVTGRhK28vYWFjUjErSU9hWTZGZDFz?=
 =?utf-8?B?MFpZUlZmWVBib3dCblJhRWd6ZFdZdExXK1VuWUhENWJ1Si81NTZDd242Mzhp?=
 =?utf-8?B?QnlOLzlxUzMrQkx6YTBBM3F6VWtNaDZhZDVzbkI1NHRzVXBON0RYb21GaEo1?=
 =?utf-8?B?MW1pSWxqZFgvU1NJcEhMcEJBaWVSdTdkeWM2eThMWW56Nit6MlBLa3NYVTVE?=
 =?utf-8?B?WDc3THd5cnVMUU83TzEzSm03SERNaE9oUHZJVVFadW50QUtCVEV0V3RpbGQy?=
 =?utf-8?B?M3VncGFpU0hWZVhtcFU3L0RiS0RXNkVJbUxTQ2dkUFdGWXZtbFJyRGpmdHc3?=
 =?utf-8?B?QmFzYlhaSDFONlZqMFd3aTEwaGp1dzk1ajdFeWdvSzU5eGl5enpWY0ZxUUtp?=
 =?utf-8?B?cEpHOVFGeTdScmhSekI5TVc1bWMyOHI4YmRGQUhGWU41dC9MWklKeDIvakVZ?=
 =?utf-8?B?bVYzWDRucnFob1VGQUtjSkNDK2ViT3BTcmNTUHliSTZoVU5Eb3BPbFN1VTY3?=
 =?utf-8?B?SG1wMzR0OEF3T1R1dFBITG5GUG1uWWNKdGM4b3p5OTQ2ZzdPdWg2NlZQVXdl?=
 =?utf-8?B?cXBXTzBMbWc4QXdHQTg0WmZmUXRydWJ3OUgwMndSdms2cytYOUlkT09RRU9q?=
 =?utf-8?B?WHo2aG9VQjYvME5FTXdFU3BXK2pMSUU2SVdzVWpQWlM3WjFQRnY5UUFVWFRh?=
 =?utf-8?B?cy9vSGQ1RkJvUG85RVpqekQ1elRtQ2RrUERVSWlWaUtmMDgzM3Y5RDRpVjNk?=
 =?utf-8?B?MlZmZldwQ3pLL0V0VC9NbmkrV0NaK2FoTzZUdStLdUVaVDhtN0V2cTZ0MjY3?=
 =?utf-8?B?TVN3ZUVSZEs4d1lyMWNpY1p3NDY0aFJsU0Y2NU1uZ01WYURWYWVPVnE0cVhN?=
 =?utf-8?B?YlZTeVg2ekZyUWJmNm4wTGliU084K1VGRTN4T2xQQllpUlltQytEU1QvT2JP?=
 =?utf-8?B?Wjd5d1RjN2FlbUdTeUlOeHh5ZzJ1amFBelVZbVQ3UGJjeHhqbnZacHBBdXRT?=
 =?utf-8?B?NjloeWxoeTlnN0xWRzZNVGppZXFUaEJ6QWtxT0x5N2RDZU45NTdKVWdRVVBN?=
 =?utf-8?B?b0JmWTZKRkt4Qjg2SUVUNThnZm1oOVRQd1lqOHI3ZzYyeTBvNTdWUVhhSTdP?=
 =?utf-8?B?NHg3NXJtUjJRREZtQ1Rid3c4M3VaS0tRKzRsSnlzRUE2a2h0WXZwMjlsai9W?=
 =?utf-8?B?YlYxNGNOZjF5UmI2VDJ3bXpYenI4clZMdXpaUW4vU2wzcWtmS0ZiUkxicUdC?=
 =?utf-8?B?NHVHZXowUE9CMGdRMmFpZElzQVRqQjcwa1RRSXRaNE5FTVlEWGJGa1dXR3FB?=
 =?utf-8?B?c1Z1WWtjWmR3dW9KNk9OVlRtQTRQK2ZIelAxYm1vZGNFaVI4Ym94VUY0RDdk?=
 =?utf-8?B?clpTb2hmNGtPdkFrNjJGZ0t6UWV5VmtHcTJCd1ZZd21MZlBOM1gycStRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWVyMjhxTGlYZmxIN0R5dGx5Q2xQUzZhYzN6YjVJMmZyOE5EaXpIMjRRYmNu?=
 =?utf-8?B?UVR3WjgvcGNaNjkwcTdjbzFrOUc4YjJNcnlKYjJnTEJ5UlVrYkFvdUR2dHZM?=
 =?utf-8?B?SXBCeXlOdjVzL1JURU5kVUZGRmx2TU9rajVTRStyMVhPK2VGaHFHUG03Vzhz?=
 =?utf-8?B?aGVvdW5nK3BvSFBmbXk3bWp1ZkF5UjJ3NHQyelllODV6U3JLVHBkRnBBSTEv?=
 =?utf-8?B?cEsyN1hEb2RZaUZYekpYVHNDamlzZGxXaWRIa2FPRnNMWDR4T2tCMFJnSk0x?=
 =?utf-8?B?UC9rQ0NYSkJBRXZ3YTRWb0xhRnZNdG1EdVVpNm4ya2k1Nk1qM25wSm9keTkz?=
 =?utf-8?B?Tml1R2gwTlV4U3V5WTltSTJJcWtUSWhiNzdMem5KU21YdWpXL1gzMzBRQWlM?=
 =?utf-8?B?QkkvU1lGVWhPb2tJOXNCYi9KTWJ1Mzcxci92dmZLSHZuVGlMbVEwMnFZY0VB?=
 =?utf-8?B?d0lObndFLzdjWncvMzRjdTF2eUt2MDNDeEtTeTRqQ05SKzFyWWtXc3Y3NFpa?=
 =?utf-8?B?SEMwTUU2K29aRkxwSFd0NkwzMTRKV3JPamUrZ0tkNVd5MVl5bW4rZThMZmp1?=
 =?utf-8?B?bWxyS3dwN2s0QURvMFE4eUlmQW1yelVnWVdqaS9QTkVnSnp6Q3d6TFY2NGVY?=
 =?utf-8?B?NHBxcHE4OUZpQ2Uvczd0QWpYdDd5YllxdWx1RGhhV1dBMXRXTVdSNEFwZ0Rr?=
 =?utf-8?B?aTZhRC96d2hJR25VSEZ3YXJWNXllQ3hVSDQvK0ZSZldIRmVLVlNqR1Z3RTlX?=
 =?utf-8?B?NXUxQWowWnVSdEJna3lpWTdZWnBxdDJxOE5HVzcxbWduT0wwSnVreFpUVWpz?=
 =?utf-8?B?bTVERE5Ta05DTmhORVNpaUowVEhJZ1BnWVFaM0ZNN09udElDblMyM1JYSlkz?=
 =?utf-8?B?WmZBQkUzdGZKYUxsVnMzUlM2bU5jeTN4LzBhdFF2N2cvN1dhZlB6amI4Z3JF?=
 =?utf-8?B?ekFLZmZyL3dISXV2dFhSa3owM1crVzJLQ0haQ3hnNnNqRG5GbHFUM2YwS1lQ?=
 =?utf-8?B?bkljK2lSSHhyVFBXU2R3bWozalNiMVp4ZHRvSTdyS1IrSHNEdHhPYjVGdGJq?=
 =?utf-8?B?dUdGcmptMTQyc3pJUUFJc0dvNEdrVWpiSDdqRFVsNEFzeGZDeDZGeWlkYi96?=
 =?utf-8?B?bDhpQkRqbUcrZjNKU3FBYmhRbnhEVEdaNnlTcEg4UkVDTUdveGtjd0JpTlds?=
 =?utf-8?B?aVJKRjFrczhFV1lsYkdmZkpyZktRTGtrQ2FYQzQzTk9KR01iaEZ3OTZuaXFu?=
 =?utf-8?B?M1FCQ1V3SkhRMjZZL3U4Qk83aTVQK0VBckNRNVR5Q2F2YjlHZ0tsd1V4cnBq?=
 =?utf-8?B?YXhFUy9JSUZSMkQ5OUowekc5NCttRjcxVTlhbDhsekJOWDJmeXBzMWZpUmpz?=
 =?utf-8?B?WUFTRENUdUNOL2U4Q0RITmdWUnBaZi94eXRhaDRVN3grcjdwQ0hOZEtQMGxx?=
 =?utf-8?B?a1BaS01nejk1dVRJaDZ1T0ZSc1RHZk81cmxVeDcvekxCT1RSUDdwVFZyRzR1?=
 =?utf-8?B?SU5nL2pRY2dHc3BIWC9pdlduWHZzenJTZ1Y3MmQ1dWNKcWN6dVVDL2xxTFJV?=
 =?utf-8?B?MkJLdm9uTXNXQU1sN0tOYWFlV3VkTjJTcDd1YVE1eWdBWmNJRzNGVkQ2RDU5?=
 =?utf-8?B?aWxNb3JSZ2x4ekl1Vnd3c3d6bDJUY2JHWGVEaEhWdDRUSTNuRWRWbmFhVS8z?=
 =?utf-8?B?UWZoVFZzcUdqVnY1MHhrb3NMclMvUThYTkZsTHJTNHBnVjY5N2hOSzlwRExV?=
 =?utf-8?B?c3ZaeHEwdzNPME1OM0tlMXVaY0ZlZ3lNN1puaHdpbFU5Y0x2TUc1djJwc1Fj?=
 =?utf-8?B?MFdBQkN1dmRGL3ZHUGJwclZ5bk55Z3RrckpGOHpydU9mckJPeFhtcXlCa3Bh?=
 =?utf-8?B?MFBUNVhhYmFQVk1OZG02TUU3cDJLb1BvMXpuRDdzcnFZQk1WM09lMDlvQTJP?=
 =?utf-8?B?aVA4bHJwYUduTWZjZU5XcThEUmk1WHRTV3Zhd2xMYjVhblYxYkI0MEpiOENL?=
 =?utf-8?B?Vk5mRDNUVy9QMjRycG85RFJNTEgzSjJXRGR1WE1IWVBadEZ6MXN4UXRsMXVO?=
 =?utf-8?B?WHgyczk3dWFHMzBTTW0rTTZTWmdBM3FGQUV6S3pVSUVrRm9reHF2NERhQ0d6?=
 =?utf-8?B?Szg0aklQcmg4Zm1YUWxBQUx5ZjBnK25YbzA3MVJTODJKTmhhZjBqaWRVUjl2?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3fbc28-520e-4cef-e989-08dce84c2244
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:21:27.0746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3A9Crq1xLejXTwn22Ho3rADV6uGWqPfeCyRCI4KTh5bQbfJ3lbUKGWMa6zCqVUd6tiNgdR9W7q2S4g1+Z/rw/1P0BYHdNWGQZXYPdvcuzOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8518
X-OriginatorOrg: intel.com

On 10/4/24 21:20, Keller, Jacob E wrote:
> 
> 
>> -----Original Message-----
>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>> Sent: Friday, October 4, 2024 4:00 AM
>> To: netdev@vger.kernel.org
>> Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet
>> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
>> <pabeni@redhat.com>; Keller, Jacob E <jacob.e.keller@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>; linux-kernel@vger.kernel.org
>> Subject: [PATCH net-next] lib: packing: catch kunit_kzalloc() failure in the pack()
>> test
>>
>> kunit_kzalloc() may fail. Other call sites verify that this is the case,
>> either using a direct comparison with the NULL pointer, or the
>> KUNIT_ASSERT_NOT_NULL() or KUNIT_ASSERT_NOT_ERR_OR_NULL().
>>
>> Pick KUNIT_ASSERT_NOT_NULL() as the error handling method that made most
>> sense to me. It's an unlikely thing to happen, but at least we call
>> __kunit_abort() instead of dereferencing this NULL pointer.
>>
>> Fixes: e9502ea6db8a ("lib: packing: add KUnit tests adapted from selftests")
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> ---
>>   lib/packing_test.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/packing_test.c b/lib/packing_test.c
>> index 015ad1180d23..b38ea43c03fd 100644
>> --- a/lib/packing_test.c
>> +++ b/lib/packing_test.c
>> @@ -375,6 +375,7 @@ static void packing_test_pack(struct kunit *test)
>>   	int err;
>>
>>   	pbuf = kunit_kzalloc(test, params->pbuf_size, GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_NULL(test, pbuf);
>>
>>   	err = pack(pbuf, params->uval, params->start_bit, params->end_bit,
>>   		   params->pbuf_size, params->quirks);
>> --
>> 2.43.0
> 
> Oh good catch! I guess I had assumed that kunit_kzalloc would itself detect and fail instead of continuing....

that would be great

kunit_*alloc gives kunit-managed resources though

