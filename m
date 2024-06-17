Return-Path: <netdev+bounces-104018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0365990AE66
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 14:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9C41C23E1D
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 12:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AECA197A61;
	Mon, 17 Jun 2024 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6HsQsU2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C68F197553;
	Mon, 17 Jun 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628994; cv=fail; b=gBWUn7tMExUkKZRRoMEbP+KBu5i7kd5C+fQfVla4OjvQV2o1IrGEad5qd81edohrdMkr7cCGFJ2yLohSym5yI0Ugo60PutcxzK51vDmM9H9NjweRZRyoXq8jOL2M/sa56x0hR0Jhu+ld4Cdj8C0SMBwFrtaiuPq/S/wZcmPjS+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628994; c=relaxed/simple;
	bh=eShruzTaKBvBYnLzH6MK9xQRnM/KW5Q6OBZHrV+tqX8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XpZdI0fuUihyH2Pej8F15PO467rxk34Oy+vI5/x3KMJzKUwMJXRgeLPYiWdui/Y09w8G484KLHsWLvZb45DL1zQVzd9RkKvYhWGeolVmqd2jC1ZwYBNAr4+RuiEe/iMw/SWWO19+5Jj2LI/TMbNU6Rkt1poVSukF02uBAjL2bk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6HsQsU2; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718628992; x=1750164992;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eShruzTaKBvBYnLzH6MK9xQRnM/KW5Q6OBZHrV+tqX8=;
  b=W6HsQsU20mu5MckJySpQuGSWFqEo/sYtGBWPO8dxGjTO6shO4LQz8dz/
   ehwWJtZCjgDh4UbxwaI35fbhDKaNqK6PXG8Dx4k2X+3fyaj4y6ZrAEeM3
   w3CgdUcma/9wW+cuPA4Mcs9XScEcJt0sKGUv3Ob0PfIacdSeXKhC/dfMb
   a7ZY669/ZwJDgtim3KUvjFY9fFKzeZawN2HmK6CI9WYfubM6WFZKC1jDE
   6NIJdI/RL/iG2pEVMRvzlB0+99cXKQjVzY1KX2qZ1yIg5ArsBIgERn6mT
   vNYMdVu4380zlcnPnCn2xYhUkR2isUPv5dp78hQv3FdaXhilx5d4tXHEi
   w==;
X-CSE-ConnectionGUID: QBBBEltQSj6A+7uOzsNMNg==
X-CSE-MsgGUID: yrjE4RLTStGnaKKTQCEg8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="26026882"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="26026882"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:56:32 -0700
X-CSE-ConnectionGUID: NvPqHDXBTW+detBkS0YmtQ==
X-CSE-MsgGUID: mfp29IPhQtiFXrVmHCkM4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="46301018"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 05:56:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 05:56:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 05:56:31 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 05:56:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia7wYO43c1/XrpoPaJ5N81o4kjHNYo9RLzBPfxsFE0gy7hyrY5uWsf2S2JquMAnyAuhG/pFQ7tohJueAaEhEJQYGfS+E9YP++3Wm+IkiROJ4ekghe0qGusPEedk1r4Euay2IzIdv04u3qqwnr6nw9AM0dilLBU4STilE23bLAWZTdhWrttreguIcbC1TxhnGmcTVszGzwrns3l1UtunR06odyBcj8jYGRAGsX4mbkJwc7BDqpI5EBmaiSZwmzUChUjj51+fLOVm35caW6UgBgFbJpFRyhdAN24x8JEHLxzny9IPyTAWgKIdCsvk0DcGp1v74tDB/c5WV8wbVxoSsrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMrGcXkbGSeafvxrrVeiWZ5BmTz8KPyxRiezXGVdGAE=;
 b=lXcpeQYKHF78NSko/laWF2oUa0JRcZwuIl90SVizDQRvm1hdS2nSDfVv4Jm7BKr9KwVd7bI3BNTzu94MkoKprBKGwmAoPs7mXrrlSoL+0w8u1KMQji5eG6ZOqISy2UmPROtzUko4T8OXefbQAkwq7uQBSccN9e0ts5ZowoDgu+MNpKB3zZDvUilXWFbx8m58e8So+si4BpoiCUShQW4SrohpZDVjeaTYYcxznBRjW6cbg+UVOtTMHAZCeKvQW7P9xE+jtEEyMrC1K0BCnRUFU3FfpNK7k4KNpUB5BZVXo6kZS3A38iQn2elGHJ/OV3FgfEwqqt/5GxgU5urEfM42Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SJ0PR11MB5895.namprd11.prod.outlook.com (2603:10b6:a03:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 12:56:28 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 12:56:28 +0000
Message-ID: <458526dc-9489-462c-b54f-3854b9227cb6@intel.com>
Date: Mon, 17 Jun 2024 14:56:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] ptp: fix integer overflow in max_vclocks_store
To: Dan Carpenter <dan.carpenter@linaro.org>, Yangbo Lu <yangbo.lu@nxp.com>
CC: Richard Cochran <richardcochran@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	"Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
References: <ee8110ed-6619-4bd7-9024-28c1f2ac24f4@moroto.mountain>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <ee8110ed-6619-4bd7-9024-28c1f2ac24f4@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0037.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::26) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SJ0PR11MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5639cf-129a-4969-8cde-08dc8ecce6e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUhHY3N1R3RRRkluK0RVdHA0elNkQlVFSWVNb3lQYzdFVURLOGtqRXZZWHBQ?=
 =?utf-8?B?T2hUTXZDWTltQzlVK1A0ZHZoRDJJYXo1d1pyV29waEk5MEJ5aXVCd0hyOGlr?=
 =?utf-8?B?ZExjbk1xREM5Y0x4SmJmQk1iRmhxMlVsN2QrTGduajlEazB0L3lmSk1TVVBD?=
 =?utf-8?B?UlQ5MVNFazNaVkFlWFZQWjhnbXZmL3RZb3k2OHFnWUwzdVQ1eVpQRjhRR1g5?=
 =?utf-8?B?aHI5V3dQQlIybVRyQ0xadzdwekx6STlHY1pLMHZOSXQ5SXlrRlpVaDc5Wjdu?=
 =?utf-8?B?NW5oMFhFeGRxRURMcDB6cmo2SkwrUk5EbHczWlN6akp1S051U3pwaEROaTFT?=
 =?utf-8?B?dlFkR1ljbkx5M21jQVdVZGNaVktOUEVPVEhIYjh5QlBIUm85SWJ1R25jS0V1?=
 =?utf-8?B?TVQyOE0xM0ZxaUluWVJGaGd3UkJsQmNmcHNJVFQ4NlV0OVBTczByUWh4V0VS?=
 =?utf-8?B?UERtU1NEQjRQVmh1L2hENDdyelovc1phL2p2dGwvMVZWSFVoV3lGQURTTEFh?=
 =?utf-8?B?QzM0dHV6Q1dueSs4RkF1UDN5M2RLUklQaUNDUTVFY2RDUnNCclRXeHR4RG42?=
 =?utf-8?B?MHp0TkJLWngwS3MxOGoxTUxqWk5odngxU2ZoMXk0ZnM5cklTczFHelg3djli?=
 =?utf-8?B?QWhwbXhsbUMrbEhmNHBsNmhaMmFFK1lVRlRCNHZOdjB1TU13bG9PMVFsbmRr?=
 =?utf-8?B?TlAxNEJ5S1o5dkt5Q1kyM0hVZXFGOU03T3RWNHFFWWcwRXdQNS83MDFEdzFE?=
 =?utf-8?B?eWZUL3ljM1o4T0V5NTdBZ2t6bTdId3lZV2FtNjdObW5ZNkx2ZHJSWjBJd1hR?=
 =?utf-8?B?aCt6MTU0V0hyMTZpdk9OYXZPc3VKUzZmRTlhcFQyeDZpWTlrSSt6aUhHNmFD?=
 =?utf-8?B?eExVMndaeEtscHM4QTR5cmhDbzJPZGFpVnRJM1hRNnpGc1BQR0tiVzdGMmty?=
 =?utf-8?B?ZDgrM0dDdnJQNGczS1d3QzFoME8rNDJLSytIU21oNFZBa0lTdTJwWTdpQnk2?=
 =?utf-8?B?TkZ6Q21ZM1h4NlQ0cm9DMjErT2tzalJlTllSdVIra0pkTWR6N1VpWjZ1WExs?=
 =?utf-8?B?Z29CR08zQThYV2JXQnRuUVRGR1hwb0ZSaDZzOFZzNUgrNUFvZFlvK1BxVTVK?=
 =?utf-8?B?UGZCMGllNzh3SW5TQVh3RmZQUm8xNnhEUDZYMXRpelg0R1ZqWnFIclNJa2xq?=
 =?utf-8?B?QldwcndGL1dwQWwwd0Q1dHFPNjlnWDlLZER1clNlYitpYU9BVFdlUjg5M3NM?=
 =?utf-8?B?WGlRdkZqYkp5Q3VtcFZ0U0R1OEp4NVJjZUJ4Nnk2Z3N0Nzk2Y2FDWEhNZlRQ?=
 =?utf-8?B?MU9qcFJYSCtQdUIyY0lDbmZMOXFhNzl3VVNWZkJDNEpzMFo1YjIxeUNqQzVm?=
 =?utf-8?B?ZmphUXBJbHJvNmliZ0M3dFY0SndiZ05TZHVLZ2xsblVWTE1qaGZJMVo2czI5?=
 =?utf-8?B?NW0wU2t2NVZ1dVN0UDZoVS9yTDQxWGRjTGtKR2JjR2NyVFQ3WlB3dEt6aVl5?=
 =?utf-8?B?ZmE5aFNDV2IrOThoZ2QxNWo5MloxTno5ZjExOGpSaCtHdzAzZ2F6cWpoMDhp?=
 =?utf-8?B?b1BGVVp3bmZYc21hRUF1RzQrR2xWQlRVd3VGM3J1TW5GaTRwcFFFV0xkTmJa?=
 =?utf-8?B?cHBrZ01BTWF6aytBd1pjNE1yNHdndFBGRGRUb05IRjVneGtUY05NVysyS0k4?=
 =?utf-8?B?L1BWdXdkMlgwbTVhRXhOcUMrdmYrWWF2c2VrKzdHR2xqRnVKUEwrclhRSGt2?=
 =?utf-8?Q?x40T/r8QvJj2Sjb9wh/fACkp7bBiqgMlTVKVoO6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXBEMk9kZkZMUTM2SVNROE94a0JRNXd1U1BnRGVTZlV1VUtlMzVCaVlCVDdS?=
 =?utf-8?B?Mnd2T0RPUC9WTkpWMHVFWTdoeGNUY0lBcmRod09idi81VmRqcGc2OXFzbmhQ?=
 =?utf-8?B?aDlkaXRtblUvdEdkYUt0eExoUy9MOHFoRC9Ub2tuY0ZnZWNlM1B4WEJadllm?=
 =?utf-8?B?ZUZWd1Zaemo3UXlGdzZEYklGVmpodnBrOWZMZVNRWndEZ2tQZ21zaXRNNGFV?=
 =?utf-8?B?WE1NaTVqUEJTMXhIZ0NFaUVwZFNiaHhCYlNuazRLMGF2R1ZCYlloeGJ0YVF1?=
 =?utf-8?B?ejRmWHNtWHlZK2s1alQ1dXQyTW81ZVBXSEpQV2xzSEVVZkYrNVZmdmpQUFdF?=
 =?utf-8?B?VFQ4aVhDSThzeDFJMCt1WWlwQ0ZpTmtxVHlJM1RnNStyNE5iUEdWdGJJSnJm?=
 =?utf-8?B?SkJld1lianZ6UUErSkhpU00rWnQvY0g0dzJtRE5mdjdlY1ZvaHhWUUczaDRY?=
 =?utf-8?B?aERwTFlXWE1vbVVVZm1yZEZMUm12dEJiS2lBWFZGdnFJR1VnNnUyUGhkeXhW?=
 =?utf-8?B?RmNycGFhUEFkOHEyK0NlWVY4UGtHZUR0dGhFeDBnRURSbDBxdFhzYW5tR2h3?=
 =?utf-8?B?WWlXSzlJWnY4QmxUMFFiTm1UTXZRQktWblhTYTR0cFMxQWowUytNUkhyQmIw?=
 =?utf-8?B?UjJXajNPclNRNzF4ZWZONHdFWEthbDlreHpVam1yU0liSzFib2tsUE5tWTJK?=
 =?utf-8?B?YVRwaUQwOVhTckhVdGU4akJ0TWFIQ3dnYU5YWTM2TnEyakVHQ0dLbzdwUTlB?=
 =?utf-8?B?V3pNN1VkQUVaNHMvNlNEbVlaTWI3RVNWdHYzTUNnYVhjQ0JSbHdkYWxBSWdt?=
 =?utf-8?B?ZGtUR0UrS00xRHIrYkhqTGlhMXJBdEFXdjRWY3lOVDd2UUltT25jSy9SYTVQ?=
 =?utf-8?B?QWtUQjhWc2xYS2ZTc0FrRVdtdS8zWlkyZHB5ZzA3bWZaVm5MaHBaRmt6ZzdQ?=
 =?utf-8?B?N2RjaHBuQ1lCMlZUejMzV2pqRkVZSTRXT0I3c2tEaVZ6RGhPQjRaNm1vODNx?=
 =?utf-8?B?ZCsweHk1VlhIT0phdlVIcVROMzhwY2dyS1o1dnRVeFEwdzhwcmNqU3hGYmQz?=
 =?utf-8?B?QVZpbHBWOFdIVkYyaTQyeHJQVGpLRXpkbDBqVVhqNW9WWDYrc1hJMU04Z3Z2?=
 =?utf-8?B?bW5IdENQUmxtMW5kWDVJRTdybmN4WWVIcGpqQXNGa0JxeHRLYmlzQkhEQ2R5?=
 =?utf-8?B?WldHRUJRemkwcXprcDVTVDFla3ZDWlN4UnFjcmlsRXA2alNQUGpTTHFUV2U3?=
 =?utf-8?B?NkhYWkx6U2gwSURzTTVVOWsyODN2ZTNvWWI3aUZsVUlONjM1dmpsY0U4TC9R?=
 =?utf-8?B?STRLWTNMMUdRSysvaFM2dXkxb0l0ZGFjTEdRblBlRU1CL1dsbVhRaHBZUm82?=
 =?utf-8?B?VEhWZUVvQ1RxYS93bEFLMkw3blExcjRMQWFyQ2xBclZlWWxiK1RmYW00WktK?=
 =?utf-8?B?M0RmNEx0dDFMVTMxd1B1UlhMV2N5YUdyVjV5UDBkNGYrVUk2RUlZTFhweDlG?=
 =?utf-8?B?NFJMVHNzVkxTOGpkRjE4cklYMHV4OGVadlUybGNwQ2xTckt2dGVTWGV1Y0dm?=
 =?utf-8?B?V3FuMVZvSFk4ZklqemtpdUpsdXQ5eHk5UUF0UDJVek5JcDUwNkpPUTJ3ankw?=
 =?utf-8?B?VHRoZDZjSW9HTndYN0R5R0FpTlJLTHBVZXFweVVub2pFdS9qNDAyYmlFVWNp?=
 =?utf-8?B?YzlYSmNxanp6ZUtVaWYzK1RrdFN0NkljOXFCRnRvc2FLTk42aHZoVmtNRDU4?=
 =?utf-8?B?VUQwZGxpVjRtb2s1dy94bXdJcmFEZWVNNzkwb0NXSGRVQm5hcWpuQk9nd2hP?=
 =?utf-8?B?T3B3djZHVERJamtBRndkb2pici9SZk4yUmZ4SDZ4YlROd2JleEYvazV2NDAr?=
 =?utf-8?B?bzFMYlhUcGJFTVIxOThKWGhVQWRaRWlleVJDYllVSVlDREVBWmM1WmhUS2RG?=
 =?utf-8?B?OVFZNmMyMFBzeThIT2Vkd1h3MFZZa2ZReEtSV0g3SmhHTjdiajhvVnhIaEF5?=
 =?utf-8?B?azRDVU15aXIvVzY0dThBd2FSbXV0VStpU3FCUVhCNVZHbkNSQ2RMcWJIQUxG?=
 =?utf-8?B?bFcvWUdrbm92RE9pMStWUUpCY2hhZGhlZmFaMjNRV0JRRTlIVFo5dm1pK256?=
 =?utf-8?B?MVpBZDkyUW5zeHBDVWxjRnJ4M1BOMVZCZmlYczhFWXpzU25ScDIvU2NWUjRy?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5639cf-129a-4969-8cde-08dc8ecce6e9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 12:56:28.0723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzLyCIksJ+CuXTRJ+7U04Zj+d9MutjzkJemCtlKLIMwSG3ytIYw02LFfvOUv2Kvt/BWngs1r5S05XfzjO9H0T4Ym30axejhVi+aEwBq4FO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5895
X-OriginatorOrg: intel.com



On 17.06.2024 11:34, Dan Carpenter wrote:
> On 32bit systems, the "4 * max" multiply can overflow.  Use kcalloc()
> to do the allocation to prevent this.
> 
> Fixes: 44c494c8e30e ("ptp: track available ptp vclocks information")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Thx,
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> v2: It's better to use kcalloc() instead of size_mul().
> 
>  drivers/ptp/ptp_sysfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
> index a15460aaa03b..6b1b8f57cd95 100644
> --- a/drivers/ptp/ptp_sysfs.c
> +++ b/drivers/ptp/ptp_sysfs.c
> @@ -296,8 +296,7 @@ static ssize_t max_vclocks_store(struct device *dev,
>  	if (max < ptp->n_vclocks)
>  		goto out;
>  
> -	size = sizeof(int) * max;
> -	vclock_index = kzalloc(size, GFP_KERNEL);
> +	vclock_index = kcalloc(max, sizeof(int), GFP_KERNEL);
>  	if (!vclock_index) {
>  		err = -ENOMEM;
>  		goto out;

