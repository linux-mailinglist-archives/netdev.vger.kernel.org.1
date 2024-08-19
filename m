Return-Path: <netdev+bounces-119664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93DF956896
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CB4B21E58
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED5E15CD58;
	Mon, 19 Aug 2024 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWKO+jzh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26644165EEF
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063594; cv=fail; b=JyJ+T6dlHg06XHxH3kxDF1al6mXfwfi/uUobjsaYpRk8AIplkyQMkQZYWBWyoZc3iR37yEkhucr7v6FmFkxVCXPaKA0GY2tvOqMXfXcEQ69viUMvTdEsdbEjz4HD8NSIHJkYtAP62NFNm8SX2xijPBb7VoW8Ox9iUdpKhN4sVkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063594; c=relaxed/simple;
	bh=Fou/9zikdWddKYAaxyYBsi/3YBpetSWKfA2YlodbPNU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kJhiRc7ixLz7f25FVx0gy91keZpYNkBEPX2wiUNbPL4jdYRI5iq9wyjkFiSlrb9K0l//N1zH7ja8yAXaAuIZImWYXN2jkaQxLd2zn+zpKhPruGjC0B5bJeIdCUiDM1uMlc94dyZEcOXXRGEgQK0Q+u4JjrIgKlEeHHg/icz87jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWKO+jzh; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724063593; x=1755599593;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fou/9zikdWddKYAaxyYBsi/3YBpetSWKfA2YlodbPNU=;
  b=RWKO+jzhfBWI7LkiQbWq0CYQsrxQE3lcA8R+cpYp918qWDJEXEUv+tJa
   2IObHuqfsNCgFimaBa2G8htOGtSdi03n11Rj/de7/KYHel4Iyr0Dllv/n
   guj50gtczMM0EXwK95Sl5S+uFsT+hEngh5hBjfmINpI4ZQqqVlaIRaGMM
   qIwPEyA6Js3MtMIVKg18GQqIYV1vG7IBOkcxW3xy0lBrLNPbVTG2yDw2P
   H56jyA2SZq+8EEiI+tqC5R/apjzxQ1sP3PeAlAH90U5lvw2bVUaKKFGfX
   5AvhkN4pNo9u2qO/nBWc/0jJkyLE+y3eh7ghfwexgNkVyPObh3Q06Guy4
   A==;
X-CSE-ConnectionGUID: raWosIurTSWS6Pxzkyx6eQ==
X-CSE-MsgGUID: +2A3vfygSZy5ahTAAlQU+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="21924149"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="21924149"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 03:33:12 -0700
X-CSE-ConnectionGUID: Ynp/nmxvTaiNMASmiqp+fQ==
X-CSE-MsgGUID: hrMKs4hTQkOiFeEVQZLk3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="97807552"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 03:33:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 03:33:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 03:33:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 03:33:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 03:33:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/Dc00LdRubToWJXE/s2PMlqxBxDfcE6FPOjGSp5qSbaW3Cck8lBQi9BiLhUsSR+LqEODXyYnyIC/j8yHU1makJ7DF6KvEj1UfreieL/ig0t+K0JLxoQ/9qUSuVnlXMZANQHj4lPEMitsEabZWl2N7+OIJDwIwEpSjWXH/z0ersL1e9u+kgxpx1FbsfItRdJePNxIlUOz3fGWhvNHKmAw18GxFAXOG9TAoaYaPOTqp5F58B9Gdj4adNVfJ1eDTpH6BRmLyA5sVMoipGYbnKn+Y9qx+KtUS5JawcvgUPt6JVC5yaUVsLYIPOvABiYMhWxe97un6itB7mvK9yJR6jbNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiE5t2PstmASQePzGHkZKEsJtJG5j91/xTDpemgaEas=;
 b=VqumB+RloRExE7SkituyuySky0dlxJ+oAxjlSjqtgbZGKBtzpg38Iia2e2FW+8QwAn8VS6n2xoEotziUUrSQ4cS1TtftSzq1GNIdNsn6ydmKcw9/TU5ZaeWVT9qeog28jqskYPmugZPvG/wrBdGi2tEhUhtm7AZuFwF3fkgqFaNas63CeqIpjaKGMfG78jpNYQsWXyGJr0afnYI/p4tcVHgX5aQ0amhx8PwdCPFjCHz3kFLSbWD2qXLY/yJisYpBhC6q+cFj9lis65XxRtasxPDe65dKGK4QFIqFIgPbodh+3KWukGrl/QQuMOmyfWW1wl8l8yQmYjqE75IPNfknuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN0PR11MB6085.namprd11.prod.outlook.com (2603:10b6:208:3cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 19 Aug
 2024 10:33:09 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 10:33:09 +0000
Message-ID: <740e184b-2a7c-4196-835b-09724dc69c6c@intel.com>
Date: Mon, 19 Aug 2024 12:33:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 9/9] bnxt_en: Support dynamic MSIX
To: Michael Chan <michael.chan@broadcom.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <horms@kernel.org>, <helgaas@kernel.org>,
	Hongguang Gao <hongguang.gao@broadcom.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>, <davem@davemloft.net>
References: <20240816212832.185379-1-michael.chan@broadcom.com>
 <20240816212832.185379-10-michael.chan@broadcom.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240816212832.185379-10-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN0PR11MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 27116942-377b-48d2-db2f-08dcc03a51c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmZDTGdpWGhyNDdyUjdPa0c5ZHBiSFFqV2E2a3lLc0FUaGVqUkpUQVZWZlBz?=
 =?utf-8?B?NjZTOVVUOTQ1ZkhIZ21qakFpaTgrRW02SSs1aGc2RFhmOFoxNEwrTk5iS1pO?=
 =?utf-8?B?SnUrdEdGNEl3SXJJTTdjZ1JHMWM3NU5ZUC9xdlVBL0NZbnRNS1k1UmxoN1c3?=
 =?utf-8?B?akc5QUhsYWdCVVd0R2g1UHUzL1FrbGY2c0NuOFJ6QTVVUTJyYU9xWiszb212?=
 =?utf-8?B?U1p5c2d3VlR2VE5IUVJqT2hyMCtUS0xSTGZDeE8vY0puZ0FVd2xJU2VjQk5z?=
 =?utf-8?B?UlhoRWpFbTNMOXo2Vk1kYlB0RTBDWnhlSGVGRitTQXZ4d1hNd1JkWGJlTEFk?=
 =?utf-8?B?T2Z1ZGlFNnQxQXUzMWFiUStNT1RNQjY1NzI4OFJSWWFjT0VVQ3NFV1hKVTk3?=
 =?utf-8?B?cTM1VWNJYnBIdW9GMXliQ2JTbWlYWjlOaUZXN2l0QndGZmZFN3FLTkt2ckpz?=
 =?utf-8?B?czNGSE9oSWZWZjRsekx1MmNkdU93a2dXNGw4ZW8xM1RQd1o2NGdQTU9IZlgr?=
 =?utf-8?B?Sm1PalpDQm1NRXNROXpHVi9HZXVlakJDQVpWL0tNVFp4WlErUTF1ZzlDZnhR?=
 =?utf-8?B?a1k5Q3hodDNyRDlDdmI0RXVZRXpYNmlJRUxRbHlJSVE1ak9GR0sxL3I5YUdy?=
 =?utf-8?B?OFVKT2RobExSQmdhN01sdFZpbHc3SEROYytVdzFHNGNLMDBBR0VFVGJGMENI?=
 =?utf-8?B?OTJ5YmNVZ1BrU09vb0xsZEhFbDViNDY4QThyWHRISmJRclNBUjRESnJxM0Zk?=
 =?utf-8?B?VjJFVWdKeE9RZ1d2aTNERGdLRlQxR1UyeXdPRlgyUkFlajVrc2MvNExIdUQ4?=
 =?utf-8?B?WXhCMHBQYUV6b2NNVDRRUmM3MU4reHdVT1lLRENwWXpYcDA4RG9sOVdIeWNj?=
 =?utf-8?B?TjIraGlwakcyM20xV28zWk84R0UrRmw1NW4yM2RZR1JjZVZja3owR0tFY3g0?=
 =?utf-8?B?bWwvZWVJSjJ6QmtEaUxNT3k4bkJyWnFvZTZOUTBiSmVGU3lYbDlpM2VzV0x6?=
 =?utf-8?B?Yzg1U1IyT2pTZVl2eXhGcitsVnA4bEJ5dFNpN1M4MnFlOWZCdGQ4QXZDbjJB?=
 =?utf-8?B?TXF6dUNseTRCMXFYKzlVYm1OV0tBWGpJOVFxeTd5NUwzNXUwdGpnY0dBTHRN?=
 =?utf-8?B?SHh4NllNR1lWMVEzNnRHWEZsUmZqak9vVkViTHYvZHZlTGFUVmF1VW93RUQw?=
 =?utf-8?B?cmppZmJKVlVubW5TRGpBOTBsMm5zNzdIL2pNcDQrZmJMZFRCZ1p0c2txWEoy?=
 =?utf-8?B?Qkp2WlpCdkxtVGJWc1pMZnVZcVluNHR6djRnQWdNSG5hRkozbkRzMitXZ3hy?=
 =?utf-8?B?WmJuNmFmVGhqTjF3dHQyS3pmRmU4NzZwMWtJbU0wWjZCSEJoUERveE5vUzV2?=
 =?utf-8?B?OG9Ec1lNbmd6MW9JVVZvUEtFanYvaWpjQ2tVSUFlUk1IT281Q2l1Y1pXdDht?=
 =?utf-8?B?bTlkMkhYZ1RFUEZRTFB1SHA0c0FranJEQlJJOVRnb2RZSXp4dFlobk8rRXRo?=
 =?utf-8?B?Q2cyTjQrYXJ3aEZXTFc0V3VZZC9tckpWOTZFVFdaSnJsYTg1MWZlRG90ZDhH?=
 =?utf-8?B?eWYzTmthbzBFYmpDWDBUdmZDM0tXZEkyNDF4U3dsUDgzWXhyNmVhb2lTQS9B?=
 =?utf-8?B?WmNUa2s5SEtvWmR0SEpVV1hOdE1udi9WLzQyTEJBUG1HU0JpNEZWM3V6YVE5?=
 =?utf-8?B?amhqUFVlWnZJSkpJL1BkSmhndVFjODI5Z3RwNTlHSldwYmVhSFZGRml6SWRC?=
 =?utf-8?B?b2w1N2lkSDBnVU8zVi9aYm03c0kzbkZYejdwb0NHc3N4Y1NNTjNCb1lRVWUv?=
 =?utf-8?B?bllCUWJGRzkxTDltVy8yZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXZpdGlZcjF1MmpxM1R5OU9jQ0Voak5ENFFndlJjU2JibklmNzAzQk5OdGZG?=
 =?utf-8?B?bGRLYlM3aytYaWFjVUc4ellNSDhyNGdsZjg2Z3dlbzhrSU1YODMzYlJ2c2pZ?=
 =?utf-8?B?Z3VKNExXenZITjh6djZZeTh5QXlicXh1S25IbWZYL3BrRDRmbkY3WW9KbFVS?=
 =?utf-8?B?NWkzb1ZpRDhyOXZOVUdUOGdqQnRJeDNBeFN6ZTl5VjFDTGhQVUp6amhyczNT?=
 =?utf-8?B?ZjZ1dWp4dVp0S1VZeVBKaGhoNWR3WlEwaHRmUmRqcmxnL25BZVh0ZHQvdW5U?=
 =?utf-8?B?dkdWSHBnYURYc283L053Y2RQZ2RYZEZ6NTRBY1VKb2RtTlN2L24yRHFva1Y0?=
 =?utf-8?B?V21hbnZiUnpLS2hBSGRJRk9xcEtTd1NoalFEc1plbkIzbGZJMWJtWHFjaVR6?=
 =?utf-8?B?Zi9DRUdiem14bkJVTW9OS3l3UnovOUdVRFRQNzVwYjYrb3F5OVdPWjB4MC9D?=
 =?utf-8?B?RmloeTJrMTNPZlNLdHJkS1Z4eXZwL2xMZmxtSVc3LzR5NjNsVGdRK1AvMUhV?=
 =?utf-8?B?d1BET2FUVjB2a1hZSTF4dnh5U0pQSE14SVl0TU14Q3lBVmhiTUJwWEhucVhZ?=
 =?utf-8?B?NGl3bmpqQStQMjNLRkZmc2tqZm55TlI4b3B4Yng2clphVzZ4ZzJaaGxBWktD?=
 =?utf-8?B?dXYrQ2RqVjl2STQ3Q1I0OVltZVpkMTJYanhYSzR0NXpQeXFxaGtKSGk3V0Nq?=
 =?utf-8?B?dXgzS3BHbW5vRnprWWVwb2M4dDNaMkxZTDc0NnFRb2tvSlV0ZXpsSmdVUHMv?=
 =?utf-8?B?ZE9heVRNOGhWdXRxbS94Z3VzSzhMSG9yQktaS0YyQW9tN1g2T3Zrd1JuWS85?=
 =?utf-8?B?TVgraGpzbFRrbnhyczNpVHU1dTJua001QUVWTFVUYUV4UmFHSGZQUWo1ZUl5?=
 =?utf-8?B?c0htUi95VGJrL0F4YlpNYTdRYWJtMGRhenNZSWNVczVzdG5UNWdvWWQ2WVBM?=
 =?utf-8?B?UklmeWhtdXpzNi9aVEwySWVYaytMOUV5a3ZEWU52MVhJZ3EzK1BTSloyaS80?=
 =?utf-8?B?TDN0TUFGVU8yc1M3YUlaMSs1NnlSVFE0MmlZU2piWEY5Q1pKMTMxSjkwZXU2?=
 =?utf-8?B?MHBUVVB5WG5JV0FNSEVCZFYwOExwSmErUDU4YjkxNTZkZko3TU1nd2hYM1Uw?=
 =?utf-8?B?WkJCVDRQb1YwNXpFUllBRTZ3UUNpWjZoOGthTUxaZU9scUFwQzdjRGN6M280?=
 =?utf-8?B?THZUWm9TV0lpQXlMUVVUQ1lsci91TCtjLzV0MVBtZTJrNFRqbUpaZmtDUVRi?=
 =?utf-8?B?Q1Rsc3RpNEtuUENuZC9RRFFJQmREVGJVL2h5QmdtSTVwejBWV0RUQjZxWThz?=
 =?utf-8?B?cDVWUlpGUzZCT0NHZ3IvQWhZTjAxdVQwZjZVdDZtb0pHMjEwS2wxZ09PUng3?=
 =?utf-8?B?TkxlVSt4dmZ5bVJyR3JTR0VNQ3Fla1NZdkZDK0FHcjUxQithSy9lRGV6ZGVV?=
 =?utf-8?B?dTI1V09oRThWQ3pCSnM1WmdPRDlhTnc3OEZ2dEVwVVRiWlBVRCtXMXZXcEha?=
 =?utf-8?B?bnd2cmFZakJoMFZqU0VCZ1YvNUZvbGFSQkszUXFDMlBPLzljbk1QSUdaU25B?=
 =?utf-8?B?TWxqNk1PY2F3dTZiV2Z5dDhLRC9QOTUwRlpyWXRYZjVybjVCbWo4WXJlZUUx?=
 =?utf-8?B?NnhueW5hcWFaSEc3UkNIdUFZZXBiMklvQUJ5S2NObnBwMlJuYS9aNFlZck13?=
 =?utf-8?B?RmFQSkE0cUVZZ1BpTlBmV1lFdzAwRzdZWXBlS1VpNyt2ckNFUlliR0VZemRE?=
 =?utf-8?B?OWNnZFA3VUl3d1QyWndXODlwaUErTTNMdGt4cGZSNWFteHBGakRwWi9UbUVT?=
 =?utf-8?B?MzNJeG4zd283WDVMZDdMYlg5Vjl0Z0tBS0ptaXlramFpZjZmQU96VkQ5cFk5?=
 =?utf-8?B?ZG83ZU1Sck1vL0d1MEtWcXd3aHhTN0JUSEN1VzVxTE50aW1RR1dIRVFUYXlN?=
 =?utf-8?B?QkhXdFJmREZsSzhNTFNSNUpxL0RFd2xKS1ZSQ0hLUloyWVBXUWZ0b2xNNk1T?=
 =?utf-8?B?eDhaWHdSa1YxSWppc2M5SnJmU1ZyaFFhYklzOVJyeUlMcEZVemYvUXlhODV2?=
 =?utf-8?B?aDZOUFZ2bW5pQ0x3MTdiZXkwL1RuNXdqTjdJdHoxSmRIZGpRN0gwd01WeUFp?=
 =?utf-8?B?UHpuKzVNdkd6ZlJIL3RPWG9TOVZCUE9mYmxEV0RSZDdSRHFFcExOYVBweDY3?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27116942-377b-48d2-db2f-08dcc03a51c9
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 10:33:09.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzg9v74PDSMEDqptwIz4mXCUxmKPaEU3WbXG7mWxGtQuq37oWA7oYQWwMurlM9KMwJq/lhbh2FtdGwHBdRlcEN1Sd8HeiEBii+YeN63vRDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6085
X-OriginatorOrg: intel.com

On 8/16/24 23:28, Michael Chan wrote:
> A range of MSIX vectors are allocated at initialization for the number
> needed for RocE and L2.  During run-time, if the user increases or
> decreases the number of L2 rings, all the MSIX vectors have to be
> freed and a new range has to be allocated.  This is not optimal and
> causes disruptions to RoCE traffic every time there is a change in L2
> MSIX.
> 
> If the system supports dynamic MSIX allocations, use dynamic
> allocation to add new L2 MSIX vectors or free unneeded L2 MSIX
> vectors.  RoCE traffic is not affected using this scheme.
> 
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> v2: Fix typo in changelog
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 57 +++++++++++++++++++++--
>   1 file changed, 54 insertions(+), 3 deletions(-)
> 

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

