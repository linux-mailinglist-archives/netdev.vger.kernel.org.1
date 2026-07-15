Return-Path: <netdev+bounces-307624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H/QGHAXUVmqwBgEAu9opvQ
	(envelope-from <netdev+bounces-307624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:27:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA971759B1F
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:27:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=g9WgTdOu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307624-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307624-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB6E630A86B1
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCFF1A304A;
	Wed, 15 Jul 2026 00:26:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D19C42BC45
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 00:26:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075207; cv=fail; b=JwdN6b9gLY77Tm4j4FzKssUsuC7D8JkSgvLAho2jFmWyIpAMCZaHHwSZvOrclCAm9thLWAGHIKyyD3fLX8UXJQxJVtn/Dzz/MK182odoW3oiqVrdceFrKe9T0BVgE4WboRr2BXL37EAN//JF71BLqMsbZfA2PHTuYX2XcT5EY0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075207; c=relaxed/simple;
	bh=lSoOIugDOD14z7obWIogazAnB0089PhaIFbTohKV6ws=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pKhypenHMWmxEAHcyrNtU8wdwmpmjw1NCx8/wsQmMF0zbpEOZxKl8t7TD0ICSChnNwEFZpr91m8qsEJzE7udxnAnczq5ZXR7g/s+4rIzCQ4+KU0UyS2d/SS0PrhrPWwAvt+LiQbbo+QZBQH5u+vrW073BbL78YYdcynU7X9tFH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9WgTdOu; arc=fail smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784075205; x=1815611205;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lSoOIugDOD14z7obWIogazAnB0089PhaIFbTohKV6ws=;
  b=g9WgTdOu5yDU2H6iNb/HwOT5agVyM8Fr7UOsEkm0a9Q3DNc2IyFXX8b4
   z4Bciws9M7o4XijheGGMvaXh2SQfE0ohy4B/lluzE9QAVKg1ewqqkfB5R
   GH5tzGAYNecsUikP6HW43CXl3wVcxqFl6pxzFkV5JFF0wU0GGTUxIhszU
   AgIlmjrjhpEKa43ZM3KquAqP4f+BtIAAI/RBYwF10VJSDDaDE3fV+FNp8
   oVfLsZlG7hq3KeWwet7HnnZPaM/mbivf9saM9qq69oILYL/qOYNqZu6Wr
   QjxK2CvLRYPvZTiqg17UPrcNXKjQhlSI6XaJ7BjT7Bd+QZCeE2uRiDxO0
   Q==;
X-CSE-ConnectionGUID: QZb/9YNER6Km/yfqojClTQ==
X-CSE-MsgGUID: XnV8uPswTAKwoz5DXUNY4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88530329"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="88530329"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:26:44 -0700
X-CSE-ConnectionGUID: y73uvR8ER8GkyBJBn6ng3A==
X-CSE-MsgGUID: At1vwX22TE6prCS21MxLfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="260907647"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:26:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 17:26:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 17:26:43 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 17:26:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YinDETX3hqlBCUgb2OOBLyIIysOJ09h9ewBkjcsbvWIZpVeLdQsbTFojHP/FM7GdpwglAPdf2WsxxBZTUNilaThfz62vyL/PKDlEYURxTZ/2DST48w7n5rN2AKftOIgvDxKknbvZ0PYU9S5P49UxQYzp1GoA+NXmQ46qXMDmgvGOUmh+YCkNSQFu6Dz7W0zBbx3Xqr8cJ2Z2YfPJmx7UenxrICAZA48Wya/p7TVFlrXlILh5pL4AnJj4FOaiFwCkOp4sOzPxvsus5Se16a3XFAGhBdtgpldsqQMNAT6o1sZzXzpAz53j9jtdxFbxvKvxsUB7RKG5gFiYEevgJvEyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ad1ot+f8ib5q1W+pTLuSQMWXfKngbFHF9ipaH67g/IM=;
 b=EZEwQqwJpJEjxz5YQATHQWy8u/IkVWWppafnuPWpZpjlgon8QJgOrOU30dbGQoWjtoJmRgQm40dz+VIKRvG2/QkD7iDRwtxKCpgla2EZ5d+Dj5kltaT4KTOQ5CwDSwPw0xmg+jrhGSKEKr/YilAsnlmnzF2LzswtgRBWYcLDpH1dXaFuUpupi7XjHsctjCMoepJULagO3mi8X4jAdovNTwXQaVma5HPdceUFbCs+H00ogzYvzL/R7ZLGwJrLP/6Zd20h1GN+eUNWUmxt+hKWUvhiXaUax899p+/SxGefulZ4b/OHqlzXqVC3jRFAxCT8S4aVtMUO17XFak5oqqbzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ2PR11MB7504.namprd11.prod.outlook.com (2603:10b6:a03:4c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Wed, 15 Jul
 2026 00:26:35 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 00:26:35 +0000
Message-ID: <6ab773c8-6c43-4c53-86ed-46bbaecb8073@intel.com>
Date: Tue, 14 Jul 2026 17:26:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: libwx: disable TX VLAN offload for
 packets with >2 VLAN tags
To: Jiawen Wu <jiawenwu@trustnetic.com>, <netdev@vger.kernel.org>
CC: Duanqiang Wen <duanqiangwen@net-swift.com>, Mengyuan Lou
	<mengyuanlou@net-swift.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Kees Cook <kees@kernel.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
References: <069DF89AA8029189+20260713060441.276612-1-jiawenwu@trustnetic.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <069DF89AA8029189+20260713060441.276612-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:303:2a::25) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ2PR11MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cba4b43-54b2-48e1-fbd6-08dee207ba19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|56012099006|3023799007|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 0z+x5y2ryg/3D8oY+svp78T6tRYDtrJuk+S5v5/UlrT2DUFYHqOp3v6g7sqPS9x0SN1CHPdwA41VsQGlnQubauD6nFU3KcGdWy52Sbi+D3W+cNTsWiCwwcHM999iipEuSTyJZ7RMKKmykPvBiy7mBhrpwQuUkR6u9ttasnYCKyBp+JZ+yYDgmX9jxqOqbF1idEUfq+phTkk3ffty32stbcl8+4/Ydp6rFHchQX3BrDg0ZB8cwH1vLxSZZUF7fG8tmm41XI7UTaEE19DVT9pnsozf3PjJfmFheEWPniAFw+6aog5cDwVhMPKtbsOtOtxG4Zpl2NWuZ82/lYGnUdkJgi6hAASUhkwdHI2TVqtIiOnr3cFVCwr1nksZaaOGScdpwPx/+KoNVRnRFdUNTlRUyRygoCqUiWtDZGUQMlQkYObgkkDn/1a0Q/4GAvLe0fByH5rC0BGYbOk/eAiguSdvS0L3y51PgXY0XRMWPHxBJMil4m2rm+HxKFVFNw/+cmsEDI68SEDVreI53FMRjvta2LE3uger3NzSiuBNEV0YMIrGYP+P/0M71lSUpa7YkbAuMUd2lo/O4zySkj3yPJ3+gvyw1TlqZatYCVoxqUlObPGJGgdQHPqa/9O+mmaQ2UlrNufhpLZut3JaWZqOgpSahhllKnC2ruOBF603QYlpUAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(56012099006)(3023799007)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTZRMTM2K0pYejlyRXhPZVAyZ0kyYWhXRXBUaWFadnlHN2RHamRSR1lWY2pZ?=
 =?utf-8?B?MEo3d0ZxQ1Y4VjdiYnlYYWxiemR5VUxuQU4yUmxFV2hIOEswejlQaFIrQ1Z0?=
 =?utf-8?B?WDJJdlQ1Q3ZLSnpFWTlMOGI1TU5sVlh1czRoMTdJQ0Qya1JBS3FubkxZYlZJ?=
 =?utf-8?B?SStXK2E0UmpBcHArbEJTdlo5eHhtQmlGeFc0Z0lBVGdoU0VsQ2dVMEVuRTZ1?=
 =?utf-8?B?RG9lVEd3b2NWZXNrNXlKWkpOV0R5RHhnVDBValRNek5BOWdlalc4eTQ0R3lW?=
 =?utf-8?B?ejVpNmpncGRZYVlRMHJXa3NDb1YrOEoxbG5VeEZOVDdQdExzSmVxZCtaaGQ5?=
 =?utf-8?B?NW10YkJpMmo4R0hKUHVDbEQ4K3Z2ZHRqWEI4d1hWNGtzLzNhWWh2enNhY1g5?=
 =?utf-8?B?bitQazZ3dGZwU0llWWhPQU4xbEVaTGJtZ1Nmc1FXMjhpOXNVb0I1aytxTVcz?=
 =?utf-8?B?aXhGVGJYSjlyMEJCQnY4YTNJM3J5RHZpUzc1ZXNJYzlWZmpMY3QzN3h6aU4v?=
 =?utf-8?B?b1dVZFU2cm0ycmdwckg1NmpiTDhIVzFLSldhdWdmRGFlbm0vYS9LQUVLMXJ0?=
 =?utf-8?B?cUg1QkVtYjV4Mm5jQlZWVEovUDc1ak5CWVI4VnpLYllUcGxjNkNOQXFad3ht?=
 =?utf-8?B?M3hGMEg0dnVRVEc1ZnR2aUlRWE9XSWlkMHp6UWgxWG5NaUFTNUl5N0NQL2lo?=
 =?utf-8?B?OGp1bW4ya2pzNzJYa29SaEo4N2hyNFlEc2JTeFVaZzZJdDNwVjk4STdYdFNa?=
 =?utf-8?B?K1ZqcVpiU2ZTRG1SRnNsYjVnbXlVd2ZjRlFwTFBtZnNDaEZNUyt2MWE0VGhr?=
 =?utf-8?B?Nk9TZ0lkMWtBaXBlQ2E5aVEwNWhBN1hnMHRhVzNiRDNkQVR1T3c3a09KRm95?=
 =?utf-8?B?Y0MwQWJXTWxudURPSjMzTDZER0FFbVFPV0ljcGZHMUVnSkRtNlZSU2plME9h?=
 =?utf-8?B?djlxRW9HY1JkUVFvU3QzZ1VEUmdGTm83UWM0anZYSEpPTlFnTTlUMUFiSHAx?=
 =?utf-8?B?RGZ0ZzdlWUVrNzYwOTJnczFEUE45UXRQbWkvNTFMT3ZOTHZPb0JBTmk3dG5X?=
 =?utf-8?B?QVk2ZnhoV1pGNDNlWGpYalNTZVZCWkFiQ2hSRGJ5eVQyK1A4T3hNd0ZYN2Zi?=
 =?utf-8?B?YWNycHM2L3dZQUpWcnlveTE4SzNubGFORi84Rzhod3hwbkc4akZyV1lQdzN4?=
 =?utf-8?B?NjRSVkswcEo2UUl0NEZ3MSsycGpjbmU0TFpES2xIUGRyRUJoZVdNM1NEZ3hi?=
 =?utf-8?B?VjdXUVpsV0tPZFJIRjEwdTZzdGVBYU4yVVhZS2JQQ2svYTdqZXliY1B1TkxL?=
 =?utf-8?B?bDZsc3paNm1aaWV6WnFlaGx6UEVRM3hrSlptT0JzL3pLOWxiRjRXcXg4OU5r?=
 =?utf-8?B?cWc3TGNsVTNrNy9SM2luaUM2bU9jdDdFbTJnOTdaMlIxV3d0S2xsNFowejUz?=
 =?utf-8?B?TGtxbWFiVU9BMlpkbXlRWmxINTd2SmliOHh5VzFhR2dQZ2hiTmNZN0Y2bU92?=
 =?utf-8?B?eFhrWWw1eFFvRjkyWi84dnBmS1lMcVUvZzk2bUxENGYrUFBEQ2YxanBUYjhF?=
 =?utf-8?B?R0xHT1lnTzErUFNTR0R2eDNBZktNUkxYVlowY2M0Zlg4bVpIYUdoSlJUWDV2?=
 =?utf-8?B?ZHhuMkREMzdxQWdUOG9DKzUzanZjS1VWU1UyaXNzdkx4bCtNZEYra0JidVZM?=
 =?utf-8?B?UUtIQzNabWZZakxCN2lUYU5kMStickRHYkFqUjNpUzVCS3NXeVMzVExNa29T?=
 =?utf-8?B?aS9kNVdxOUVSSjl5aE56NVQ5c05PMUt2YWpFMjhPM3drMnBhK2tFZjNrK21k?=
 =?utf-8?B?ZXhBNnUyZEJZbHYxVk0wQTI2YlczcnZHMjhjUTF4QWFUZ3d1UGhtZ0dRWWtY?=
 =?utf-8?B?QlBpcE1ZSkJlR1hvNndoelpjL1o1K1lyZXB5dmxOcEVsNkJMQ3pHZ2d6SzU4?=
 =?utf-8?B?V3VZaWl2dmdGTkoydTdFSTZweXNUeTAwSVgwOS91MkpFTkVDUVNsYSsxek1h?=
 =?utf-8?B?elJmell0WFcrczdWbWhNV3ZKZGFNbHV2eWcvSHV0eEFFd0JOUmNZalc4WDFO?=
 =?utf-8?B?N1BaT2VZSkwvY0VRUWFEUEFmTjd3c2huM1lNS3BMandSZXltT3V1QmVOa1FZ?=
 =?utf-8?B?VGd6S1dUOGdXRXlzd0IzeGFkRVFhL0VGZlZCUHV0VSswR3lKOWd6Q0FLbGI2?=
 =?utf-8?B?UmFiL2N3V0lSaGxTVnM3Rzk2YllxbmQ0Sk9aTk5KOElzNzBmT1lLSVR3YWdR?=
 =?utf-8?B?S3AxVUtMZ1ZJSGMwWUduUnlTU25NbU4vY2xocWQ5eFFqTHJCcWVONDNkbVBP?=
 =?utf-8?B?TWh6ME9VTVlVQzJhdkRmMkoyVXNLbjRPS015YWtGancrZ2tOakUwZz09?=
X-Exchange-RoutingPolicyChecked: LK/ireiAIAo8F5BwNkrztayYWhtMUPXiTGYDSTK2Gkbomh95+7XRhWTjmytcruadjO0LZBD6N8L8+Ef6smyfAg715dABYWwx5yIX9JlH9ghOBTmroD66kTh/I7Nx27oEruYwZWVSFcKqs3R5RxJSOse7JSHo1zBBIoVfWf31NAuwNO/N10N9w6yR+gmxeApvkedsGKJhCP8rtYA0Rud6ZstWgvVUt/oKkEzhYzFhYtOQ2YO5XiMWo7HmkwvpeIK3o8IcZy322XUr2hfrUztHvyp+znZJMv+cbw9F+/6Z/qL67baB3J6AK5Hq+SvNzThJxu9KMOCuzFGvdwGEbsau+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cba4b43-54b2-48e1-fbd6-08dee207ba19
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 00:26:35.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/vQdluEchxdAf7T7I3eYVrxAvs3vjOOisSZ4jDtEVp1qxKZshGC3RS3+oZEeyPKGsYRfEK43NkWWeRc9KPzAUs5g+6h+4EYIxKwLF24lGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7504
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307624-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:netdev@vger.kernel.org,m:duanqiangwen@net-swift.com,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:przemyslaw.kitszel@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:dkim,intel.com:mid,trustnetic.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA971759B1F

On 7/12/2026 11:04 PM, Jiawen Wu wrote:
> The current hardware does not support TX VLAN offload for packets with
> three or more VLAN tags. When such packets are transmitted with hardware
> VLAN offload enabled, the hardware may malfunction or produce corrupted
> frames.
> 
> Add a check in wx_features_check() to parse the VLAN depth of the
> skb. If more than two VLAN tags are detected (including both the
> hardware tag and in-band tags), strip NETIF_F_HW_VLAN_CTAG_TX and
> NETIF_F_HW_VLAN_STAG_TX from the feature set. This forces the
> kernel networking stack to handle VLAN insertion in software for
> these specific packets, ensuring correct transmission.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>


Is there a reason this was targeted at net-next instead of as a bug fix
to net with a Fixes tag to the commit which first introduced VLAN tagging?

Thanks,
Jake

> ---
> v2:
> - Remove redundant 'parse_depth'.
> - Optimize the loop.
> 
> v1: https://lore.kernel.org/all/C1BF77C0E073A40C+20260710071831.210196-1-jiawenwu@trustnetic.com
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c | 24 +++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 814d88d2aee4..34542b3dc884 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -3228,6 +3228,30 @@ netdev_features_t wx_features_check(struct sk_buff *skb,
>  				    netdev_features_t features)
>  {
>  	struct wx *wx = netdev_priv(netdev);
> +	__be16 type = skb->protocol;
> +	u16 vlan_depth = ETH_HLEN;
> +	u32 vlan_num = 0;
> +
> +	if (skb_vlan_tag_present(skb))
> +		vlan_num++;
> +
> +	while (eth_type_vlan(type)) {
> +		struct vlan_hdr vhdr, *vh;
> +
> +		vh = skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
> +		if (unlikely(!vh))
> +			break;
> +
> +		type = vh->h_vlan_encapsulated_proto;
> +		vlan_depth += VLAN_HLEN;
> +		vlan_num++;
> +
> +		if (vlan_num > 2) {
> +			features &= ~(NETIF_F_HW_VLAN_CTAG_TX |
> +				      NETIF_F_HW_VLAN_STAG_TX);
> +			break;
> +		}
> +	}
>  
>  	if (!skb->encapsulation)
>  		return features;


