Return-Path: <netdev+bounces-207265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FC5B067CC
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 22:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AE650428E
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 20:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809E4230BE4;
	Tue, 15 Jul 2025 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLlSwKOg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099431EF39E
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752611635; cv=fail; b=qKmOvxoOREJImBIEHSiDtddxgXe0Io3L59GG89Kx8TRafmgeN7Q23/XKgW+I/7kyy/Vkl6bu6OS5eHnu2M45tmHdkueR2Q6piHs0uw1bx4WS8jZfWbMUfM2y9QTK1iTttx39+jAbx8Z4T8FA6IegNqyZcKRum2xxfWoIOAJkYVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752611635; c=relaxed/simple;
	bh=N/ff/zXmLAQ5jIbQYp9DRIYgf761wJq8wFITN6DhXiI=;
	h=Message-ID:Date:From:To:CC:Subject:Content-Type:MIME-Version; b=dgyVAeVlr7ZPKXm2eS9KvJ7uU7ACPgk9izrA5Eaq71+PWvXChnyb+XF373xKeET0JeF1bn+pFJABulFWPgqZxa4R6E79D47k9Lu3Ccqy+P9gqJPVbKZA0pc/JtKLbG9QWeqeD5EkuhtCKlomMxyzLZTtBR7k9uR6fI3ezEzEKOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLlSwKOg; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752611634; x=1784147634;
  h=message-id:date:from:to:cc:subject:
   content-transfer-encoding:mime-version;
  bh=N/ff/zXmLAQ5jIbQYp9DRIYgf761wJq8wFITN6DhXiI=;
  b=WLlSwKOgieN4nADRaSBkxUqygQs71wxBtZTd+SG0OqTBXrRXtedaipOQ
   rAHNkOo9/nWpnLc+IjzlA/lM4eK2AuhlOxHxwlb6phf+dnDeQaw3Gh9qM
   Y1be2A0rt72XoBKtrB7nlOM/Xr0nBqgRoVerwbZtFP10jzXlFbidkf5Cj
   cBoZdG5jShtPyYqCZX9pga0fVntH5Fi+w/bcAsumG2P7jhglblM7HNFB5
   JRqqD9FLKDPidS7eCdSO8WXscaVWCvqnkCsweho3NXSLsFOay0gxSSQHp
   kWhcYNgKBEnDPaJQpdijYvTfbVz6OtL7kBw9eTVDQ/OqGqHTe/eMPhncx
   A==;
X-CSE-ConnectionGUID: X1Sk2IzQTU27GDLPZS2uIQ==
X-CSE-MsgGUID: IGD2Ky7QSaiU+Wyw7dmx8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="42475407"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="42475407"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 13:33:48 -0700
X-CSE-ConnectionGUID: lfYBldCqR9GR59CsB5MeyA==
X-CSE-MsgGUID: RJkHdtyEQQe4aHFGGuAkKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="188320634"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 13:33:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 13:33:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 13:33:47 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.53)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Jul 2025 13:33:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApQxuMZXAViy/jkE11bXBZET5W0eN6PXGdnv1Ip+HxA67h6lnmDFlG6lTmqcnGcX8RSy9YvG4muIRCbdfuuOQmFPgVso6uM9rJJP2k9rmZXVteZWODGi3OVT+pUsKIJbVpEIaUKnAnQPYqaR4PfxnpKJ/mL42B2z7YCA5Qt09cq2UJBLg8jq9IY/qaBjL8kFK51jFn/u4SPiNFQ5yteEhQap3S/KbvPrTXq3fQHremVJZRIzTgdC3BErBJZ2L16MAmKNQhB2mUI9upJPnoPY5pbAym/wkofks4tckS6Yoob+Os7HRh6AqSwDeIbK9C3RtuIVKl1VFZnVkiaA0ahJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/ff/zXmLAQ5jIbQYp9DRIYgf761wJq8wFITN6DhXiI=;
 b=LdpHWMML+0MMieHMLAbG01+cCw4jQnSeL/R66cgfoVSJJAGVD5qw0lzBadksWCsep+IcLpix41XcyWVw52iAhc9RTavzmKy38Y1JDmPXzaK6+LBAetEIY0rzm8hvv+VrH24OEXNasv566fH1stOEtl690HBMCwpmMuJdWCVZID0E/EseXLHtteenoniFge9EzlXwN5VqClZrkAh2qNrcvfmhw28HH8maBLe5f0oiTuysZ7N227JRiGP/DXlna4apAr4jZOOHVFe5T0ZZU5UWdpeoH5Su0zuW2Lhh6uxZG5aaOSCP73J8I55KfhCk62hDwpRDDDiM9QL9lHuLdidmkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY8PR11MB6841.namprd11.prod.outlook.com (2603:10b6:930:62::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Tue, 15 Jul
 2025 20:33:44 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 20:33:44 +0000
Message-ID: <5b94d14e-a0e7-47bd-82fc-c85171cbf26e@intel.com>
Date: Tue, 15 Jul 2025 22:33:40 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: [RFC] Solution how to split a file in a way that git blame looks fine
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0005.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::10) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY8PR11MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2ccea1-685c-4700-6bea-08ddc3dee45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmdhbXhPY1B4VmYzQVN3SXFYMEcxTDduR2lWWUE2TWo1VitZcldtM2JUR0M2?=
 =?utf-8?B?T0NJL1lkY3hoWDZUNlpkMEw4TlZlRUprTVNMN01YREFZV2dhTTRwcTRiMXcx?=
 =?utf-8?B?TnBiZUFTcUxMYjE4a0NZVVNRczlmYTRLaHlKSGkyRDIzTWdpSmtCektXaWp5?=
 =?utf-8?B?ekdlUm9sWlNWVVN6OXk2Z25pbUdVem5ZY09HZ2tGaXU5cFptcDdNWkRwOVhy?=
 =?utf-8?B?ZDlxNGFGeFI3dWRjWGpxOWkzV25tcFQ3ZlkzWmI3MktSR1kxNkI5RUQwWDds?=
 =?utf-8?B?TDZaN2tucGdzd2ZIWDF3MFJIZVVKa0lmRk9WNTJEQUdMWllpd3EwWGlYUEgv?=
 =?utf-8?B?MVhKem9JVUg0ekp3Z01jNFQxczVQTHZ4UUJySEdHaGp0QjM1Ri9FWjlKLzFy?=
 =?utf-8?B?TlVnTmpmWVl0VW1GUlJwTHFDZE9HSjl0SDZSNFg2RVlWeERPNkNabnRzdmd2?=
 =?utf-8?B?Ly9EbUNxYVNFVjkxQzBuUDROcEtEelEzRlp5SnU2U25CRWdKT1BQQmJ6VjBB?=
 =?utf-8?B?cndIWlhzWmlpVVQwc2JRbGhVK0Z4QmtMcm9SVExzbSthd1pjUStOcko3TlBv?=
 =?utf-8?B?dGsyUXpoSHkyTUw3blhycUFWMWdHOTJJNWZkbitJQzFXbGNNcXFTeEQ1Q3JI?=
 =?utf-8?B?VG9BY0RWVjNuYzVONk5FckpIeHpMMU9Zb29nczd2emRZblY3RFRBclROQWxC?=
 =?utf-8?B?ZU0yZmQrbGZ2OG5lWm5TQXNpRDc0aTlRMXNXR2N0aFovc2hzeUpUVUw2RVZJ?=
 =?utf-8?B?V2tZeGFmOFQ5b3RzbG1hUmtjTS9oMjgvaVJzMmN2NFZPdHhlOFRCVEtXZzJI?=
 =?utf-8?B?NDR5UGlhdUhreVdYTm9uQlNlRjBsSHhlTXlqdjd5d2Uwd012UyttS2lpTjlx?=
 =?utf-8?B?cFNvdnEwaE13UmxpZnN2b24vQUxNZy9Sa0V0UlFIWlFiWWdsS1hMakxadUg1?=
 =?utf-8?B?eitnK2p2cEpndFBlRDVTcm83RmNPUU51REZFVFAvSzBOaEU3alEzcHFOaVZl?=
 =?utf-8?B?c2t3K2huazl0Q1dMVlNPS1ErWmlSZ1g0NlpwRlNJMHVwcTdWUWFIQkdVUWtu?=
 =?utf-8?B?bUtGS0VzYnVZYXhoN3VDdm9mNFY5dDlJMlNyVlRiY1J6eDdmYVVhNXhJSUlu?=
 =?utf-8?B?UWZycXhhSmYrOFBCYlQzNHdhQVRZSmlKQUxrT0JwSmhVUHJWTjJaZTlOc2xX?=
 =?utf-8?B?ZzRXN0ppYy9NMVZINm9ZRFk5Vy8wZFJYOExGQThRN2R4T1lFaGkzOFdjNWN2?=
 =?utf-8?B?TWJHVnFyL0lUZ2ZwcFR3c2ZJSFkvOVgrenp4MGRCV1VZNmQvN2RlUmdnSlg1?=
 =?utf-8?B?NTB4Vmo4OXpYNm0xVjZjOXBuN3dHOTdueHpGSlp3bWNscy90VXVyZ3hLYWhX?=
 =?utf-8?B?Y0lYVW13Zkh4eFA2SEtQdGY4VVQ4UDBad0NLcGp2Zzc0RmRpNldySDhobE15?=
 =?utf-8?B?M0sxU2RtOGZXQWFhSjdrVlVLZkx6dWdEbGFLY3dYTWZwK0Nva2owcGFIbXZk?=
 =?utf-8?B?T2FHN283TG1QMHZlRjk1QUtHcHRaWElpdXlLNWE5ZGptZS9aQWs4dmxkZWk0?=
 =?utf-8?B?SUNvNlh0WGdPd1E1a0xuOWVQNTgwcmt3bmRHMHhvQ0hqLzR0VHRkRUxuZExP?=
 =?utf-8?B?Z2tYRTJseDJucGNIUWg3TEVYSlVNMHlLRGs3eDV0M1lnQzQ2QWdxak5pRDlk?=
 =?utf-8?B?NjhDb3hRMUYvTWt4bTU3bndrN0NnajRHVkFaeXRORjdVNVcrZzUrZU81bTRa?=
 =?utf-8?B?ZnpwU05EQzl3WW51VzVMQW0xUGRIMFVkUkN3eStWTDA0dTNoMFZnT3RnWjZa?=
 =?utf-8?B?WTZ5UEhDZVVvN2k4MmU2VGFrd2hPZi9kMnVVRUVFSkxXUEZBekYzN1g3c1oz?=
 =?utf-8?B?RS83RzFZb0sxT1gvQmJRTkVkQ3MxNURPUVVOdzlaY1FuZFZOcGdobG9hV3kv?=
 =?utf-8?Q?2BEtoW9NIjw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2NBYmVvMkNPQmNCL0N3ckZDa3BIMWtNVlZhbW8rNnVCN2k1eVFnYXlTLysr?=
 =?utf-8?B?Z1U1MWJ6Q0lRdkFaVmRWd3cyWWZNMng5OWQ5N2J3ZnVSQ0E0NlJBUERJdDY1?=
 =?utf-8?B?Q205NDlNTjhuSjZSb3BNSlZ1cFJ5YWNJa2xGSFhZSktNUk5OaVBhcm5yNndE?=
 =?utf-8?B?V2JyU09BTzFqanprOEJYODNtR3hrRzNSUVJXVmNCOFA1Ulpmb2oxZXFCZ0NC?=
 =?utf-8?B?NVFySkcxenZDdXI2SkJkU0d2bkFTZGxkS3l3R2tEOW4rU0NpaFozS3d1Z1NB?=
 =?utf-8?B?R0tPRmIvVWV4NWdRWXZ3bEdGQnpTU0JTUDFyWnlpZkVYUlQra3MyRENKa1pt?=
 =?utf-8?B?VEUyeFdqTVZrTUwwSGJJQ0h2SjVXdWlyOCtOZVlUODBXYjN1RVdmMXRMYmFP?=
 =?utf-8?B?MFQvalpNRHdraXQyeFVKdjlQd1gvWEZVU0tuVXNFOFZ0ZnNUdkd2dGxuaGc4?=
 =?utf-8?B?c3YyMHRrbENIaC9CS3Z4eU41Qk5OeW9XS3FRUDRQQ1hFaDU2WldXQVh0VVZp?=
 =?utf-8?B?aTNWcHdadGFHQ0VjcXFWNDhDRFlIV3U0RGlyZ09PSGVnOG9tQzhiNE9HcER3?=
 =?utf-8?B?Y1AxOEcwUjJHWC9CTXhsN1FhYkxRREl0eUlzRWMvV0h6KzVxV2xCUlArQVZo?=
 =?utf-8?B?N1ZiVDRxMDNSYkdPaXdxMWYzaktwNGRGMkhBc1B5UnJ2QzdRbk1ONUZKSzZM?=
 =?utf-8?B?ZjFqSjNDSlpPWS9YTi9nUFFmYVhNZWNJSkRjYXhCTHN2UlRHWEc0RWRCM2x0?=
 =?utf-8?B?VkVZRFJZN3hzZnl5dDRyMXlQblhSTlhzTE01cXRPcUNCai9mUHJpaGJmQ2tl?=
 =?utf-8?B?ZVRVS1NpZlJCcTl6VUJJQm5XamYxZzc5MVVScmJmdWF0eExjMTVhSXR2WUxs?=
 =?utf-8?B?VjA2VnJpeGFjK1dCRytZN1lJU3dQd1BYRHkrWEVvYTR4Y2ErZys2b1p1YkdK?=
 =?utf-8?B?UVhDYUE2QmozY3pBMlE3TzZoc0xkbXZPODRSTHJRNERxKzY1SWNaOFZtOFph?=
 =?utf-8?B?elAybmVRNUxjb3JzSERDNXUyRUFGMVIxUFdJV0FUbFNMQktuelRoMnhHRytt?=
 =?utf-8?B?cUdOY28wVEZwd1pVYldiZWlwc0YyYlozK0l1cjY4VDhaMmRQNVIrd21oaHpS?=
 =?utf-8?B?SDRJdWtvd3VURWNTcWF6NCt6T0YxUjRRNW9YMlVoejdsekU1ZTY0TGhJNlk2?=
 =?utf-8?B?Ni9lN0twWXpGY0c2ekdTZmVGZC9BNVNrRjRHRXVsSHpuRW85UHVFVnoxczZ4?=
 =?utf-8?B?alh1Qk5lUitXSzNiVWR1WHFSTDFrK2wxcWxlazJOd0VDYUlvakJIdEYvUmxS?=
 =?utf-8?B?LzlIVEJOZzdrallFSkE1OEdsSEY3d2VYR2FIdXRrVndKNEN3QnBybXgwNi9T?=
 =?utf-8?B?ZFQ4Q0pGcnlWOE85aDIralZkUEg1RFhycVFpK1BZMWsrRmIxVENwdUZxdDVo?=
 =?utf-8?B?RVdUSjAwZ3V6TEI0OTFPTGZrNVNmZm5ObEdpcmZGdkF1U3ZGQW5LU0ZKZE5X?=
 =?utf-8?B?bU9VSk92eGRGdFMxdzNFWDUyZDRwTFBrRzNSaDVnMExDbC9QMTNPRmpiMDlz?=
 =?utf-8?B?cktnVExFanNxUERKM3pzTUxkQTk4L2gzT3NzNkVyZzBKbTBaZCt4L2tFR0RZ?=
 =?utf-8?B?aEI3QkR2OVZCYTNEaEdMbC9Oc3ZaMFNYdm5RN3d1V0xMeGo4WWo3K3Y0dHh4?=
 =?utf-8?B?TEZVTE5pMzBHbHBXb3M4ZGIrRFlkMjZpb3JOZGs1RzZkYThPSUN6QUlmQTNX?=
 =?utf-8?B?a2g5SVJiODBXM0IxQVcvODVReTI2bExMckVGbk9HV3prMWhkeFptU3U0aTk0?=
 =?utf-8?B?aWg3NzIzTGtEd0pQYkMydXhNc3RkU3liL01wbmw1UGk0Q3pCdWJCZzduRXBj?=
 =?utf-8?B?SnlHVXJPa2tYSlo2SGphcm5JdHFvQVNWM00wVUpNVW5MQTREMHdMUGRKeGsx?=
 =?utf-8?B?eTB4TGRGazZGZDlRWDllNWtHL001WXNIemFjYmVaUWt6NG8rMG14aDlySmtS?=
 =?utf-8?B?ZGtmN09kaUJDNkxFTlMrZVZoNzYxR3ljYzhEenVVUnRIR29DblJVd2REYUtw?=
 =?utf-8?B?TFVZVnVEeTRFZ1gyWFowcW1Nb3dHVXN3TkRuSE9Sem5nVjlNTGlCZ085OUda?=
 =?utf-8?B?bExPRUo0cUFmYXdsMk5xWkxOSDF4ZlYyR0RFYmtZdGFnM0FkV1MvbTQzbGRP?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2ccea1-685c-4700-6bea-08ddc3dee45e
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 20:33:44.0785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nG/aWrtxtqsYgdWLtGZKXeJ+hRea/AY37OfDQ7aswjE0IcjtMmk2AzuyH33QMIui4hsUg08krCe3/0lc159XaCTcP9CgCIwsQx6wp2PVQsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6841
X-OriginatorOrg: intel.com

Hi,

I have developed (or discovered ;)) how to split a file in a way that
both old and new are nice in terms of git-blame

https://github.com/pkitszel/linux/commits/virtchnl-split/

The purpose of RFC is to ask if anyone is in strong disagreement with me

There is more commits needed to have it nice, so it forms a git-log vs
git-blame tradeoff, but (after the brief moment that this is on the top)
we spend orders of magnitude more time looking at the blame output (and
commit messages linked from that) - so I find it much better to see
actual logic changes instead of "move xx to yy" stuff (typical for
"squashed/single-commit splits").

Cherry-picks/rebases work the same with this method as with simple
"squashed/single-commit" approach (literally all commits squashed into
one (to have better git-log, but shitty git-blame output).

Rationale for the split itself is, as usual, "file is big and we want to
extend it".

