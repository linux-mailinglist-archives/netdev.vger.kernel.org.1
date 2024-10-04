Return-Path: <netdev+bounces-132285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EB899128B
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E193285DD1
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6111614BF92;
	Fri,  4 Oct 2024 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGpJIdth"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAC014C592
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728082588; cv=fail; b=B/f2M/pRP+vtY4l6YipWlzQcj1w4qt1bXgA8fJ43kaMck0EnG8tNSs7TjNndpGBTcn960SFhdlOu/nwkKVICLIybdthB11J8uf9tjEYQjCUy8X7C2U2mJCoCf9Aj9oLMw/9c0UrzoToBv93yPNihj0To120wYUOKPVl5IOY5P6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728082588; c=relaxed/simple;
	bh=3UQVDIRhd8ggA4dm+NIqARSXwuu8/A5gVgJRNhQF82E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G/AsigWQwkOTpffT86pCxkZLdK1SIezvTCXin7sSAK/WLzhd1+gXRUQuwpSExU5OerxyL3LiRTEBfzR8wM/pvhhouWaIsl1rBKePynVdILMYwtD5ljxykYRoUl/MOaHDbmIMzGQX2avo95kYbIuJt83a4WSN25Njicqe7A9cn08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGpJIdth; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728082586; x=1759618586;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3UQVDIRhd8ggA4dm+NIqARSXwuu8/A5gVgJRNhQF82E=;
  b=GGpJIdthxLYokdjpjL3xYH9weX4J4wpcPs2wmWka+/dBOHNFE66D81Wj
   LLt61gpAI6Ip8VB6Q4whEbUDHxj78VQ92FZn/Z20g0wtlku6G2iFxglXJ
   lpO1MezoGCHi/9QaXBwRgfR2ZiJkwY5j25pRmLh0FBeNbaNbD/jRNagqG
   hztcJHAaaSAxf0PTm16sOVgVnHzl7DSCm63UIi/gfY7uzCngEuTEuHONO
   CMD/tDnlSvCzVD1oUOFFZMZAcMRFdYVK0dBvld0nTp5E+DynZcNPgkRN/
   Ck1V5etO6o3utDzK/IqRHnSgsXy1eWzLnxwr1jBcr8QpvBJl4GbqYmr/0
   w==;
X-CSE-ConnectionGUID: k6n3JT7LT5uVinX4ST/FTg==
X-CSE-MsgGUID: vRHfVj5gQJ2PxN2Y2vf9BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="37973807"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="37973807"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 15:56:25 -0700
X-CSE-ConnectionGUID: AWsthiemQVSWRS1o8vF53Q==
X-CSE-MsgGUID: 0zwMmKQnSXSN84f2Bw5diQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="74523843"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 15:56:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 15:56:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 15:56:24 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 15:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DK2SbBQ0LrA5z3b3kHSjYJezwu5YGX1IPtE2+DnkX5TpkgFe/UmVdYfNMAbWhy8WD20gE5WCNf4qpBhDeykIpFxZhuRxuQ6iK8/c/VaBYNoA7XHosx7NFhD4FZ5NvlNFNQjqIHAfExG6hALPjAYISNz5wcbCLCzGlc+mVRwyZY6+e91rtoTEDLzW1t6TTQnYptlPUJcgsz0bcoxdQxbXEjALgDx0MJRZHOkCTBZgyg20djwD8lSNk04GjFj6zEqJ8sTo6sddRtwvHXV8jPjvvepvD7JS/EEK6xOBYNAetyq9icc4vNcyY7eEC+33HijgvDDrdUAwHEAb7lkQ0k5VEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CONdQTnzkmwLOl6xLUwXU6UosOgzBdZBs16B95wPbJw=;
 b=ZsRJ8k49vSrQoheCm9hvh4Q8gdkT1f44Dx53LVBR8ZlHFr8khKwVNAYvTbDsRkOuOEx+UFPyVXdcfE0WGeDVP9Iz9hEbzEI3CVyVmwXQI3jLjq65CpR8hznkU+J+qaJCBbRY+GtEHnMYqQiTpTGWicVQumoK7KPZ+7aJQ/RUya96zzrDmFZpj10kDb5NWUthHqSKDKMnajuqUtdxglFEpuNYnAZUa+FGsSE5+L6JaYXTASYiiTmmuqGAWPrhls6cF2l2x+8/FFjjKquiRLvb7BsSmA4827K40wmd15SpmLoWMAsEdnGLSek1qlRZqzy7GSkdwmoCGUNy2Td3/cavRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6132.namprd11.prod.outlook.com (2603:10b6:a03:45d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 22:55:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 22:55:43 +0000
Message-ID: <57d913bb-a320-4885-9477-a2e287f3f027@intel.com>
Date: Fri, 4 Oct 2024 15:55:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/5] eth: fbnic: add software TX timestamping
 support
To: Vadim Fedorenko <vadfed@meta.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Jakub Kicinski <kuba@kernel.org>, David Ahern
	<dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Alexander Duyck <alexanderduyck@fb.com>
CC: <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
 <20241003123933.2589036-2-vadfed@meta.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241003123933.2589036-2-vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5983a5-a59a-43a9-6b1b-08dce4c7ad11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1NBcG1RR2JMSmdJYW4zR01DZ2E4SytpeDN4SVNXbWRnR2lFRWd0LzNZZlhO?=
 =?utf-8?B?RDJFY0U1STArQTVJN0dUdkJjOHFCajFad3pPUEUzTy9HZjlod0tCYUlpVjBw?=
 =?utf-8?B?blJpN1VrYkZXTTBaOFhWYitUNC9jbFRnMFN5V3RROGhxOFhxMUQ5NlBwNlZV?=
 =?utf-8?B?U0VJWktIOWRwV08zcjBpb0tIU2hzeWdROHhjTVU4ajYvVDY0VzRrYUh0aWpa?=
 =?utf-8?B?M3phR0pKa3JvVUh1UDY5b1cydzlkYytpZkp0THd3Z296TjBhaTZTTlk0RU9J?=
 =?utf-8?B?eUsyd2RiZ1ptd055L2hFZUc0M2w2V0wrSy95YkRRVVBDc2JOOEdVVFFtd1lQ?=
 =?utf-8?B?eXZpTlpYeE02WWZJS0NrMnhWZ0lndjlCU2EwVUM3eDJEVzVZNUtrOTM1S0ZJ?=
 =?utf-8?B?aHZPR2FsM1MxUjJQbTJFMjIrNktsZVNYMW94Ull2alFLOUcxOXg1SzNsZmJG?=
 =?utf-8?B?VHByWkswbk80RjZZNkdoKzB3OVZ4Mi9nOFJjb0dkVURxYzhyTUNVYTFxK09r?=
 =?utf-8?B?SGJPVlVLbjhwQlAyS0x4ekdTOEtaSVFNOU5PTXJkSGJHN2dpM2NCQnZoWHo0?=
 =?utf-8?B?RXhQUEJUWEdicU1MbForQ3lYTHdrYXdtOTZlbnlLTjY2RGc1QTUyU1RyWHha?=
 =?utf-8?B?YTRhR05kV0JPaWl4RUYyRFRnaXFyclM4dmVzckZzVzdlaUZqdVd3Q2x4YlUw?=
 =?utf-8?B?R0I0WmlhRnZCcWtPQVRMMTJkTHR2MnlPeXJmODdwTUcrNzdvM1BXRzJyRWJp?=
 =?utf-8?B?bFd3bG0zK25mZGNVVStkL1FhUU9wd1NYNDZNRmd1SlpzT0xqRjk2NUdzVFpB?=
 =?utf-8?B?T2ljd0RUeWgwYnp5M2JxT0tkbSswMnNDNGNBblB0RTBhOUFITmVSSXN3aC95?=
 =?utf-8?B?RDRIRjM5VTBJa2YxTVo0V3NxbDVjZysvdy9vUy9mVE02empFaXpaZC9sVlBP?=
 =?utf-8?B?RmNJbzR6NE9xUE1ueXUzeXk4cUVpY2Y4TUJSb0RRWUprdVpSTWV2WW9KVnZ2?=
 =?utf-8?B?QVh6VVBuVTVHU200cS9mTG5nTk83bm44UEhvM2tSbG1CZkE0aGNaamJmZ00x?=
 =?utf-8?B?aEcwQlloQTdkN0tUOFVNMzB0YTJRTGYrc2hwdisrWE9ZSUxZV3hONlZvUmEr?=
 =?utf-8?B?ZTdqazJnbVlNUVE1T0txZG9BQXAySThwKzdnN0lIT0w5QjBLbFZGaDVML28v?=
 =?utf-8?B?UVlkTlVoaGdrL1poWTlWMEJERmRENHB2UjhOeG5kS0lHa3c3UmZDbWcza1Ri?=
 =?utf-8?B?S0tMUVNNcjcwTWd3SDZiNHhPR0daVzkxOE1rRittT0gyWHh3NHNya2FNNmY3?=
 =?utf-8?B?czExOTIxemRyTXpoYzJuM0xZMWc3NHBuWDNyclMwak0zMm1QczZzc3JUYlhl?=
 =?utf-8?B?QzhyWnRzNkNIMkY3dkYyUGYyY0tVTFpxdDBKS2xxQkE5OWxQWVlTcDYwYzFr?=
 =?utf-8?B?VXBVNmd2Q01FOUpXcDhqNW90c1lzNms3TkN5ZjVabmo0MTY5RlZJRGo4YVlO?=
 =?utf-8?B?YmpzeGtram1KK2svZkxDNmJGa2c3alJJSkt4WmM5RENtbmJpQXhjbkxHcUhK?=
 =?utf-8?B?dDdqYkQ0THZzQUt5UmFVYUtDL2dOVkhydVVwTmE4RXNBMTNRMlhXY1JQRENt?=
 =?utf-8?B?SjBNTFhWN3BJcmlqanJVVlUxbTJqNkNiN2hYNnJLbVhBL3hQNDVlVThGOVhu?=
 =?utf-8?B?bUxaOENkS1AveWRGa09naGNIMTJJUFN5V0RvQ3E5WFQ3by9WMEpqTlR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFVCay9FQ3ZHQXNBYmlMWnpZNzFKU0U4WTIybmVLT0hMWUNwRm1QQ0xmNW12?=
 =?utf-8?B?aS9ibjNuR0tjUk5uZUtoS3ZiMlBwbDBRVVUwdGNuOURWS0NvcjU1cDkxTld5?=
 =?utf-8?B?L0RaSjJpM25tTlJON2U3STd5Vm5pYXNTeTh2aEJtbHJPeWhYTG5ucmVuQkNy?=
 =?utf-8?B?UVo0RHNrZzNPZ1R3bkpha3daQ1BpYW9vNmI5cVY0dGxRdUlwUFU3T21kdjRP?=
 =?utf-8?B?Ri9VT1J4SW85dlhsczN6bkhmYStDdjkzTlR2eVNJWUJvenNHaHVIcXB2S2ds?=
 =?utf-8?B?RWFkMmROdWduTnBOcmFhVmNwRk1ER2VKNlh1VjI3VTJZQ3lYc0paNDk1Kzl0?=
 =?utf-8?B?emZGUGk4VzRFbnBMUzFFbVl2UTdXUjFIZDRGYWpVRUl0Yno0dVVJeTRDT1BX?=
 =?utf-8?B?NzB5cjlLL3hsYmpSN3RYa21TODF4cy9TRGp1WlQwTFNCWmc0NCtmNklrNjJ5?=
 =?utf-8?B?SmlpblE3b3FRYTlYUXZjN2dwR1h6MGpoRytNYVFMRDVnelN5T2x6empESmxE?=
 =?utf-8?B?TmxLUGErc1NBK21KQkt1VS9iOEFRSGV4MVJMZmRwUVNLM09vN2I1bDNuQk80?=
 =?utf-8?B?bmlmTDZWb1Y4eVJLZG1URWxwQ1dZTGVETFZGcm54akRINk51di9iQzN3anlK?=
 =?utf-8?B?WDdidFhHK0s4VDRNNEsxSXdZdUN2R29GY095Nmg1SndpVEI5YkpKcG1VOW11?=
 =?utf-8?B?WEYvTm90dTc1a3hpMUZ1UXFnNTY1MzZuNE1LSURrTDNRTmJaRCtMbWhNSXc1?=
 =?utf-8?B?bWtGKzBSQkdJcHJ1NzFaa0RTK0I5eDUrTmZ4aExmQjhPREIxNUpORCtzM2w4?=
 =?utf-8?B?VFBEYkl3SXNuT2cyTDlZRDZQUkNTSjZUSHA0d1NVYThiZVlBWnFadDBLZXhM?=
 =?utf-8?B?SXBwVmozQjNFSlJzdjdjbDVzMEZ1dHo0MEVvVkYvcE5FcDhIVklEdStOS0Ny?=
 =?utf-8?B?bHIzKyszNHZHNzlNOEE5aGhSQUNwWDhMcUwrOEF0bTZWVWdCamQ1cFRpcTNp?=
 =?utf-8?B?ZTk3RmhkTU5QUDhoRmpmaDZpSkRDeW8xMGpUV1hyMjJERzJnaEMzUHFwU0FY?=
 =?utf-8?B?N1dOVnhRQnJkdVEva1I3UEFJN0p5MDQxZkQrU2FqbU0ybXF4SzdRcGdEOWdm?=
 =?utf-8?B?ZVZjQm9CaUcxUGZwUlpIV1p6bXpweHV0aTZNSzdwdVJQbzQrcnNLZFE1aUdy?=
 =?utf-8?B?R0xlRExqVzU0dVkxVnFBOFhLcUtkM0xkSEZ5cjR6Ynp2L2cvU2pDRTIxeXNn?=
 =?utf-8?B?MXp1d2tQU0RTSWNlamNtOHUrRkUyZ3BpNHVoaTNCTXV3dDY2Z0VWa01BWENh?=
 =?utf-8?B?Q3N6R2tuYy9ZTTlTc1pZbEVmTWlZNUVpSzhvdk5lQnFmcXp6ODI1RUg3Mnc0?=
 =?utf-8?B?WGZaTUJoT2FlNTVDUzVraURSckQ1U1JMbDhUVDdHdHh1SHVSTXZKZUV3R2lV?=
 =?utf-8?B?QTFibjBSQnN6Ti9pZFJwcG1ZaVR3UEpwT1lhWUo0RmR5cE9sYmhYY0lzVDlW?=
 =?utf-8?B?WW8zYnJsblNXUDI0WXBvWHkrdFJqWS9GYkJjN2JYNmNYSUlWbkNJTDhwZUxY?=
 =?utf-8?B?NTVYR2xqeG1mL0hNcDdrTmp2bzd0ZzhOYlF3SkVXbTVIT25nRzVFa3RSYlU1?=
 =?utf-8?B?azE0aDBQYW41Q25LY3hDVmJVbzdFMCtJa1o2SFkwK3pPSi9OYlBIRnpZcUtz?=
 =?utf-8?B?Ynp6eE0xbE1YaUZEbWZkM3JwdDVaT3JtTFBIWnpLSGpEUGhGSjR3Vk03bldT?=
 =?utf-8?B?S3FtNUROM2lFNjI2cndrYVpvTWIwZ0ljSldQbEdvbWZTUDFpSFh4QjJjSXVO?=
 =?utf-8?B?N2lKVS9IT3VsMEF0a2EvVy93UDNjSE4xUWlTL2gvd2xndUViV0ZvVFp3S1V1?=
 =?utf-8?B?UHJMclFVbkptNXVBeFZuZnRTNi9KOUhkV0E0NXhydWlHUm13VnlXdUZUTDIv?=
 =?utf-8?B?cy9OUTgrNTkyYWtlb3ZEVTB4MGhLbGxzbEhsYytESGMxL0Z3VFVUOUdhUlRO?=
 =?utf-8?B?L1VrblJqYmp2b1lCaG9CL3BRUm52UUI2c0FHWW9IOGdOSE4yaHpoRGtCUmF5?=
 =?utf-8?B?NG9Pc203WHFtdlV4ZmtzUkJJUVJ5OGI1a2MzS09NdE9hckJkU0hXb0RrMFNu?=
 =?utf-8?B?SjA5Q0RKWGx5SGJEd2lpRjlPSHNoWERTYVZGelFMcEhCWE93OVB5UGVnWUov?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5983a5-a59a-43a9-6b1b-08dce4c7ad11
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 22:55:43.8460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTgKUwWObpcT6oxKKHHpcyp6BheXKUHtAFDUdJNIyhJjeFkuXXrS3Is7ImremWuCqfz6WLrRSj/2kHcHRMFmTfU2Gzq2kIJjl/N2CAx6KiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6132
X-OriginatorOrg: intel.com



On 10/3/2024 5:39 AM, Vadim Fedorenko wrote:
> Add software TX timestamping support. RX software timestamping is
> implemented in the core and there is no need to provide special flag
> in the driver anymore.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 11 +++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c    |  3 +++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index 5d980e178941..ffc773014e0f 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -6,6 +6,16 @@
>  #include "fbnic_netdev.h"
>  #include "fbnic_tlv.h"
>  
> +static int
> +fbnic_get_ts_info(struct net_device *netdev,
> +		  struct kernel_ethtool_ts_info *tsinfo)
> +{
> +	tsinfo->so_timestamping =
> +		SOF_TIMESTAMPING_TX_SOFTWARE;
> +
> +	return 0;
> +}
> +

You could use ethtool_op_get_ts_info(), but I imagine future patches
will update this for hardware timestamping, so I don't think thats a big
deal.

I think you *do* still want to report SOF_TIMESTAMPING_RX_SOFTWARE and
SOF_TIMESTAMPING_SOFTWARE to get the API correct... Perhaps that could
be improved in the core stack though.... Or did that already get changed
recently?

You should also set phc_index to -1 until you have a PTP clock device.

>  static void
>  fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
>  {
> @@ -66,6 +76,7 @@ fbnic_get_eth_mac_stats(struct net_device *netdev,
>  
>  static const struct ethtool_ops fbnic_ethtool_ops = {
>  	.get_drvinfo		= fbnic_get_drvinfo,
> +	.get_ts_info		= fbnic_get_ts_info,
>  	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
>  };
>  
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index 6a6d7e22f1a7..8337d49bad0b 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -205,6 +205,9 @@ fbnic_tx_map(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
>  
>  	ring->tail = tail;
>  
> +	/* Record SW timestamp */
> +	skb_tx_timestamp(skb);
> +
>  	/* Verify there is room for another packet */
>  	fbnic_maybe_stop_tx(skb->dev, ring, FBNIC_MAX_SKB_DESC);
>  


