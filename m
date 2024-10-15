Return-Path: <netdev+bounces-135760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EF999F1C6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416F8B22ED4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C70C1F667C;
	Tue, 15 Oct 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTCQJl0l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4563D1EF092
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007129; cv=fail; b=DUEcRILVtXNQ9erziYOFcVGg6v9nqLNeJhyHWfD5rI38JSFUbfHPxDyifUyZrYE/ysYQCrUcDKHTW/jkFDZuzyKL6Y6+ZbEMUDr1z0nvOOAtKjipgH8598nM5VWxmQWYYCqGTj62jqeNV3j0xFnWIGw2Mp3N0VeU1OPQI5CVEzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007129; c=relaxed/simple;
	bh=4HIJQLTUFxmHmBFftHGLfcMbPJz/E373eEKx+a5VF+0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=upwgtJkAGU9Jf8QcnpPTs3sQ3GeTdgdErhQFrncFTkFSFWu+jgz8QEhw7zvbBksYbf4XE7V1OLHN1oyzBQ+T0jABnoNbwlP6eYK8fB/cNZ3knEpJBubZ6GJVc7fITb0Tw07vCkdo+8dfgt5sCa098dkfYe2r7SkA1IT6MUKgpY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTCQJl0l; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729007127; x=1760543127;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4HIJQLTUFxmHmBFftHGLfcMbPJz/E373eEKx+a5VF+0=;
  b=VTCQJl0lgODQFnmpQwB/WEytR68I3LcN3iijHlbVqs1r4OhE0SKm6tXC
   vfjoImOY6eca2nnJKYXPfv4y1IiZ0uESWMP82ILC138hn1YlITWA90NFN
   z0m4bspj/5VzY8PBNicEDs/HCvGhhAp+hKiv2hY5J/fRW6YbIUl39i9P+
   iAnnLd5SmM8/8lJDrz/nP8yJ40p2heEtUMrgqgCY/tFY7696AbG9IuB0x
   SdgSGfJwKGaT50GRztp5cqAyM65rBK8+K2GUaj/65rbaNXa+OAQv5bio5
   0yAFrkYUjVk7W9DDPNsW6XwwJ9Oozz8pSC0sqreSuIWPWy/0uQQlS+48m
   g==;
X-CSE-ConnectionGUID: xy3e2Q6JQreX//vV1KuqqA==
X-CSE-MsgGUID: os0XKY6UQVS/jHIdG5OvBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39784559"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="39784559"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 08:45:25 -0700
X-CSE-ConnectionGUID: i/LWoGb8TZCwu+is3ibt4Q==
X-CSE-MsgGUID: AyhpuTlUQCCaQlcMK+IFYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="77815417"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 08:45:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 08:45:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 08:45:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 08:45:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 08:45:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbkqYiEqkRsqQz6lL9wxV9Ny5zHMwW2lQGE5zDKEm0y0ZUUtuh5VOozFibAbjhLxttISfC1lip08tpmJzM0JNXTR5uV95nC9vhNVoofktBErt+njW4JDX5cSeoKGJPp5pN9ZqNau9b8A7tCaXt+KNXx8GWDVUtdC5YPXyZGCrHldp9b/OhY+fC2ViYniAQh1NB9cF+jhGmfeXXJOtY2U7MlmDaGlzNciWx11RgmBKndFMHIreinb6ERPNDDhZMvqtPihJ6Se/dXeKe95ByN3SRgC/IuwX474dvkn7Re7eLsVB6vKLyl1bq61zC1WyQSxExA0j1nGp655N7JUogZ5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxvwjF6qIeXofOT3j06svsqfNCCHkztHuViF+vlud7k=;
 b=IgqdMkydChhmyq/tld49UK4BGrxqLCFeAXcVs1V9xEuCCP1KXD5YvwKma69fdqyqEl0FhwxQhnmZWO4dgpAh+E/yraSNYqVjoVGupCwUx80/3cPppefEyuDNJ/eFQ19I869ri+sLYDiV0qtsQfhTc8tXoJxNDPczt3G2KDObDtg6n48jinWw7D7PuxwJmql0Qi9FUxbqL8SRdgsE5jS/vLtW1rkguHLeECLolj/r5o+Pf0hKBPrJso4+VV3ilGRhU2IwI00jij8caoG6yqmK2DxsJIzF/2YQ6M4Duuz74Rr8wVJ3SIbFd4iIb0LkEZC0v9E6/O8lyxpx6SeOvnjM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB8122.namprd11.prod.outlook.com (2603:10b6:510:235::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 15:45:16 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 15:45:16 +0000
Message-ID: <c0abd400-20fb-479e-84d6-5c58e5837c46@intel.com>
Date: Tue, 15 Oct 2024 17:45:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] virtchnl: fix m68k build.
To: Paolo Abeni <pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <netdev@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Wenjun Wu <wenjun1.wu@intel.com>, "Jakub
 Kicinski" <kuba@kernel.org>
References: <e45d1c9f17356d431b03b419f60b8b763d2ff768.1729000481.git.pabeni@redhat.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <e45d1c9f17356d431b03b419f60b8b763d2ff768.1729000481.git.pabeni@redhat.com>
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 6846ec59-3bf8-42bc-c4cc-08dced305d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L09jMUtvMU9rY1lRR3F6a3pTNXVkZDc4b2YwdzR5V3NueEpwSFJ5SGpGWjhO?=
 =?utf-8?B?YW5iQVlRZWJDVGNUbkF5MzFGa0lmd0trMFZTT1FOSUhWZzN6L3hUTnl4ZTRX?=
 =?utf-8?B?SWpLaXJ2NFEycVJDNVdVN1FKbVpsbUx2UWRZTlFuVk91WGtxdGZEVTJRdmlE?=
 =?utf-8?B?N0lZYkE0VVBHMHdUR0I2S1hnVmhGZDBHL3A4d3hJNlNBV1VPZzhpZVdLU3p0?=
 =?utf-8?B?ZjZNL1JsN01VY3p1WWljbThXeUtoNG1WclNTM3FBVUZjNzE5VWJNdFBQRWtD?=
 =?utf-8?B?YzVsZy9qTnh2aFl0dDI2eURmUmFYaklPU3YweFpYL0t4c09sWU14T2RqSWR2?=
 =?utf-8?B?enpDeXpEd1dLMGVmTHZER1JySHVSalFlTitKSlFsalJQdFI2dWgzSzlBYjRI?=
 =?utf-8?B?dk00a0VycFlMWEVjMjQ1M29kRmxKSVd3Zy82dFR0UWxES1RJWG5BN1Frajgw?=
 =?utf-8?B?UXdLdW5aaWdkeS9SMWRrVXllbTBlWjQyL1hJamJNeEZieVZ6NDI1blpac3B1?=
 =?utf-8?B?QXhWTm5UZnpzK1g4c1VJQTNZNGJEK2VzQ1BsdlM5bGMxTk81YnIzRVpZb2hR?=
 =?utf-8?B?TlBZZnY2bC9xTTRIeHEwMTFzbjFmT24zaEY5U2J6QmlHYlAyUEp6dDhKSHhm?=
 =?utf-8?B?SzRKck5OTStYbkl2SnhUWFFaMUo0bjNGUWtPSHUycjkvdHlxZG9GUFNmWHJu?=
 =?utf-8?B?RTlLT0RZaVN6UVV5WEdHcXkybHhJSzlYQkZOYy9MTmxSWjdsM2lrOHdrSmtP?=
 =?utf-8?B?eFpCTFJDWS9BRHhpREpDeU9COVFuM1JkbTcwVkxodWMyNXR4YXNEV0hqNW4y?=
 =?utf-8?B?R3Jzamh6MHlrUGJxdlNiV3ZUUFhCSDByOHYvMkhXZHR4ay9lSFBRbGxhRFdw?=
 =?utf-8?B?QjZUQ2k5Q280bnBCYnNlNVpSQ1hXZTQyL0w4L3JUVzgyODdJZENGT1czdGI0?=
 =?utf-8?B?K2RkOUtxRk1pVGJPRE1lL3RGMVFmSUZUNTF2Q24wcXFBcWQ0cll6amxYZ2tt?=
 =?utf-8?B?QU1jdFg4Y2Zaek5wRE50SjVlb1RxRE1NNkZvUWtzd0VoNkZIYlFlR1pnM2ZS?=
 =?utf-8?B?eGgvSkhFaTEzUTlLaEx4M2ZXY2Y2QWxxVFZmenkxZGNnbDlIUmE5Mlo2eVly?=
 =?utf-8?B?cEpabVdJaWx0YzZzTXF2U1RCOFdYT1hFR3Vzb1JvSWx1Wm9vMk4rRzJJN2t1?=
 =?utf-8?B?VndicEtSZnphUEV4ekEydjNFNEEyMFowWG4rNDFtTThrODlCN1l5TnA4L3Bn?=
 =?utf-8?B?V2NFN3o0R0VvT1U4eG1Hc3I0bHo1YjMzeGFwREpBc3pmdTlSTVBTYlVwMm5K?=
 =?utf-8?B?NzBHU2Joa202dTh4eWZqK3MybmFUclk4OE50MG9GNDkwMmtOQi9UV2VTTzVj?=
 =?utf-8?B?Rkd4dmFEbXhBVUpFaXBwL25rSm84NTV6em5iT05DQTg2L2NCUHV6bFFTcHgy?=
 =?utf-8?B?YXQzWTY4emJ3eXk4R2tVd3lIV1lURDF4ZDhBVWFBR0RFdEJiMkxrcVdqRk5D?=
 =?utf-8?B?R0NPMXZiaGRrUWZEUWdodjdaYXo5dTBJRU02T1JhbjJOd0RqUmU0bzZ3aThS?=
 =?utf-8?B?eTRwVS9NZWt3bVVVTXc2cUExN3FmSEdxZTc0OXRVazVvZENObmtjMGgrWHJa?=
 =?utf-8?B?WUQ0N3RUbFZZKzBJYjl1aHlxVHhXOElxc1RlaEF6VjNOWXpMWDY5YVJoeDJJ?=
 =?utf-8?B?YkZ6cFFOWEZub1d6YU9pWFAzQXM2YWNsQk5XZGI0VjVsTEo4ZDAvMkFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3JIUGtmUkdsNFZPWThoRnBjck1lcUdEN0pyYWwxNHJBVEVJTkpGcnExNTJE?=
 =?utf-8?B?SHU5djZqQ2RYNDljU2pTcDNhRkwyNTk2ZkRtNVpGVk1qVmlrMzdyMFUrNWRW?=
 =?utf-8?B?YWdvUjJVUXNZeEFvQ3BaK0JJMTA2MjBIdG1IRUZValhGbW5pbzJ0NFYzVkJ6?=
 =?utf-8?B?YzAxU29zUlVmM2w0NXRlL25GaW9XdUwvSmNhUlIzUmlxcUc1YXJqZ0NSbzNh?=
 =?utf-8?B?S3hLYUFiUm9ZRW55UG5YQVJGWW9SeFRhSWxvQmp5OEhVbmRDTjJCTWgwblRR?=
 =?utf-8?B?c3BkNDJPUkplVjNTK0dPcXhxbzZ3NGdDOEY2YVhJeXB2WGRzQ0hhbis5SzRS?=
 =?utf-8?B?cEo3NFk4ZlhJa1Qzb0F0L1dINTFFVEJSOUprMGI0SDdLMmRSa1RBSmJxaE5W?=
 =?utf-8?B?ZTNoY3J1OXU3N1hRNUlqNStXTExsQ3lsTmdRbnYxd0dYaWlZWjhROHRlK1ZB?=
 =?utf-8?B?VlRMaU1XSGJ1MnRCOVJ6ZUd6S1dTWVJ3ajcvbm9wNXdZUSthVWU3T1NuWkUx?=
 =?utf-8?B?N1YrQ2I4UDVGcENTT3hRUnB2bWFRZ2tYWnRDeFRwVnBCaTh1WkVvTXlrTC95?=
 =?utf-8?B?UVZvTlFaa0tGZEhsWGIwVFBXQ0hJTkFZWEJJL1p0Y2hqZUJSRWRpVUR3WjlI?=
 =?utf-8?B?SEhMNWVOU0p0Vzllc2ZiLzJVUnNsbjJ3NENZdllGdGpVWmRSc28rVCtSVG9k?=
 =?utf-8?B?U0lnRm4xZ3NLbzRBbVpUZnpHNlI0WlJEc01DQXFpWjA1eHpBYkY1QVhucFhv?=
 =?utf-8?B?anBpNzBiaDYrcy9xbWcybUx2K2hmQ1laVTgwcWtScnBUMzJOd1hTM1F0b3Ux?=
 =?utf-8?B?K2orTTBqSlEwaGs0ZVl4TU5TM0JvRktZaTNyMVR6OExPSU1UK2IrY2pLSDBK?=
 =?utf-8?B?a2FvWkFhdUM2L2VQVHNXRkxyR2oyNTVtb0tMb2VraHVEU2Zxd2lzL2dkLzBC?=
 =?utf-8?B?c21id0swdjFYMlM1OWRkbHVTVHM1V1hpQkd2cSsyNlpReUtpT2tRYW1PL0dZ?=
 =?utf-8?B?NU9LU1BiNm1iN1laSXh0L0NsOXhWZ3E4WitVN2NUWmxXNzV0SGpEbFhOQ2pZ?=
 =?utf-8?B?YUFsTlo2TlZobGpHUjk1Y3lMSnd1Sk1ZWHBCTmRHWG4wUjZxTWNZaDZLdzJi?=
 =?utf-8?B?ejVJN2JrNEVINnZUY0xkcHk3U1RYN0tjcC9ja2U2OGJPRmVyaTd3WHJUR3p0?=
 =?utf-8?B?WWx4ampPamFBdjRma2JPak01djVtLzR3NlVDNnFCRlFMa2Fvb1NGd2xNTE5o?=
 =?utf-8?B?N2dkc1pyNXB1TVkzN2pEZ2lIQ1NBT1JoYngyTE0rR1crcnd2ZkFIbTVpdjlO?=
 =?utf-8?B?WUhwd2dmNVBHRnZJMlNyVWV2SGJPU1RyN0RQdDRaYlF4WS9DT1VrYW03RkFk?=
 =?utf-8?B?VSt5U2licnJKS2hCZFFTeGRGVjRZK3QvcFRIU2tBZGMvR2F4bzAva2dpdGw4?=
 =?utf-8?B?bHFaNGV1SHo1eTJPdEp6bDZMRHhJMytCcTFVNEZQeUo4M0ZZNkN4dU5xVU0x?=
 =?utf-8?B?d2lFTkxmendTVitGQU9ORk9objl0VVpPbTVoS1gvUUliZTRvdXBVZjdQWFFR?=
 =?utf-8?B?NTNERzM2aUQvaWVQR3QxVG1xeVBXSFFyZEJvb3U3d0pPdXhhQU1UN3pkdnRV?=
 =?utf-8?B?dU81b0RlS3ROU01rL3E4WmRkYm1ZcmQ3N1VOTDlDYVE2STFlcWZVdFNtUFFr?=
 =?utf-8?B?OGpsV0o3cm9LN0tTM0RjMEtYRjNhcmo4Y2RsVDhaVXZxdTlxVHg5Y01MYld3?=
 =?utf-8?B?dHRYTFZRczM5TkR3ZGFHQjRCMHppTGNpbGVnTHcybUI1dlo1eGp4SlBsbXFx?=
 =?utf-8?B?enk2OVlLSWUrWjNybkFweHkydEsySy9Td0Y5R1pVSlpMeit6bTNkQksrRHZO?=
 =?utf-8?B?ckxrUUpYa0RsMU9qNHhxSzM3UlRXdU9aV0J6c3A4cFlnWmg5am9SSHVqVUt5?=
 =?utf-8?B?N2NUYmJiV0xDbFdiaTRJT3pzOWFzYjkvY2dEUWZicmpWVHdHcEJmR09menJI?=
 =?utf-8?B?RkhvbzlZbndoQ2NYaE4zS0tOb0Qxalo4THd4NUJiN3Q4dlVkbytpREw5R1dR?=
 =?utf-8?B?Ri9VTm82ZWVnL1VOay9lQUdxeHc1cCt4bXJYcU5XWFdKaGtkZS9DK202YUJM?=
 =?utf-8?B?KzlETW55RUh1UXFrdnBEZWdNUHdleFpEOGs5RmVaYVRaMFd6dU1LdHpEM2hJ?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6846ec59-3bf8-42bc-c4cc-08dced305d40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 15:45:16.1207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lkBzIzHePARyhv2Jc6mMfgN/umNXkcfBM6hwenzuG6N6yuhZ7gq7tqA53nAKsBSyGelchTyo/DJaGyRGO8pORftNWLSlxtXbKcGsQLWkwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8122
X-OriginatorOrg: intel.com

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 15 Oct 2024 15:56:35 +0200

> The kernel test robot reported a build failure on m68k in the intel
> driver due to the recent shapers-related changes.
> 
> The mentioned arch has funny alignment properties, let's be explicit
> about the binary layout expectation introducing a padding field.
> 
> Fixes: 608a5c05c39b ("virtchnl: support queue rate limit and quanta size configuration")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410131710.71Wt6LKO-lkp@intel.com/
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  include/linux/avf/virtchnl.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
> index 223e433c39fe..13a11f3c09b8 100644
> --- a/include/linux/avf/virtchnl.h
> +++ b/include/linux/avf/virtchnl.h
> @@ -1499,6 +1499,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_queue_chunk);
>  
>  struct virtchnl_quanta_cfg {
>  	u16 quanta_size;
> +	u16 pad;
>  	struct virtchnl_queue_chunk queue_select;
>  };

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

