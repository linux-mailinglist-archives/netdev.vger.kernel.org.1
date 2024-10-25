Return-Path: <netdev+bounces-139153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA629B07BD
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFFF428144D
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4B021B864;
	Fri, 25 Oct 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCnQZBhB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245B021B849;
	Fri, 25 Oct 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869188; cv=fail; b=r2MZz78v051+6fqIoDIA9dJanLUCTHg+VnKnJzctXg9L66MHUq67AFOQ3usBKKKfi6cjTJYUQH8vuEK915ZjhHyfYYU49dk8vIz2K/DMWKnWpaOHxpJ3tfeL/t9IXPt/QcSaBPrrU4Mu8sVIi/yHZs4/V26tZcPDM/AVeG1WYJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869188; c=relaxed/simple;
	bh=ubx1SQmPgXSFuR1lcyhp6NLbk/FgAd3CRF1+JHcwkxA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aVJQM808sF9s7UG42iNY9J4QUuFVUBVTSBQojrW31VmwB25bPtbgJOze8hTlFPlBL0M++N+q+et7Ltrrumer5LZPgv7R+lmcGSqFtpuwpVB9vBy1UDFS2QVpneRhX1bPHom/HV87RT/aULy1fU6tEYLF0x54Ucn56VNs8gXIWHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCnQZBhB; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729869187; x=1761405187;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ubx1SQmPgXSFuR1lcyhp6NLbk/FgAd3CRF1+JHcwkxA=;
  b=lCnQZBhBx4Zvqegvykrbvjj4sboLp8m9r2MAHVYm0lXj9RVhdEuJ3IX3
   BCrp6ycGaZ+mOiiO8EKMda3zmb8/AS1BffIhQWmlLm/fzCqFp4Tl9X2DK
   a9BYIgHiZGRk7e/XSG4wyPvXh0bBHEJC1tW2L499l+DEk+Jr69SbfXtie
   8+01GZxplz7s3KyAZIQdXi0ps51Dv9isseS98VfwFn6p4pu344XtlCJZ+
   H9Inv6q7/N6rQLlu09SK+LjH1RMpH19+o1FNL72zMwWaiYon0jcD2g2CB
   OwsGTE5VNiQyRkYe6BwQKjSCOxzVKpll7KnI6PFs7Ux2NIsuSQi4TB1qD
   g==;
X-CSE-ConnectionGUID: VSB77eLhTAukXh9jxV3NeQ==
X-CSE-MsgGUID: Ch2o1KcbSsKQlkDPdhn24A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29486550"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29486550"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:13:06 -0700
X-CSE-ConnectionGUID: mZ+uuCQATiWCZBPrhtVnTA==
X-CSE-MsgGUID: pHDXeUiPTXKjkbhxJ9OHEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85710387"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 08:13:06 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 08:13:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 08:13:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 08:12:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJ+9ye2ws7DpZT0e4UnsY9A/d59gz2IuV8qNviywXtS0zVwDNbnzvBt986Hu4mefAye6ML+n5sanQFGgWsRM9Z/mHjI8mfDRmMvtEqyGESS4wSTko4puheltdKgeTiG0vTz1C/E3Nf4eU+5m/LBeiNzV/+X5Xb9gh3PjXDhQGmYM07nhOBS7XrhAfnLhqnYuMi2CNxz12VnXUh8jL39Va8q9qq6ttJmCmmVCm90XBRvHj30AUC6Xu9RFm3Hp3gFNclcyybzt7b0zDwrr6iQIPHVlLibDJkOVY7xuRVi5naYnhJuBL+KRAcV2QeFV/DdH+ZsJ37dgql+ZtWKcHFzxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NlZVaDt03nFoLOHrD+igbF96l+EbsLqoP4B0w5VSQY=;
 b=xLicW2zJCVSYPdk56QTD+EhsffT7HtbWjNe51MeuwxZW07BBakiF/3vFAUlNDrqSOVAJ523YNciSqneZxV9uksiovc5QU332e6DdwTZR5DMThaz8/rfGt/w6IfHW+MF13kFhglp5xkFyAy/HZw8FtgdvNuDiXZexwA7eqO56tJN8Lb3lUCuJG1MyvZamPXthTKEJF7l4DCLf5Xl+sskdOUfHsGttFd0B/lFj76mMU0DaCBReNy1ySYHs8rXJmSWp0bvK2iPiRY6XHifv3WbfDuVdaFDl4af5zfhyE8iqSxbDuxSuJMONw2rMh6c6trUJ1WhpxmkISarw4wNNTUFKlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 15:12:54 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 15:12:50 +0000
Message-ID: <59a875a9-2072-467d-8989-f01525ecd08c@intel.com>
Date: Fri, 25 Oct 2024 17:12:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: ipv6: ioam6_iptunnel: mitigate
 2-realloc issue
To: Justin Iurman <justin.iurman@uliege.be>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241025133727.27742-1-justin.iurman@uliege.be>
 <20241025133727.27742-2-justin.iurman@uliege.be>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241025133727.27742-2-justin.iurman@uliege.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0037.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee0e8f5-f09a-4ae0-61e1-08dcf5077dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjRYbWgyWngwMWEzSTRNUXhMellCcGxtd2k1YkVtdWRIMnpYOWJ3QkdIcTRh?=
 =?utf-8?B?a3B0VE93R1g3TXYwQzdFNmFmTUpiaksxdURlZWhoVXNQZFl1aEdMWmVyWk5W?=
 =?utf-8?B?Tm5YVWo0UklRYy9KeisySE9ubzhrSFBZdGV0RFRKbGd4UGJHeG1kK1NKTEo2?=
 =?utf-8?B?MjNQYTlKenVuTVhDOEpQc25YSWxWR1lBUXpSZDk0MVVyMlBYYWRqYldOVmhn?=
 =?utf-8?B?N2IvMHJ0dno5enZ6KzlYVko3VTEzdDJvRDhjZVo3M08zVXllZDZOdmgza2RD?=
 =?utf-8?B?RndPeW9NbXJTYlFXYXgvRVg5WnRLSFZFYzduN3BhSUdDVk1uTGQ1dHRGVHVq?=
 =?utf-8?B?YnpwYUlUcVhYaHpsYUdJU005eDFFZUVpbmhIZXU3dDdMRytxendmdnU5b2tS?=
 =?utf-8?B?cEZ6NWpjdURhbDRiaGZlU1pNdHdPbEVFLzF6UUZoY3BpWXBRT0g0VS9qREZV?=
 =?utf-8?B?M0FkTjJzemUrSDlUTC96QnlDNUgzakROWkhVdjMwdGYrTlVvMXFxVUgwUzYx?=
 =?utf-8?B?VThyODRQMU9VOEFSYmRJbjJjWEpjMllKNDZaZnBkeklRcS9YaHR4ZTRQOVhL?=
 =?utf-8?B?dWZGc0lTb05WcGE2dmNhQ2dSSlo3K3lUUG5PbmIzQkdydVlDMVdLZ2hMYzZt?=
 =?utf-8?B?QXpxdXJrMnVKQjA2OUFMb1ZJY2huZXI4cm5PWjNlN1BwSW1xaWdKcjBBSUpU?=
 =?utf-8?B?UFdJZXQvekFRaGw1am4xMzJhdUFsVUdWb1RVTFVqV0dRR1hIbUNKUEhhZlJN?=
 =?utf-8?B?Vm9ONERqWHFnVUNWVjlHMVpaOWxiSExiMFZibDFQalMyTnJyb0dsYm5qNllj?=
 =?utf-8?B?aG9UZ0FJMCtvY3VzSCtxNTFmQ0t0N2RxakVsQzI1VUo1Vm8wRzlVMElmYThD?=
 =?utf-8?B?d3pEc1hnV1VZcnNkaGtmeXBsNVE1b1MrcVJuOEcrOFl0bVJDd3lQdVlLMUZj?=
 =?utf-8?B?TVZ5d2poZXN0bldOVW5zc2xid0g5NzBWWWNONTkzYTJ0eC84THpqeVFiTEVl?=
 =?utf-8?B?T1hTVE0zNkx4QmJhclVYZnovT0huNUpZenVWREVZcTRJMUhyU2pmSEhjRk5n?=
 =?utf-8?B?MWZMdXF4YXZFNmlZbDNUd0tGNmtQbjc4L29hVWNZSS9mb2RuM0g0aXI5aDRq?=
 =?utf-8?B?YXNRQWhseUZ4UmpRemRSaUowWG91NzZRZzlwM0lMUjZHNTJZN0RreG1TdDBl?=
 =?utf-8?B?Tk9JWDUwbGZhMzBXTXpLU2h4UXZadjBMZG9NNG5nbnRxV2piQTl4eTk3TFFO?=
 =?utf-8?B?UmNrenR5MGh5OEJmWFM0UlBZK3ZsdTdOckYvT1ptZkJLVit2NXlkM3FQYU1q?=
 =?utf-8?B?ZFJwS3BEYkhwRTVGaTZ5MTJOcjZCdGs0L3JnMXRzR3k4Q0Q4NWROeFdVcGhU?=
 =?utf-8?B?QjJiNHNJNmtaRHMvOTgwM21ON3VBM2JFYkE0TGlORDM4M3RxajRvN0t2dUZz?=
 =?utf-8?B?RXhVYUtOdTZuNGpaVkJVNjZvTFFGU0xZYUt3RkF6KzRBSjcrRm0vaEk1WmU1?=
 =?utf-8?B?MFpTZ08xcGc1SEtTMWZNbVNBWVFHWE4vMVdwaDF0WVJLYkhOSmdwZ3ZmY0p4?=
 =?utf-8?B?akNOU3dNVnVLVHRUcmRmQmwvS3ZvTjNtcEdhVjZyV3FoYlFxV3FBc1RiVEpQ?=
 =?utf-8?B?WXJaVXY3bXNBdlpvR0krRHVscUM2Z3BibmkyTVZBcUNnaVhib3R0RUdUWWNi?=
 =?utf-8?B?WFB5L0tSd253K1MyV1ZtZnl3c1NFcG1wMFROS0lITDROWGZ6WGJ2Y2RjakxB?=
 =?utf-8?Q?O+UuIv9uPLfgEuFECzDniGHuxX3EyT3/Vbpt3L+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1pUV25nNENSNjFCSmIwSXNpK2dQTUJmRHlad2hZT0xJSU9leU54RFc3cDZj?=
 =?utf-8?B?SzZ1dSt1bE9jR1ZzVmVTRDdrQzBmU09DdlhURERxeXVDWit5d3lOa2xXTjhs?=
 =?utf-8?B?cGJGME0yek0zcHRhUVFKSnEzVVN2cXQ1UEVOVDR1aW45WnY0V2tpVXJWTmJD?=
 =?utf-8?B?R0M1dVRSZzFGYXdLN0JpbmFZbVp2TWtJZWFURGE3cGdkRUlNa0pQUjhLM2R2?=
 =?utf-8?B?czZXV2lGbC9aVHFnVktwZVdWancyVG5iaUQrREtJRjFRRVBsemZQbGp2TEha?=
 =?utf-8?B?TGk0RjFQdkdyUlFKTXdhM25JRjBYUUNOdkJmTzZick5FditLQ3dOUFpUTjhw?=
 =?utf-8?B?V2F3N0hGbWR4NGQwZ2pxTDMra0VKNmkxL0xIVTRNM0E4QmxaSUxvYVFSaGpZ?=
 =?utf-8?B?Y1Q0K243bng5eEVkZ3NQYmpGcVFGZ0lTS3RacUdSS3o2Q3ZUYVZTWkpuYW9F?=
 =?utf-8?B?Z0lJWjJLU3hlSmRKMjFIK3Rnbk0zdWVFVGE2bngxelc3NzJaZjNSQnJOemVs?=
 =?utf-8?B?KzdXaXNTVGlWdjcvUHY1SDhTT250dzl2NXYrWm8rdWpTUmVodUpGaEoyejd2?=
 =?utf-8?B?aVVCSnhxWk1WVCtwWUFDQ2RFSE9LU2ZQbFZPK1llWVhTem5hSGtFS0RPWHV3?=
 =?utf-8?B?SjlJR0ExVlcwbzFFWkNRVXZ2ZlN3eU5jdjRVa1BJRWFZekxwbGh6T2xxeGpL?=
 =?utf-8?B?eHlxQmJyeDNDZ3VSdDR4QUJRdi8xOVVqNjlJaC95dnN4VFZ2UzlQdnNuczho?=
 =?utf-8?B?U1NnS3cwWGdtOHkwRU1ibkdKWHBPOVVhcC9ySUluRlBPRzBtZHU1Qmp5QTFq?=
 =?utf-8?B?bTR0clVWQThWbVNOTEZJU2xwUGJLdXJOYjFvRjFSVEd6ZHdLTTluVHVSKzhq?=
 =?utf-8?B?NWxxZm9STmF6QVIwL3FWRmRveEhTYlJTVGF1SDM2THBCWVZuTmJJTWhrdUFq?=
 =?utf-8?B?cG51eXFtcXVNQXJ2U1hHcHF6ZkhKcEgzdUpGTnlRcmtJZ1ppc0ZWcXZUamJL?=
 =?utf-8?B?UGY3RFRWS2NZem1RU0l4UmgxWmJtNG5FTllmbS9BTDR2b29IMmdmR1BudUZ0?=
 =?utf-8?B?ZVhzODNBYUozRGpXcGk0V01Cdlk5cHU2NzZQVklBa3dwcklub2RXclJiaXdo?=
 =?utf-8?B?SXpxTk1taGJUTlY1bHNOd0h3VTQzcmVpSlQ1cUpMQ1ZlSU9YVXc3Z0VpL00z?=
 =?utf-8?B?V3VrQkg2VG5RbUNsNjFrOHNEQnR1MDNUeXdHVnN2a0QycEt1S1Y4Slc2TW53?=
 =?utf-8?B?K0lwc0ZLajVNd1laM1EzRzVjOGxiSTFtTExKTWQ2NFNCRWhOQ2VGUFdiR1By?=
 =?utf-8?B?Z0wvd3U3WnBmUlY0d09xYmRCVVB5Q0VDQmRoQ1YwMjJsSStuUjhtNnVkOFVU?=
 =?utf-8?B?VElWZ0s2bDlwMlZiSGJFbXNJTy9ZbHJueWpTTjkwS2ZZVTM2Mk9lZnFWWFBF?=
 =?utf-8?B?N3FSVHdZbVZSRU45TllieEh5WFllc2tUbnllMEJyWVpCVjJVSUNpMHQzMlQr?=
 =?utf-8?B?VkwzSFhLMFBNV3ZvL2pzaWFjRUppc3BjK2I5ZldWRmc2c2JPVlVsczlyM2JI?=
 =?utf-8?B?aVQ2SzNIZ0o2TUlvSUVtNjF4NlhyYllWU1VscVdXZ09ZY0R2dnYyeFBVclVG?=
 =?utf-8?B?YlF2M2VwWGV5b3dBbGxLcnFnTy9FNk9CSHFudHU5MDlNYjZlOWtMRGlNNG90?=
 =?utf-8?B?R2pNcyt4cjliTnhZY1FoWVVJK2FDSXNTUVhITEJ3cytmOFMzVlY5YnAvTDRl?=
 =?utf-8?B?U0VnbUdyT1JFT1NZN3ZnZEtlMW1yckNsYlBBQ1FKY25idHFXYm9nNWhibzB3?=
 =?utf-8?B?TmtHeDVpdjBUM1ZPbWM3Z0RzTWdCREU4UFlKU0RIek10Rit4S0VTTXY0cFp4?=
 =?utf-8?B?QXAwT2lrSG9oa3VndkxyclpGRU1IK205eDdoMUk4R2tZTDdvcW82TkRVOWFw?=
 =?utf-8?B?NkJpOCs4ZkRjR2F6eWhkWVR6VzdWZDZtSHFTWUV6NDF0aU9lNkd4MVE0dGJM?=
 =?utf-8?B?L3ZJVVRCRGRDdEY3VnZiMFlMR1hOSENyWCtENVV6VkZWNFZKVTl1WS9UalhT?=
 =?utf-8?B?RTFIalhyaGFkYXlvam0za1VoWDhVMm1qQ0xsOWJNM1RLMGxWTUFEZjhCTDh3?=
 =?utf-8?B?RHozdkt2Vk1GczExMW1IUS9SdTI4c3UwcXBIZ3Z6QUFSVEM2d3dHWU15cVN2?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee0e8f5-f09a-4ae0-61e1-08dcf5077dcc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 15:12:50.7854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvFFhaLewdpsXDKU0AYl4A3rFNuMbCg00mL9Hgdm0wHzXDHh/0iaBqYNz0l0UYA7OItVXU0h0ThsphlL/KLhdPzZGDVtAvUaOSuBoWuUJlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
X-OriginatorOrg: intel.com

From: Justin Iurman <justin.iurman@uliege.be>
Date: Fri, 25 Oct 2024 15:37:25 +0200

> This patch mitigates the two-reallocations issue with ioam6_iptunnel by
> providing the dst_entry (in the cache) to the first call to
> skb_cow_head(). As a result, the very first iteration would still
> trigger two reallocations (i.e., empty cache), while next iterations
> would only trigger a single reallocation.

[...]

>  static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
> -			   struct ioam6_lwt_encap *tuninfo)
> +			   struct ioam6_lwt_encap *tuninfo,
> +			   struct dst_entry *dst)
>  {
>  	struct ipv6hdr *oldhdr, *hdr;
>  	int hdrlen, err;
>  
>  	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
>  
> -	err = skb_cow_head(skb, hdrlen + skb->mac_len);
> +	err = skb_cow_head(skb, hdrlen + (!dst ? skb->mac_len
> +					       : LL_RESERVED_SPACE(dst->dev)));

You use this pattern a lot throughout the series. I believe you should
make a static inline or a macro from it.

static inline u32 some_name(const *dst, const *skb)
{
	return dst ? LL_RESERVED_SPACE(dst->dev) : skb->mac_len;
}

BTW why do you check for `!dst`, not `dst`? Does changing this affects
performance?


>  	if (unlikely(err))
>  		return err;

Thanks,
Olek

