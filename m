Return-Path: <netdev+bounces-278690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKGpHGRH32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:08:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAB1401B62
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C5703047040
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0795F3A1E9A;
	Wed, 15 Apr 2026 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4ZROFxt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5935F3A3E6D
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776240298; cv=fail; b=JXbnizU77am95pigZuucXGG2RKQ5wPIOT0k+DVXG8gZBbrdC3i9S/KQssEFS0HI7ChGAEvymtX6lxi6ptwWuH6ZXbSvGBeviORKf0I5a4xTSG0rIsxcJVZJu0aibgeSxl/BIcY9A9qx+BPajiLIJsy0bAyXKozRuUtF8fIodR/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776240298; c=relaxed/simple;
	bh=abhaJoyHhRibSProo7nwVw7f9x6+zL/qtNEibR38cUQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ha/Vtgo0Ipa/2XLJ05qR2lmFUH4g7YQebF/OMJr3FDFiOIhc2IgV9K7T+DEOK8ih5GX386D9F7Wsw6UCRg3tSYVpP7EFJnAsWlBm9uayKvjx4P90WhoMnHIy8GI5rS3vcMELac7wjdAn9LMqRAVqTA/tjO3RiT0gMU21/94bvmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4ZROFxt; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776240296; x=1807776296;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=abhaJoyHhRibSProo7nwVw7f9x6+zL/qtNEibR38cUQ=;
  b=N4ZROFxtZPgVMTdmf9rRGXqA3ahxIjonVw/+eMpiv3HOqnv/iGRkFPdu
   cCA4dn4ZA72mCCLEi8P5o2kkRAjqA7M5UvxwHeEy5Odb9RIplQg++1A+z
   lwsKvPh5TSIKO80jO7dOc8zazMgR6pbRPhgzvotLSVfPiLMHvrqndM+/h
   y3N7SXRUoXXTFlqnHGqrfSZUEs/AA4op6Qxkc3mziLkcudnrEGyrYgN+q
   axtUrqv9IFbRbLGG0tT2qB60KAdeSgGfcvsEb+n24rONypAvt7YRDuK/t
   iZuStbyRSWOu9nug8Fvt9tLj+6Twwv7mnv5+c5PJrLHDtj0XSmYyoa1hS
   w==;
X-CSE-ConnectionGUID: 55sAr2TcR8K0vI8VwgoEFg==
X-CSE-MsgGUID: t/mqQpWvRn++gtDXXt/6aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="76241117"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76241117"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 01:04:55 -0700
X-CSE-ConnectionGUID: ozEXHCdbQ3WT3bwxQspFsA==
X-CSE-MsgGUID: 2NI0SrsjTNyJ9N+bX9JLJw==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 01:04:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 01:04:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 01:04:54 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 01:04:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOlkgp2gk0HgcBSIVsUIMAAtt7XQoRd34P7Iee4t7fZq0x2VbctfgEgoEEyjAwcvIDhne/NlZ4qTCwL5SUojMmWtkVdo+2GTdek97YwS0cb3os2kub3cbFxjtRDcUK3IousbPqVeOv9lnZp+5Nue7p0mE/s+m3YcpaTtWX32JsE2irXmxHrGVIzfekWxHpcbznms2cSfgdTLZxR3NRz8utj8RbZSDBRBztKU9Ff+s+MnefNWtOPvmTkwjnVli1IyaZREb3tVfjJa3T/vIv7gUZaUhfCOD3ViIjwPsIkV/DAUAXZgxUar0mzrmxG0yFYyDHma4W9kaSNH4qu4PgT8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeDbzjyaHKJaFiOPQYKsQmjS1q5SeWN/2jo7Jhfl8TI=;
 b=G22rpOzXFTAoBx6IVpX9iV0RfcJXI/FUh1QC8LO/xAUFpfL+hBDST61wx8TdokuB16MiTrt7QW+5tMUjBDJZDZv2hEOajChQdA6tdyRuGSz3CSJYIhE4Q01wAnc16nFnODV5sDv26atA4x3wqYLzlElcIP409zhTkGwDHi4B2eKbFooPlGgKIY68SvdZNaxxtBisX0zpHotOpyz4qZve8OFNCXvead19UB9o/zHFmHiAF5vbURKk+voVF8RQ8K7kWQXJJbDgV7Uv7o3puqp3w2dB96V2PNh1sdLK1+thEVEH7PdwrJnpBStEoBAIA4SjbN8Phf17IGb+P86dMgZb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 by PH8PR11MB6563.namprd11.prod.outlook.com (2603:10b6:510:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 08:04:51 +0000
Received: from PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572]) by PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 08:04:51 +0000
Message-ID: <363c5919-4495-4a85-ae2e-ea2ad0007fda@intel.com>
Date: Wed, 15 Apr 2026 11:04:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] e1000e: use
 ktime_get_real_ns() in e1000e_systim_reset()
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>
CC: <netdev@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, "Simon
 Horman" <horms@kernel.org>
References: <20260408083644.1621317-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: "Dahan, AvigailX" <avigailx.dahan@intel.com>
In-Reply-To: <20260408083644.1621317-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To PH8PR11MB8013.namprd11.prod.outlook.com
 (2603:10b6:510:239::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8013:EE_|PH8PR11MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: 32558038-80e7-4362-5fc0-08de9ac5ab81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Lm8Swzbvopp1D44tA57YzJzKj/C7/LaZ2VYc69gwRyGNPqR4x6SPeFlJ+DBwjWfINHdfo9E2LM7D0XRW/+wNZ8A4ostWi24ALawwvWnEYzQez//R3mruaNgL9TgVqv+t8awUSMcDT0vMSesKPSH1H48NyTMZn0w4d4lJ6usfmXh+2lIV3QMGnzE1fHs0hT0flLzGAhtQSnxd0bnsEF5j8i8YUTUCyymCczomdP7LC5GKWGte+ejkwMkIZXocw71GZOrJW00vt+P/lKKf+RC/YmWmc18ceWmSdE0qOwczqdTv/E97C+81mQ2froPhk1HyoI63uX26op82U0n7+aJsnDvfqmMoPumVfDeqD0VijD+a9TTzTaauXICCPknLXXr9+xRO5uLvvycW6hb7sP/ubyz+staTlo6+6aJGptJwnvwqoHJzl0cvwH7ov78455ywATDyo3QnheJOhyHF2fAQkQY1JUEO8YeiIUWJjBzcDOqQ11JwvPDr9kRXp4OfeEXxvd3+xGhWKGPbYfnNqWutlqy2iTRC6YO5NJgZLDz/sJP+9nj1wsnHchBvvj6193T9/UkqtZ2i97uY4PQeMTA1Pt/+hgJxAHkEBsDUF98deO876NpzqGlTdUCu7lNAOnI+OkXlWV748Ybl1MSk/Xw4zbK5YmhoQ/ohs6UJeMs6gQxp4dTop8eFZJBP708IhJCzfU99y6dui5MT1nUXYwQlVyqgB7NXcactJ+3pNDuUiLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWtVamVQSlk1b2Nyazlrd0RqeGViZU5pbDZUR25xcWRKNXVHbnpWNTNCMllw?=
 =?utf-8?B?aFFXVWhIcmpYUVJia3BTbmQ5bTZ2elloWVRDL0dsckdYTW9SNGk4eW1vWGlj?=
 =?utf-8?B?cHVqbi9TSHlsdjYrSUFWcWNnOVIrZ3dTU0NYcXk4SU81WGNYTERVcmQ4R01K?=
 =?utf-8?B?cEYzMlhSZjhMUDQwU3Irc3BOR1FKalUxd3c3U3lvcDhFUXJXYnNzMkRMakNN?=
 =?utf-8?B?aERGSFVpYlJCZVROUXNJUjFEcDZiNDBGN1RpcVdJTkZFb0dUQXgrbFRYNjBB?=
 =?utf-8?B?ekVRYjJZRlJ3dmpGbmZsTXVvNWRBa3o3TC9ZZnVNcnhwdWNsRWQzR1ByREFY?=
 =?utf-8?B?c1Nrb2h6VmhrT0puVDVmVGgzYjN2ZUdySWxaWlV6UW4rbHIzNjhHd3F6SGhL?=
 =?utf-8?B?eG8xR05Cc2RyUm82N0VueDBIOTRKekhNUTZYVGtDNHVsZWJUY2YvRGE2Uk5p?=
 =?utf-8?B?MWdnclNTUUZpQk1uRlhWUzBvVmp2L0ljTlRnQ1pIOGE3blpNLzBaYU5FMVEw?=
 =?utf-8?B?bFJDWGkydUVIdGFOSUpaRnJHWGUrZk91Y2FJY2xENzQrK2dIajhwZ3hFMXhO?=
 =?utf-8?B?VHdBZTVuZWtKMGswd2ozT1JZNzBLSHlReWJuWHJ3UmQvaGZ4VCtxT3ZYaFd2?=
 =?utf-8?B?Z25EM2VzclorRWszWnNySUhMaDRSbUhoSTRheThhaCtBdVZCeU0vUTB0Rmkv?=
 =?utf-8?B?eTV1Wm8rRzZVcGpmUW5qekJMQzYzb1hlaXpmTlNaUzFXQmY0YXFHVVZNVHdB?=
 =?utf-8?B?b2lEWW9rL0haZzFQbk5NQ0w2THo4cEZ3ZExReExoUHBpU2RyUE1IU1Zzd2tv?=
 =?utf-8?B?OUh3SWh5ZGh1dXFoVVcvWW5iQm1OSUZzVk5laUZjQUw1TW9pbWhMbUN3RWdW?=
 =?utf-8?B?STRMdld4MUdmeitVaHNZSUNudTdLRVJwVFk3Z0d0OStpZEZtRG9tSGhTQUFG?=
 =?utf-8?B?dDBnRmErMlRkYXVpRUV5MHFBeS9ZT2tpV1RHQ1dIbHczT3RPYWNUVTRzaVQy?=
 =?utf-8?B?ZTRDNHMzS0xtNlYwdnlaT2owYm9OOUhpSTVyZk5mRjdweXMyMjFaSlJuUHFC?=
 =?utf-8?B?NmNqdFRMTFlWdHcwRkdmRldHaW5PdmVBT2FzZUdLSE9KaEJObjN4a1d1VFVl?=
 =?utf-8?B?aVE3L1Erc0xMWmU3UU82M3RpZlRucS8yc3lmRDBYcVN0b29PbUZudm1vNXRT?=
 =?utf-8?B?eDB2K0p5Nzd1RFkyeGxWbzAzQTlNc2crUUFhUnRxNi85VklhcHpZMHhLSDZv?=
 =?utf-8?B?SjlBQlhhZlpoS0xOR1ZwYU9IWDZSMjh2RU9CRkdVN0VlMkhNU05WNElvZXFY?=
 =?utf-8?B?eC9NanhRSVhWQ25vVTlobUdqaWN4Zkc5ZVhjRU1oYVNua1d1L050aXBXL3Qz?=
 =?utf-8?B?K2gvcktXQTdjbkRkVnlnaW5Fc054QmFGVjFQT0lNRm9NQUl4YVVNK21SWlFN?=
 =?utf-8?B?UmM2Rngxc3RIZzJNY1JQcGMwZnBrdDJtRGt0bTJGcmNFLzVFRnNXYng2RkJU?=
 =?utf-8?B?cnJubG53YnJVV3Nsbm1PbVIxMEpEZmI0RTRaOEtJR2FYMEliTXRpeTRsUlYx?=
 =?utf-8?B?ajMwN2cvdVJKaXJlNmZVMzhYMDJ2SmN3RXBCOU51NnZCYUQxWE42SFVQSGlL?=
 =?utf-8?B?cG4yMlBETktwUGxzWUpKMG5VeElLenYraWNPdE0vckZSRUo0OFlBUmtPWm5x?=
 =?utf-8?B?MGdTdHNvOTlGd1BCQWVKbndUK0xvVDNib0xyMW9FcjlIYjJlL0N0ZWNUS2pP?=
 =?utf-8?B?NVNEWVdiZ3RRUEF1SUZZQlFWNmZLMVlHMjZjWEhIWUZXRFhOQ1dnclhROVN5?=
 =?utf-8?B?WnRrN3BtTnZxcUtIMHQwNy8zRFZFcytCRTFXd2UvcFlNMm9FeURyTVlGNjlt?=
 =?utf-8?B?dEloSHdaUFZoMnVETHE0Qi9uQThLY0dvOW03bXp2SjhVSVkvRVM5R21zSCtZ?=
 =?utf-8?B?UVJjUkgzUE9lbmlrb2xUU3FOdFM5UnlMZVRLeGZEN005anFqaW9kaXFnM2N2?=
 =?utf-8?B?M2pMV0tLaTg3cHg0V2NVL0J2UXJCMWV4VDlTNnFLd1h5MFoxSGcvWElqd1F0?=
 =?utf-8?B?bmlDcitvL3puNlZmZ09KTE5EYnhjRDc2RjdEekZoaXkvWXZWaml6blFOYUFM?=
 =?utf-8?B?Y1NqUDQ1QTdjYkNtQVJ0VDhXQkE3SkdXejliWW5qZmJqVkF3djF2NG5CVnZh?=
 =?utf-8?B?ZzNVc2FDYjVWb1FDV2NsU041eitjTHVvemVVeGNMTW44SHRSalVEcXk1NUJH?=
 =?utf-8?B?V3BhU1RvODdvakptdTg3RzBEWUVVSGY1aFNRNkgvajlzaC9qSGU5ckxlT2E4?=
 =?utf-8?B?MmZDSU1EN2xaQUNqaGEyM0k3VlR2RHBQM0ZtY3Nrak5vY08rcVE4RjBkN0pY?=
 =?utf-8?Q?3jC/ZUEFhUFKhaso=3D?=
X-Exchange-RoutingPolicyChecked: kKYsF4zBpLfI0pp+xVvaR5Y92HHhrJI7IeIOWlRCbytGa0cda8y+tqwD44FC1DlRrrJGPYYfe6CSK8TJR5p4bg7jeKkrXJxkxkNNli6O4y3n4+fnpW/EKY9h8jRJtlWzozIAx+3TtcnQQ3MWOssXGbm7wPTORD7aiEqwK5KrMNherQz0bCiupWfN6bN1O8m5PWPnXNrdPTA5Ei85WJ9ehwYUhou9LUlxSjeRYDljRtjxM++9En854HffRyqxLfYdRVPDYVywkDOboeNLhBsRFdKNLUoeuyndwn6bxNHdN+PGWvBIfzJjhiXadGXyFuONtPw1+UQ/htw4iaw1avKs2Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 32558038-80e7-4362-5fc0-08de9ac5ab81
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 08:04:51.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keGBjpmdpIx3vG3+LzYgo8t0+bwXZWkOAT+1d4R7sE5WeemYOyIQmqfITZf7zcaYoeMvOkONBav+mt177G9+jH70WiUvaL/P/ZDdd3oCRdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6563
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278690-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[avigailx.dahan@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CDAB1401B62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 08/04/2026 11:36, Aleksandr Loktionov wrote:
> Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
> ktime_get_real_ns() in e1000e_systim_reset().  Using the combined helper
> avoids the unnecessary intermediate ktime_t variable and makes the
> intent clearer.
> 
> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Avigail Dahan <avigailx.dahan@intel.com>

