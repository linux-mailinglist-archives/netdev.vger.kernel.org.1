Return-Path: <netdev+bounces-110166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F0392B29A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50DD1C21588
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C3314A4E2;
	Tue,  9 Jul 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwOtRvSI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68B3146D6D
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515046; cv=fail; b=SDjIrVay+eqOlFVh2vYMY2t4c2DrGvYEDKK5s8ENRp7BeWe4e1f65bXZ4PLog2QkDkrMJW1L2ETRQomrpakraNllZA4CjW+h9te7DWU32eG+UTI+lw64zWr2OwQfRy5xkzPDLnXbVI33cKaUQxV5JkJHrLPBrlopikSB+b/SwEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515046; c=relaxed/simple;
	bh=PZUmgm5KGlCWVMpbGsg+rkAgehWcKP8EHqgNf7k8Jug=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ASYGPNcPhtt79gFq+IP1LdA6qW7U6lwWsEloHOhgHBOCxDtibmNegozKDtfzjOd8p5XPbgAYdHGaYnLwjJ7Y0I4/1oAFHZMr3u3iwFFmqnLlXD7M1a3eqIX9qcuVtcBCNdQkcr6LrbbryaWh+diHtM4CFIC1+gW75iv1Q1ACET8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwOtRvSI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720515045; x=1752051045;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PZUmgm5KGlCWVMpbGsg+rkAgehWcKP8EHqgNf7k8Jug=;
  b=ZwOtRvSIHIhXEl6W3m/bXv4uSdTytF9OAC8n+ZFXaDqYbceWx8rctEmi
   leR2wHFHrvThneT6UYGuH9LwhL6IZgZPJu/sFV97fONwMgdyCzryHcz+r
   YBltpVlQYx0/r8Wxm9f24juVSugQDP6twGv0rsftAXWBkHyXBxn0GDUba
   AZqRHVWdKlloYJRPEXrtKts5GXA+DtLn+E5BXYp7BQl9ZEZvjT9VL/0/a
   pGWy2h+aic9efwkQgIhgdrzlpStO0ZZ+txVnwVu1UecKcYvICXkJ5OnSd
   ZksTmjeSDhWRGsYXLPH6YVetgW6F1ZYv/qEMnM/6N0rrQc8Ca5C5E6yFN
   g==;
X-CSE-ConnectionGUID: BFZxHyanRmi/CWdauV0HBg==
X-CSE-MsgGUID: I5PNhARlTQWWhox4veipXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="12448345"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="12448345"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 01:50:44 -0700
X-CSE-ConnectionGUID: ZM9TzYELQDOXsFo+HTf/Xg==
X-CSE-MsgGUID: EZA9Buj3STONEVO7fPFSFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="78932760"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 01:50:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 01:50:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 01:50:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 01:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnO+Lp6OK9oJXWwz2yvZP3fSsrYossW5reb+KoaLp+EAKBtT4P6Pllc1sbQ7dTymyrNvMvPaRqq29/VWfh+16nutRZpNYNyFOxni4deVHyqqak98/EdbENlLHbSi7tecpKzIECRLo+CHNGE9kD37KGr6DB7izWeEddJJdcyvwxfRZflro+od0YvBTyJlGwE/dNld4ZzSXqwdJD/D9/sX/uVIWRPdd7GUytg4/X8mOrXIB+V+cpWWTtf0kTM3K83ipQrcTsTq9TbbbT1YmIhi1sM0Lu2DGjSHdvlCJEOTUwjH2wmZ6W0BbyBufmG9nKVOMBPOxJ4o/fAXfzDxKoLDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pdfk/4WGzN+tdUOWmDvas7hq3SFoOrENHlReAag+81Q=;
 b=TDEuDdA80WabqcMDl5fIBFoydljd1EyzF2JqF4j13S2/E4TkIA7Mw19C9ynu6iL1Q1iJGlGu0IHWrzwP7yDeZxDCfHnn4zOAxiCkZMOLAPckjBHPoZX1+k9EFzf2H8OXAfyNcEevKfKRYBix//8ZYqRC6wxczqxwZ9U6Fc4EO0F46FAQsECG5Yx9wA+n9NFLGxBp6OfTbMq5usWJbbuK9QqzkhKpJE7LqJRU+Dohk/FKRnhqGzn+ws8PTJ5JEAEABcfjxqnV9qqKvpPW9wplQfGR1H97tbZ43sue87UUdqoZgDnzz7w+lgqP4xt1fjPU0NEts7ORu8O/pWOsK0hGBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB7564.namprd11.prod.outlook.com (2603:10b6:510:288::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 08:50:41 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:50:41 +0000
Message-ID: <5a95b463-261e-4874-abb3-8fd236fe0378@intel.com>
Date: Tue, 9 Jul 2024 10:50:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/3] mlxsw: Improvements
To: Petr Machata <petrm@nvidia.com>
CC: Ido Schimmel <idosch@nvidia.com>, <mlxsw@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <cover.1720447210.git.petrm@nvidia.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <cover.1720447210.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0024.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: f84da854-65bf-481d-2bc5-08dc9ff43642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlM5MXRaaHM0MitlTzd6T3dWUjU1eVdDK2lqWXpCSDVpLyttSWdGdDRvWkxY?=
 =?utf-8?B?cHM4M1Q5Y1ZuemRZY1hKSWVqOXVxSHFwRjJVV2xqMThvZXFoajM4ZHc1MWVl?=
 =?utf-8?B?REpheEpYVnc3SW1ta01hQVBlTCtZb1BxaTcvZjlQdFJWUmQ0NXRJbkxya0d2?=
 =?utf-8?B?RGIrN2N6MXg0M1lzSzV3ZXNEajJ3V1U4eXBML1I2SkxZMlVVSXRlbHVMaGxa?=
 =?utf-8?B?T2tZZzdjOXhxSC9BSnBDWFFiNzN3b295V3o5VXdtOHhqNGRjNGIwYm95cVpw?=
 =?utf-8?B?LzhVRzdDZkZhekRPdis1Zm9peTBJcTJ1OW1QdnVvMnNqcG5rOXRqdEd3Sm96?=
 =?utf-8?B?M004eURnREZnMWdrY2RnYXEzN2UzcStvTnF1Y1VsbUxhTUpuNW9TazhtTWJu?=
 =?utf-8?B?UHFNcUlQTmFkME1DWVEwQlNCSk9EV1l6ZUI5M3MxUzkzVExVMEIyYzlySDlp?=
 =?utf-8?B?MWV4TnNwOHNrSTVzVXNpamlyV1ZQbUpRUldnZkNGMzdJcktYYktWS24yOGlR?=
 =?utf-8?B?MStrZURCelI5ZDBLSkpzdkxlSEp4VEY2aWFQTW84cXptUUw1V0FyWXpYVWVJ?=
 =?utf-8?B?WEprQ3VtUFNuaGwzdzY2Zll0VTc1ZXMvVmtiSUNMM3ZXMlI3NGw2ZFpvZlpo?=
 =?utf-8?B?ZEljc0g4Q2IyNVg1MVczUEZyeVNXUUs2YmpoTE1QUlZyR1NrSWNQcTRhQlZF?=
 =?utf-8?B?MVFXNHZOWTB2RkYxalJBTTdHVUlBdUpNZnBWOXNhaXVQS0NVYm9HSWcxeE53?=
 =?utf-8?B?c2hyRnluVkFRQ1VtSTlnSmJ4RGxudk5pVGZKODd1WDhSTHlHRjhEOE5VL3d4?=
 =?utf-8?B?c00reDlmRVBUdXQ3dVZNL2FIV2pPa3VlSTd1YldGd0xMaGVvVlZhb1A1WU1a?=
 =?utf-8?B?M20raWMvR3dtSlc3czFmbGU0YzNFVlFvUDk5TWVtalhlODdOVkN5c0tVNHJV?=
 =?utf-8?B?dWhjV3BMdjRVMDNPdUVNMnJZd0RGM05xRE5sYVYwUCtBcC80UFVxYTNMUll6?=
 =?utf-8?B?bFY0M2NaWGRzL1JTUGxZc3R6a0k2Q080SzE0ampoUjFrVmdpY0lVaXhyWWRh?=
 =?utf-8?B?dmRkemRIMmIyd2tCSDNIZG9lY0hwNkI5SjhZckorZFlTeEpBcU8zckwzbTEz?=
 =?utf-8?B?UmJkUUZQbzBGOGVoTjZjUXFnV3dXc2dlSGEyR0VvVXppdFJreVhLU0xrUDdS?=
 =?utf-8?B?Sk1LZzU2RkZXM2hSS2pOeGVEaU1vUVBOL1JNT25ncE4wQ0NaV01BMHFlMFFR?=
 =?utf-8?B?OU94Z3hCZFRkUFgrSW81MGpTcmlkMzJJam04NzJLYlUxMXVjR01ESm51aEw1?=
 =?utf-8?B?Uk5KdjZZY0REVFVUQVdBc0N2TkM1Tk5GSnByempZZ1hwRE56RGJXdXhqdUhC?=
 =?utf-8?B?S0hDWWpESzNRNnZkUWx6Zlc0ZlFlb1dXcFBlVjdKWHB3djdDWjhyNzA2Witn?=
 =?utf-8?B?T05TbjZIYVYrNUxTeVdhbUhuNXRHcWdtbkVkb2t6eGxPSWRtRDJvek9BMjFJ?=
 =?utf-8?B?ckQrclR1MzhUcU5DSlhiOGdXV0k2aWZZWEpsSHZ5cXF1SktkRkhvZFJpUWxR?=
 =?utf-8?B?WTE3OUdkTVRQcWFsd2RVY0Y0b0laZmpBTit4cTV5UUNyY0tLblZ4UXJQYkh6?=
 =?utf-8?B?aUpDQWRua0s1d2xWQ2Q2VW1GMHRvUUsreG1RVVBDN3ZDZDErdkVNaTFuL1ll?=
 =?utf-8?B?MEx2UDQ0aklkZDFEV2tIVEV0SFp5VnhYL0p2V3JIUHVHTVgwK3ZvMm9STy9l?=
 =?utf-8?B?M1BNUHZWUWhLN1VHVlVkSlNSeDNTWkljM2p4ODIzR2lEYU01bDFHV1NXV3dX?=
 =?utf-8?B?L1Q4NnQvdkk4NnhxYWtyQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1I1T3p6a1oyQmxrWk15TSs4NmNtNUdUY1NHeno1c2d1WEFLRHZTdjhNZ0dp?=
 =?utf-8?B?NGZTR3BlYnJTcmdLeUFad3lLejgwOVNuYUVJWFlmNXkxY3VnZ3JNdE5naUZI?=
 =?utf-8?B?MjRkMVhXWnl4QjExNFlZbFpBbkVzMDg4NENyM0E0TFBMV1pQVHIyL25Fbkoz?=
 =?utf-8?B?aXZhSy90YnRHbVdJY3BZdVZxTE9rYWpwcFBhUnRhOVVMU1RidXh4WEZjdFEv?=
 =?utf-8?B?UnExOTQ0Y0oyL0RoOUNpMWdPcTU2MlF5a2owUFZCcDB1OWhJazhzSjVJOWhM?=
 =?utf-8?B?OXVkMThhUjJFdVo0cW9LVXJxdkVEdEQ3bUVkZXB0NzFoVWtHSG10YU9uY2ll?=
 =?utf-8?B?VVZCMXpMaGt0ZU12NGxZOGNmUkhYaW5ZeldXakU1UUZkQnU1Q01aZzUzWTZa?=
 =?utf-8?B?UjhjOFk5V0pXK3UxNmtRem5TNUlkQ0pmZXZVVlNCemlabTJiQ2JuSEx1akdt?=
 =?utf-8?B?NDVlY2k4S0tEdUlDZEJJUE53TThnZ1k0bXI4TlZmeFRjUy9aNS8zZnE4c1kx?=
 =?utf-8?B?RlBOS2N6MHFsQVFhcWpyNEQ5VG92Q0pQc21yaGFFY0hobHovZFA0cWJ6dndi?=
 =?utf-8?B?cWJNTWF4RE4vSEhUSWU0dEwrUUovZ0hYNWxTYUs2OWhkT3J2ZTdia1BiNEJU?=
 =?utf-8?B?MUlzOXpTdzJKU0dMNFV3UGZoVGRmWEEyeFYwNWl6bklaOUt4Q2NKRWNaS0ZU?=
 =?utf-8?B?YW9uNFV0SVM3R1VqM2xGQmovallUU2dIN2VpRENkWmR3R3dsUzRvb1hManFZ?=
 =?utf-8?B?SzVmclpVVURrL0tnTWJSQ1Nza1JaMWdqakxEU1dZb1RQaENmRnByOG9RSEp6?=
 =?utf-8?B?SE9MZzFzNUpJOFVmazM3OG4vNG51YlVZeEVvUlpVUWQrUFRoU2dvcG9iWE1n?=
 =?utf-8?B?WnNnWDJkdk1JUzg2NjFNR3NXUG12bTRqL0R6N2pXOTZ3RDBmdlg4d3R0Tjkx?=
 =?utf-8?B?dW9MMUttQlAzQ0NzL2xraFRjWUtYQjRVVzlXUGdua25oUG5ndElEY1hHaHR0?=
 =?utf-8?B?UFBEdGdiR09kL2lzbDJJQWdqUXJPNFFHcDRHWE45a29tNEhNZkYwWHVjc3ZO?=
 =?utf-8?B?SDZVWWR4QU9qUGhpTmVMdmsyVm9aL0ZCWmk2WHhJamZBKzIwMmladm1FYjVF?=
 =?utf-8?B?RzlFUXBDYSt0aTdFTnZTZmhjeEZLTldRMFRYemIwTUl3N0RaYlVwRXNBVCtI?=
 =?utf-8?B?R0ljWkFLTXBYQll1Y09MbFozNUxVaHVDYlpkanNQcTJJajluZHVBTkFTRVNB?=
 =?utf-8?B?aUdrNTZEVXdzMGZKOVJrajNCWEFQYURFZ2xsNDdTelk4bDZsQzBGOHJ4cXJS?=
 =?utf-8?B?SmFNMk8wTlhNeXZOR0lIMjdBWnNzcWQzMUxrZk9CQmE5YjVuUEdOTTljeFRF?=
 =?utf-8?B?bllxUUp5Ym1PUWFZQWd4TkFqaE10bnRKaUJ3bXB0d0xiaDVMc0hET3Q0VUps?=
 =?utf-8?B?eDExdWR5bHZhOTQrSWUvOExDVkNsbDJISHczeDFuM0ZCSVZuN2s3YmoyQVRl?=
 =?utf-8?B?cXhZMHN4SURWdlpLNjk1Q29DWGZVZHRPOGhXSFI1MkJ6VU1JUmZjRXFDQVRq?=
 =?utf-8?B?OG9IMkhCYlppZitVNnhoc254U1U1MHRXM2JBMG9xbDNMY2xFcFJDK3NpMk5a?=
 =?utf-8?B?dzFNTkVqZStyRDI0K1E5aWdtZUllWWhKVFdva3NKL3YvRFBhNHBCWDdtWkRp?=
 =?utf-8?B?QitGTXlMY1JiOGdoUkZXb3RaSWxXRUFBM25XK3lsbXNCQVh6bVlnRWhmVWh0?=
 =?utf-8?B?ZXJ3THVlNG83QXI1Z0g5WkVqR3BxMG9jQ0lNcG1LQWlWMWRsdEdJc09IaWsz?=
 =?utf-8?B?bmNKTVI3MWhzbnFIajY3VmJTRXpjYU53RkllcFRVVHpHbUtXRWZRZTlWWThv?=
 =?utf-8?B?U2FmQ0xEcStVNlc2Sy8yU3MvZWZuRkNyckg3dWhnZmdiMnhhdWdSRW9XQTla?=
 =?utf-8?B?YmhIN0V4NS9RVkd0RWUwKzJuZWZsc3U0ekVyWGJqb1RaY3dpTVBBWmozRFJy?=
 =?utf-8?B?MWlENEk2d0h4NVg3NDB5Rm1NY25OT1NObWsrcmVldVhxc29BVmRhRVhVOW1s?=
 =?utf-8?B?cms1eWdBQkI4VDllc0NQRnlBd2dtYS9FKy91N0dieWZjYXN2NU1VNjIwWk0v?=
 =?utf-8?B?bXJaUnVmbE96Z1Q2TWt1VnYyd3JNMm4xcitRMzNQYTc0N3RiYUw5VlhJY0pR?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f84da854-65bf-481d-2bc5-08dc9ff43642
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:50:41.2723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8c5gWhf3e+GvQ19QuwItJuKoBQ09qxpLytMx/FP1Hhm3PJDW5DDns4r45E8irJhFw4is7gJwXoTM53eB4/a/FsL1GQ175Ag6GPgobcY6UT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7564
X-OriginatorOrg: intel.com

On 7/8/24 16:23, Petr Machata wrote:
> This patchset contains assortments of improvements to the mlxsw driver.
> Please see individual patches for details.
> 
> v2:
> - Patch #1:
>      - changed to WARN_ONCE() with some prints
> - Patch #2:
>      - call thermal_cooling_device_unregister() unconditionally and mention
>        it in the commit message
> - Patch #3:
>      - reword the commit message to reflect the fact that the change both
>        suppresses a warning and avoid concurrent access
> 
> Ido Schimmel (2):
>    mlxsw: core_thermal: Report valid current state during cooling device
>      registration
>    mlxsw: pci: Lock configuration space of upstream bridge during reset
> 
> Petr Machata (1):
>    mlxsw: Warn about invalid accesses to array fields
> 
>   .../ethernet/mellanox/mlxsw/core_thermal.c    | 51 +++++++++----------
>   drivers/net/ethernet/mellanox/mlxsw/item.h    |  4 ++
>   drivers/net/ethernet/mellanox/mlxsw/pci.c     |  6 +++
>   3 files changed, 35 insertions(+), 26 deletions(-)
> 

for the series:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

