Return-Path: <netdev+bounces-152116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB009F2B9C
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB431619C0
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419B21FF7B7;
	Mon, 16 Dec 2024 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKHjUf3D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C7029CA;
	Mon, 16 Dec 2024 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336814; cv=fail; b=A5EeHmGrBYuvo9gIwu+00pwAefLY0rwaxp84bgjeCQnXPm8W8npDdXiNl9y2OPw9zHz9d0nMlTqcAGersilw5pEdzmwwsTqL9zHfBv5cNRrtXtab4AEaTgCP1u15bwFeiFeTWFK2e1wlYYUvuxLEKhZVcxhezcVyL7BJgTDWZPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336814; c=relaxed/simple;
	bh=e9dE1UL9IllW8F0kkKQZ2Gl4Z3E0pDFsKpYdD3yf77w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HUjO0TDJ/AkP4a1SLyVD+jwPulyx9jocUKHX3s4Js/qRyhpPwtopZv9gXElqpYh/MZeJXfcJPDvoYN0zsQepYo43Vs7KnTA7ke0crzXsb4BSwhkKVJf7K10uflteDJVVmViRUXcwvk1NWOMBsNta74nGM1NIeUrfwA7vdh95F5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKHjUf3D; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734336812; x=1765872812;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e9dE1UL9IllW8F0kkKQZ2Gl4Z3E0pDFsKpYdD3yf77w=;
  b=GKHjUf3DDQRwH+oWnjWWrCtI3LxyYVrv/M0MQV4jpfSHsYBjPy/C9FPq
   rHdEFRXo0It0nY70fOw6lFa/SYpZPYOJGOpzwC7l3EoaEKXTgBTx1Si+K
   QaEiloFcOdDC0Bw/4nnMsVgWqCZamgf7xbJ4S9MfbfwKEdH1n+cIeF9KS
   AJPHqm5RCuRFZ0XJi4NOJEqzB67ePOfaMk9tb8YQZIdlq6jeFqoY32T/y
   TVVfolbMCuF5L4zrxySr1Q1l7vpxrTgzTGJb1WcdzvQ9h/FlgYsW3aV5+
   DCjP4wsu8y7c2JhrxiKKv55lWLAUZw86iRczl5WvNZnD/bhSXYW/G5jAB
   A==;
X-CSE-ConnectionGUID: DpuCDdUdSHK1KWuh+liiDw==
X-CSE-MsgGUID: O4VU5KaEQkmDBZUcWFi6ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34746149"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="34746149"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 00:13:32 -0800
X-CSE-ConnectionGUID: b1WRJ4dQTkWLdrdHg+s9qQ==
X-CSE-MsgGUID: dgG9eYJ3Ty+Jl2ysJdszbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="101986327"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 00:13:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 00:13:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 00:13:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 00:13:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvmGeU8/hm1eR0XDbB6oAJFIfm/N6AdC7sQVaEcHH7meQJlIbDBOFmN/lDqM9XRTw5YhK6u9A6K4tXpJQ9eT/PcqyNxNNmFBn84WDf7+WFbKpKn5O3g10R1fijLZ2PgdcqZKOEvTAWuiUuDMrMxeCytAJCg+7bWv/ccxWqRRtfLwA8sglFaQSl16QGsMbJ7vebcVgHLT43PYa0wT0TU6mm8mD1IWT2pE+yu2HlbMmOGI98clMuhBdthP29IAnvl82j3EpzYibl/rs7AAX/OJv+fWHNy7+Ru2mVuCppaAtGvK78wlQs+dkEg57iSj9Ph2HYDO7s7TeuRxwpPzsz3iUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaAQJykBnULZiy5H8Av6lTDScTeiIWNcgYmsAxNfjyw=;
 b=m5EhkKBuY1luctP+GXvDCl4IKe68qHcy4aA6upwZ9DG0cGs0mqcBzVTwxNT0NTA+QIbO2ftzuYncsUwbxH3htc4DcCqORkDQwf3ZzcfMybCJfcoW4dn5NRSvrUNO7uVWsNtAQc4XtQbUAZ1ErUtwED8sBELdIbhKpzlbIGBvk/lD6fn1YFskuiG0BihHMbiPuvrPlV3AlAdPwzRB2nCv7ksOSxscvTDnSjqMznqykZCsXT+9tWHj/HAKAA6DxjH6+v6aKkyw5EV9N1EHbjWkyxm+bBC89ey0nbXdIfTX9SWPpV54e54IsUzrbHkVgmZRrCB1epNhrfa5SM74D4NdCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB6845.namprd11.prod.outlook.com (2603:10b6:806:29f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 08:13:23 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 08:13:22 +0000
Message-ID: <d045f461-c60a-4653-9a89-81eafe2b12f8@intel.com>
Date: Mon, 16 Dec 2024 09:13:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/2] octeontx2-pf: fix error handling of devlink port
 in rvu_rep_create()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
CC: <dan.carpenter@linaro.org>, <kernel-janitors@vger.kernel.org>,
	<error27@gmail.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad
	<hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241216070516.4036749-1-harshit.m.mogalapalli@oracle.com>
 <20241216070516.4036749-2-harshit.m.mogalapalli@oracle.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241216070516.4036749-2-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0123.eurprd09.prod.outlook.com
 (2603:10a6:803:78::46) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c8f8c2-470e-44e6-6984-08dd1da981c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXBZdnZnejVjLzlCV1VYdTVBdGYwVWRsTEFsa3M2SFdvQU9zVEQ0UGRmcm1y?=
 =?utf-8?B?amtSRXNYaEJhajFSVStEdWVlc3Q0eGFCQ2IrRlU1RGppTHM0QmNHVjhxLzlZ?=
 =?utf-8?B?Q1FHaCthTDlYOU5QOUZ5MzBtV2hpcXQyeHN2K2lsUDkxeWtBaXA4MjNIRGpU?=
 =?utf-8?B?N0grS1NEbkcxblFiYXgxZEFlMG04NVZlOCs5Qjd2VjZBMGJkc01GNkYzM3Yw?=
 =?utf-8?B?Mzc2clVyNW5CdkFkTXVDRlNtdUNuYXVvK05ZMGdjamlsR1dKczJhUGpWVW1v?=
 =?utf-8?B?L05UNXllQVlBZXZ0S2ExREZ4ZlkyczhURU41VmZhU3UxbkxCNzdoaEw1TEUr?=
 =?utf-8?B?VXdEUjhDdDhzZXNTRVNRTlhGVmg2MGFDNjFvQkhuRDY1TkpBdGk5aHI0eTJ0?=
 =?utf-8?B?cC9hVHl0a3AwaVFXbGFiWktNVVQ5WitXY05PQUNKU1VKV1E5NzdnbmVVVWtu?=
 =?utf-8?B?MzFHRVJVRC84R0ltVUFLYWlQRTJxcHRKMVFNbjdRUGFHYlJMeXhNemVWUFVo?=
 =?utf-8?B?bGU4TFFtV0V0dkdEMTMxcjBNS3pUQ2pUNUwwMmQwMmRSTHdjYkxhMlhJVTFM?=
 =?utf-8?B?N2xKYzhsbFF2eUZPSm9rVDRtSWdQWlQ1TUJxOWNNK1ZYQXRnUVpPeTNOTWRQ?=
 =?utf-8?B?Nk1TUnlXWUtYTmR1UUdVb0R6ejZSdzZNYktjSVh1Z0E2MExsRktzSG13TDVr?=
 =?utf-8?B?cGNQeWFYU3FWYTZYdWsxcFRrWjRUSUpWUnhZUlVYUTA1WERJWlpoMVRwVHZK?=
 =?utf-8?B?S2ZQb2JXRW1VQVpmaGxwdVQ5RWJuWG10dGI4QWFBRnJ4OGpKaHNMa1IwUE5K?=
 =?utf-8?B?blcrcTZQVFRocjVZMmViTGw3bCtBMG9jYzhDUUZGQVU2SWtMeDE0dXFlRG5p?=
 =?utf-8?B?VWs3RUxTVUthNzlRYStEejNCZjB4WEo0TVFTYkZ1K0ovTjJKTngwOXJJbkNI?=
 =?utf-8?B?aWMzWklwRGNDQUtWN0s0TU5WcldWU0tHdThUckJWYjE4RUhRanZzZ3NDY21U?=
 =?utf-8?B?RFg4L09STWo3SlVoY09McmtSSFY3bk0wSGI5SHo0enEwd1JjVVFvaklGeWVr?=
 =?utf-8?B?cWx5dmdqMzNxWThlRElFVTU5TTExRTVKSklTY0RLaUZrM0xzZnphNFFzdS9l?=
 =?utf-8?B?UEpYUFFsS2d2OWF0dGV0bmJONkdHNlFZZUloMmZYazR3Z2hzbDlxSVBOU3Jh?=
 =?utf-8?B?QVNRMmM0cFl3Rk52WDE3ckNnbSttWVNKakZXeWR4cjIyVEhZSTZjVHpLQU5B?=
 =?utf-8?B?Q3E4R2ZwZENZczBlRkFzOVdCYXNyc1RqeWd1RkhvblVtbUJZR3dKbGgybWZ1?=
 =?utf-8?B?UDIrYUVyelphK1M5c3VDWXZ6WjNGZmZodTd1TlB3bU9Ga01qbENDRnVycWcx?=
 =?utf-8?B?eHZNTkgybVBaMUdQK2dsSVZWelhqWVkwQmJxRmFtU2NVNTZlSkJoNlZseGl1?=
 =?utf-8?B?cVc4dkFVTEFmWCtkTm1VckNodEhpbjdsRnIvcVZXbnMrU3F0VVRyVW9sY0l3?=
 =?utf-8?B?SVpFWkNsWVdJU3g3SEgzd3BCOXZNcjFFVzVHVm11Skcra0NhRkZjbEVpS00x?=
 =?utf-8?B?TUlrQnRPR1dIMURtMGcycjM5V3dhVHYxV1dFM0lPYnhlVVVKelJQYjIwQVhh?=
 =?utf-8?B?TFVZMFdlU0J6ZU5XMU9jSnc5c2NOOGlZMmFndEFuaEtnZFRsWFdrbjVwd0Zm?=
 =?utf-8?B?MXNvMkNsVjdFcVduODltTzVkbEtXaWtkdG5BVHB5Z1lka0xBUnI1czhTNUN4?=
 =?utf-8?B?aEgwejFXaHFWa0MvUEJlWFI0K3N5YWVlenpSNE1ib00vU0NzSFIyRHFGOTJm?=
 =?utf-8?B?VXJiL1pzMkVWVy82eWk2Z0lLUVhQcWNzeGpwNTVWbVpnU3VSV3FrRGhvK1l2?=
 =?utf-8?Q?iikSO+7i9df3e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFBVNDJEODN1NTBWOUQ5VllxdGQ4bWVEOTZxTkx0MDhOam0ybnlDc3FpTW9j?=
 =?utf-8?B?Tk92VTFWdFF4R0JnSlFINXZaS2RvRmMzeGxXeHVjNGpEYWhGMzVaMzhqSWpw?=
 =?utf-8?B?RFJybWtZeGVDVkF6b2hUWEhyNGNzTmVJSm0vT2pqNzNpeThycmhOVUFkcTMy?=
 =?utf-8?B?d3hzTjNqSkk1WnhlN25Pdm14UTh6aHVPMXZURTVlNndWbExWWGVGU201c0lO?=
 =?utf-8?B?TllqMTEyamltNTlLSTlTS1hyZGl4NUtBNW1ieGM5N0o0cmEvaXMvTEJjakw3?=
 =?utf-8?B?UzQveXZsVUxGZWJQM29HQnFuSVVzTlFhd0d0SHJhQVM1TTBGM2dnL2hESWJs?=
 =?utf-8?B?RTVoMlRVNDZHSVBTQnFPaHFMUG9WTlFqTXJGS0NxdEhndFppQ3NYVG5GcnN1?=
 =?utf-8?B?azgrZnBpQmNKOEpjSWt2U2ttWHpvNm56OUNZVWRzdXFUMDI5L3R2cnBOQnh0?=
 =?utf-8?B?WFRrZmNSL3gxYWkyQ0RkV1Q5L1FHN1FiRVhCVVBWVmpkNHdKdHRaZVEyamIw?=
 =?utf-8?B?WkdJZkN5aUtOazVFL1RBc1FpaFc1U3BqQnNxY291M0NkZkZYUHQ0TmZvSnlS?=
 =?utf-8?B?R3RKRnVjMkpzaktGVkVCY0RKKysvSnVYMXF0V3FEdUppOEZGNGpXK1FCeDJu?=
 =?utf-8?B?U0hJbXZsRmVDYzg3N01rcy8vdi9vYWdTVU10cTcvdUYzQ29mUWJQRVlEdEov?=
 =?utf-8?B?TXVOSmZIREV1Tm5PMTJGZFJxMGZvS3lWN0t1dW9RdkNDaTBsU0ZpTFZ0aTd4?=
 =?utf-8?B?YkdTNEo1cGZBZElLU2ZablJsOVVEanBTbWw2aUV4aU5xY0lDY2txTVZ1WlVM?=
 =?utf-8?B?V0hzRmZSZkVtb0drUDB2V2k5Q2t3TjVOMHI2QkY1WE5XWEdvTU13M0tYSXls?=
 =?utf-8?B?MCsva0JZMVpYaU15MndCZElJRTIyZGk0Z2doOHFtYUlmTy85V3FRWjBrWTZE?=
 =?utf-8?B?eG92bUEzbk8xK1VJS3o5THZSZWdnK1RMeElzY090N2VhQ1BaMVpzYnFPaUI1?=
 =?utf-8?B?NlN5TlNwZTFwS0s4MjFIWTBsZHhWVDVqb0dGRTUwKzlJeHhLaDZ3N1RmYXRu?=
 =?utf-8?B?NzFyeVBESnNPWUkyL1l0NFhVVmtObnBMZkxPWjlrM1RiZVc3dFJpTXlTaDhR?=
 =?utf-8?B?YUd2ZUhpN052eGl5bXArQVV5RHNOdXBBOTY0RVB0cVNTbCtNcjdUQUJOeEtj?=
 =?utf-8?B?TnRDNkZqbzd4SUpFME9hSEtHUktqa3R5SHFqM3FzZzE2YU5xSjdKOUdhbGxl?=
 =?utf-8?B?VUEzak1QNXVySFN5RFNYdUxDUkZDSmlBZjd3eERqdUw0aFAwMmN1YnEwTEFG?=
 =?utf-8?B?ZjBwaWE3cmthOFRHdUE3cWZ1TWZVcGhhZXN1SFlOR0FJeTh1NTNJNUlyOWcv?=
 =?utf-8?B?bGRoUy9kSmJQbU02eTUwaENJR1lUZUswUHA2Qi9Ra0VabTNpdkszVmxEMkFk?=
 =?utf-8?B?Z2Z0SSt2YkFvS09TSCtqQmJlbGtTNlRLYVdyZE52WTJqZXRCRGwrYXBzVFd2?=
 =?utf-8?B?aVlmWTVsMWRUeHg1TG9sVVA5dWdWbk1Ua29kdXVGYUhoZ0dBSHprVTZEVm1r?=
 =?utf-8?B?eDJ1ZzE5TnZPWVFSZllzK2ZKdlQyekhQTzd0byswMEYyeWliZXRCOThzK1dH?=
 =?utf-8?B?ZDNldE5Ua25zYitHSm44OC8wYUZYZmZPQ2pWTFQ1cUFrcnlnUllBV29maVd1?=
 =?utf-8?B?OUhwY0FsTmpBaHVLMkFycTRqWVBvS0FRb0tvMmpFWHRqR29GelEzQ3RjSWJQ?=
 =?utf-8?B?RHdUdmFhbEZQWERXTEpJbzBqWHFidFlTVlRKaUlKY1JST1BjZUF0Y055TGNV?=
 =?utf-8?B?Zis2RzhCN3FvRmJwQzM4cElXMlVDOU53R3IybVJVRHFBOXFZWU01N0FEV292?=
 =?utf-8?B?T3VDcnFTSTgwbDhzbWUvb29XL012WEpFZFVFZXpqN3QyaEtEMVhjck9ZQmFW?=
 =?utf-8?B?QmtoaGpvemdZTTNiMzVDTzlNcnVJdkpjYi9BRkZnTkg2dnV4MlNrVG9FMC9S?=
 =?utf-8?B?cHEvUXVyVWVjZ25lWUpLUWxFSFdPa3dwYkdOYmd0WHB0WmhHaThPRFhUYjZU?=
 =?utf-8?B?NkZIMEZDb3llR0luNHYwZ3NNZnRDZnFRQWlsamZkYVBxamQxcUpBRFczYldG?=
 =?utf-8?B?dEJVR2VlL2JjclJ6dGY4cVhRaGFqd3UyQTNGOW5aWnREbHkwWUJJeWdoS09B?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c8f8c2-470e-44e6-6984-08dd1da981c7
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 08:13:22.2388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tvrFVEakY6eTADWVsKbtkoRyxvk5DRv6kACNBUK6iyBxhPfsXYwevwlz1cv4kYf3wpLIrXphT8InRhYxZMCjSacPtg7ja3FN3rrtE3/dRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6845
X-OriginatorOrg: intel.com

On 12/16/24 08:05, Harshit Mogalapalli wrote:
> Unregister the devlink port when register_netdev() fails.
> 
> Fixes: 9ed0343f561e ("octeontx2-pf: Add devlink port support")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

same comment that this is better applied to -net, otherwise fine for me:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
> This is from static analysis, only compile tested.
> ---
>   drivers/net/ethernet/marvell/octeontx2/nic/rep.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 9e3fcbae5dee..04e08e06f30f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> @@ -690,6 +690,7 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
>   		if (err) {
>   			NL_SET_ERR_MSG_MOD(extack,
>   					   "PFVF representor registration failed");
> +			rvu_rep_devlink_port_unregister(rep);
>   			free_netdev(ndev);
>   			goto exit;
>   		}


