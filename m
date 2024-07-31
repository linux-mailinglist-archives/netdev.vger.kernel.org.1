Return-Path: <netdev+bounces-114593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB36942FD9
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 15:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A751C2165B
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF791AE871;
	Wed, 31 Jul 2024 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y131UsxJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E881A7F73
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431631; cv=fail; b=pk6kV7u/fQnnJRGaYQMxvTP0AkHjWNd1lBLjqa0ePdBEfsI99rFjgUnLiZyiAV7gpxIOBiLmdqIYWIQa8WqoXQbltkkQNJXY7bK71mtxdRsti0rGTs91mbnLjBBtib6yewufh8FIBGoSQpVCKyu4WyIaX97SWNr9oX1hpk0iJnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431631; c=relaxed/simple;
	bh=TX50ASQgE0VedZ8X6mFNdHeizHMZbEIoSJsN3JJhz9c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lHQCLUb2k0u6I5adrcLE0Yu/EU07h631GoP6XvpUcYkmEgIQgk6O5DnmqBIafuHpXVG6xLzuRGTT16P5eZngFR9mL47A2yy97foDSLm85mDEqfiB23nYk5663P6VtNlVOYY+RztHYI9djC+4xRxCvIDzNKf3pN8xdUdOAWfOKcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y131UsxJ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722431626; x=1753967626;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TX50ASQgE0VedZ8X6mFNdHeizHMZbEIoSJsN3JJhz9c=;
  b=Y131UsxJNnoUdB9MshBGV4Ov1Rk3rt/uHjngk8FziaimgLKq736szN+x
   AR8JP+1t41olyhKVQ2FkQBP9Syzs/8+LB9ERe+l/5vZgqRnUcS3hGnoqg
   fra+Ks6Hcj6y/C4bRIWtpvlRq28Oh3bg9rxVoUWfaSPOMvRZN+DA73kau
   urYESXjr62NTZXXeV2qdDGmaM3t/n8VlZ2THwZ65iWH1N36NPeDRaU30i
   p/aUteaMprQLsdGa29mMCCOBlECy161ckHWB3RF9nIJAJ0sfXPCKgr9pI
   9StpGXByvdg7LtQWFUu5AVdNUBn0Qcb+HsZV0LyFDU8H7BtSQzhqHQZEL
   A==;
X-CSE-ConnectionGUID: ondeCm+UTxaOnidPYGnfRg==
X-CSE-MsgGUID: X0NcoH07QIuE61Eht0ZxHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20258163"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20258163"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 06:13:45 -0700
X-CSE-ConnectionGUID: HDLUEnVFTLGn2zI81AlM4Q==
X-CSE-MsgGUID: 1Jmbo8kWSPaqv/TqTM+j1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54929702"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 06:13:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 06:13:43 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 06:13:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 06:13:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 06:13:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMmMXHso2JX/JGf4CEjmZx8udDwSiiWDGxTH8Q8WFSYXKdtw0TlXVxAg9kZwuyEvKkOkRkgoTU5oYz134wVJI90BSsiFU/LxHAH1xH0TdBXlW5itRWDj/v/wW7R9R+GeGeR99aSh9mdfy/zOZtlQhMVVeF9JjrrAUMhq0QoHEDhaARfFQyD2zc1wCMk1S6FB9twFbi89GdVS19S0z4EPRU7+i0K14hLK6j0ldRyExXbJMt+d05XUsvnKdvlYMSUVazrnuHYKkfIRuabU4HFkGblwZuSjobIhVDh4VVr7a7/SXqXsY3XNZ5UaIPgJ2sS/UOFw57O1rc0OKHz5UkjTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySaV92IZJXo9s5C+UO1eP0rW8394dSLhGZI4p9MeJbQ=;
 b=kVOhQ4Nm2YYS7azyx5dVo1k0Ba71M6MQOcwsaa7NfPJEc3hdPWzoDNl54JshBIYc3Y9PkeEXHb5/h/f8M9MJ5bCNUMqF7iECu193hEiD0KM7MAPp6w79HEYkZkEg3PG3x7Rxndm7s1fVv/JItnra9EVpOlPK0O7ApbZg9BJqjM1qtnBLQz5Nalli92duIPr+PEsd9S7T1RE0N4yFNFUcdlbZWRQmbayV635YnQCdAjnGZcPaAw7dSUXvio/LcCrFXo83dYvFrvKfl7Mn7e1uR9n0dYxxQEKKz/nUf3c78PaljApA2Bjengrx6287vihdWwFXnRVled7N7VFmiC73MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 13:13:33 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 13:13:33 +0000
Message-ID: <ae01c389-6bdc-423f-ba87-a11a85667ad3@intel.com>
Date: Wed, 31 Jul 2024 15:13:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] mlxsw: core_thermal: Small cleanups
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Vadim Pasternak <vadimp@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>
References: <cover.1722345311.git.petrm@nvidia.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <cover.1722345311.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::13) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CY8PR11MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c107dcc-427f-4388-094f-08dcb162944b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTczTkZFSlVSUENSby96RjdXa1FNRktkaWdFVkRjWDZHVk9tVGdlc1gxR2dL?=
 =?utf-8?B?YkZtWFJZeTVYS0trZFg3Tng1am9pVkFQQ0xxRElHZmErYjM5NXllLyt2T2Mw?=
 =?utf-8?B?OS9ZZjBsU0diTHFsdG0xdDRLbFU0aHlicmxSYkt4aTBsU2ErTDhTd2c3T2Zp?=
 =?utf-8?B?VmZlQ1dJYnBEbGEwOWc2Zmpjd2YyK0FLR0hFWCtkSGJHVHQxMG9SdVlwa0NJ?=
 =?utf-8?B?Rlp3Y0FBME8yR1dIQ0p1NS8xTzR2Y1ZEVTZ0TGY3bzY1Qlo5SzI5TW5iRmw4?=
 =?utf-8?B?TkdYdXF6NmtvMFBBQUJ6aU9LNjBBZlVNakFjMGo4NGdvYy9WQUFrKzY4bnlp?=
 =?utf-8?B?V2NmUzFad0Mzb1VuQXZGdzlGQ0IwejR5OE9TMjhwdnplOVdPcENFVTQ2aGIy?=
 =?utf-8?B?NWN1NGNXbDRvMFBuamtvSW5yZ3lJbVJYQm45SVQ2RHZaUytsMFF4b3BMUnhv?=
 =?utf-8?B?TGJieGhVc3VHbHRUak1QaUIvalludHBXcks5L0RsY3VEUGh2WmlZU1BlQUJJ?=
 =?utf-8?B?TEw2cDYyVnZ0TG9RY0s2RHB1eVJmTElkYXVydGxzd1FhT245aFlnVXR5RXU0?=
 =?utf-8?B?cGYxRE1tOFJtNFJvVWx4cWllSkJEekNKSUdiTGIrMzhEQTN3VENpVmhjREpy?=
 =?utf-8?B?SjNrR1Zhd0dQWWhaeFh0RFNjbHVsaG9iTnI0M3JBcU9VN3pvY3hCeEZmdTVU?=
 =?utf-8?B?Q1lMUmFHNUgvSWYzZGVTNkdzaTFQcTNCQlEzbnpMRjFYYi9qSTFwUU90aE5Q?=
 =?utf-8?B?NmVBSmJtOEQ0ZVVzY1dOTW5HNWQvNXhQWXplTUYvckJ2Z1pnT2RhT2xxQ1kx?=
 =?utf-8?B?elRzNDlFSytBcW1BY0NlZlVKR2llYVh4aHZmZXZIVjBVM21uR2RnQWo2ZVFC?=
 =?utf-8?B?ZmkvR2c0WXBxbVFsNzF4WWdZZGZuR3JacitSb1pYUTgzSlhqWlJXZW1aQkY4?=
 =?utf-8?B?Qi9hRThpSlhLeWFYWERtdHFPeThOZ1B5akVpbWF2c1NVREltZ1B6bHYvenJx?=
 =?utf-8?B?eEc5cW5EZ1FoWmh1d0hud08xaVFqaFVVQXZUaFNveG14dXRna052am11Y0J1?=
 =?utf-8?B?eHVXcURzb1RHeXBMUTNidllJNitwRTcyeGRmb1VOSXRKcCtTRXlHZnY5dnVJ?=
 =?utf-8?B?Z2N4dTEyZGV0VzhTUGdtSXFteXRPWjZteWxsb0syNm56dlVSL1RjRVA2cHJt?=
 =?utf-8?B?WDc1USs4MlpPZ0Rvb3FlcXZZS1YxWnJqQ1Rybk5mUGllSDg1VHEvbG8yVUg4?=
 =?utf-8?B?L3FQdC90T1JxR2tWemM2VDNPamtJNnVmQTM5cnlrRWtrVFQ1WGh4cEtFUk4v?=
 =?utf-8?B?aHdxcCs2ZDdDa1d3NzdsMkpWeVRlajVLeTAwTE9XS1J5eFpUSkQzTFAvU1Z2?=
 =?utf-8?B?OUR3SWhoUm1wTjB0K0Jva3JNSzZ1YUIyNzR1RzZEM0FXRUJJalJPNEtWcERS?=
 =?utf-8?B?eTY0djBoMFNCNjdzS3lPK1o3RmpnNDJXUWRRRDhuZEphVGtzZCtiQnk1TkZ0?=
 =?utf-8?B?bkFJQ2tIcTNHdlE1RFZtcU1oKzhnZVQwRy9Ub2x2ajUrMzgzK1l5bFErSWJh?=
 =?utf-8?B?NlU4SDJPK1JPY2pxTUtydm5rWHdKWGlJS1BFRTdFWFY1SzZRV3Q2ZUk3bU5Y?=
 =?utf-8?B?Q2dueWdKMW5qZkpjOGVJS3lULzM5YTNCdm9LNEhiQ1Ezc2dHdjJVeVZya3hF?=
 =?utf-8?B?dnlWQlp6Ry9WTVlrcVR0YnFHWGJuMWZUNUkvWFFUMnJGMzlCVjBvc1J6bkpy?=
 =?utf-8?B?ZnlFYWlMK0VzcGc4VXRhMnp1OFZmaXFXT01GWXY0SGZKTHBnZXduZ2pocXVM?=
 =?utf-8?B?ekNSeVhQMGF3dGd2ZDZyQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cldYWFdpOHRJSWdmUi83WWFFNFJCdFBiSXNMM0JpQnFndXlBY3RzR0tzTFUv?=
 =?utf-8?B?KzNsQ3JwSnNkdDNBakhtbEdVeHhJVzR5d05qUy9BbFRVKzk0R2Q1MU1zME41?=
 =?utf-8?B?WnJtN3lrLytJc2hZa0h1bk5xdTNLSFgzcXZxa3EvNmNBNWdDSm5GNGtWZkk2?=
 =?utf-8?B?S2FqQStXUDdMMFlVOXErb05BMjUrUE4xVmlrVkt6eVUyVTlDTEIvaEZkNFlO?=
 =?utf-8?B?VEN3RmlJaENvUjN3a0RsR203ODB3YmFWRzlHN05PaTZYRW4xbERPSHQ1ZTZh?=
 =?utf-8?B?OHU0NWxwZ0xkLzlUYURFQWFoWWw0NS85N0VHM09NWldsOGFOUEZGQ2xMWWRu?=
 =?utf-8?B?Qm9nWUlydDhCVXZSOEc4dlNRUFNUbm8yRW1qb0dEbWFWOHlHRmpPb01NRTIz?=
 =?utf-8?B?Y01YeEwyLzFRRlZwVTlEUjBndFVKY1JWZGsxM0pHVzNaZUlDWkVNZGhtLytm?=
 =?utf-8?B?Qnd5REVvcEE2U0xKTTFaQXFqSWMySHdiTWtJODJkWkVNdHBuTWlaVHBrZ1VG?=
 =?utf-8?B?bWwyK1Y5S0k4c0NGVEtRZXZrQ1JSWVF4OCtPcXZaQWhHY2tmbUlkS2NvL0s2?=
 =?utf-8?B?ajNwNFpEUHpkMjhidVNMeisrZ1puU2toOHdIQ2ZaZFdtZGJ1V3NUMkdoM1lj?=
 =?utf-8?B?bXVDeFNGeENTbTFkVjBpbmZEN2N6Y216RE0wc1lGQkFqSFR1SURPbGZJODNv?=
 =?utf-8?B?dXFnaWwyTlQzcTRNd2pQVUxkMTZudGMvNW9JOEIzMEhqa2VxMG10aDh3ekhs?=
 =?utf-8?B?aThEeUpYQW1lSXNwNHRsWUZkMitUSnBjS0xqazhFTjU5ekZRb1YrSGpoQlIv?=
 =?utf-8?B?cWovNFdtaVVPMjdvTTJNeEsraG1xZnhzZGJTT1phV2cvNUthZDcyczQ1dmFJ?=
 =?utf-8?B?bmJYRnNnaklHc3VSOHVJaFZ4by95a0RsUEZjc3d6TFMzY3A0QWZZWXJyMUxH?=
 =?utf-8?B?Sm5CRjVRbWY4MjVXbFQ0QjZlZG1kanNhTUVLcWJNcmo5MXlkY0pmL3ZxMTlI?=
 =?utf-8?B?SzRLTGZ5NktaeFpOMFp0Wnp4QndPM09Xd0ZVbG1tWkxlWjRxOXhnMW9YelpN?=
 =?utf-8?B?ODRERzlaTkxwZ3NvS1lzWmo4WHI3dVFCWmJXbUlPQnhxTVNZa0lrR2UvS1FH?=
 =?utf-8?B?ZXI5YXBRdTdHbk9SRVdleWxacGFlNFZSSjBlZFhhU2pjL01KTlB2c2RpVnNZ?=
 =?utf-8?B?aUszbmlTekhEQzBSWUE3bHMzbHlzZmdkZXJ4ZEVxd0x0RkZyZzN4NzNOMXBZ?=
 =?utf-8?B?T3dlcHVBUXhHcWhIenNJT3VSNnVEeVljOEdpbmtQZ0dYSVJoMmt5T0N1R0ZR?=
 =?utf-8?B?SERMbXZCeExwWUlXSmtGTzdFQ1YwVFlHWGpxNjdNejRVd1RaV2NybWwyRGlG?=
 =?utf-8?B?amsvbzdSZEF4OGMwRHhHSGM1a1Q4eGtTaVl3ZldaYXBPSU8yYXJKbGNGMkts?=
 =?utf-8?B?b0N0YXl4eE1EVTltejJzOU5lZVd1WmZtcWVKejBFbW9paTNZd3VKcTVjL3Z5?=
 =?utf-8?B?czRSYmFFZ3dEbkJoRldodWJvdjVud2syWGxXRzFqL2dIY2xXelMwM3kxM0w5?=
 =?utf-8?B?OVFyU0hoVEg3dVB0dXhkK0l4Q1J6Z1F2bGpRQzcrMDc1SzNheXZrZVpHWW9j?=
 =?utf-8?B?UWVDN1ljZmhzS3RHVXJSS3ZHblZXWGhPSTVIeWtmUzRNbm9PZDRYVGlIWHVF?=
 =?utf-8?B?bGlZQWlNV09lK1dGZlRJKzZTMFlmTzJkYmtlQzhXL3I5VU4vYjJCaEY0Nlp6?=
 =?utf-8?B?NTBheVEvR09LaDhsTEpITU40cHFIcER5SzRjQkdqVVA4aStiVUw3YW9lMXRB?=
 =?utf-8?B?TG05K1dIMDNjM1U0ZzVOMXIxcjQ0ZmV5UXR4YUJVaE50MzlSb2JzNXAvUjJi?=
 =?utf-8?B?RVcxREQvNU9FYkNJb2hWYTRtTUhGSkRGcFJrL1B0eG4vSFgxTytmNngwaE5i?=
 =?utf-8?B?WTlGQjh3SFA5eVZ5WDdUZTg3eE9sMEZCYTRmeHVzZnhwRjNYWElHQTV6eVhL?=
 =?utf-8?B?S3Y0VzNCckJ4NW5uZnp4czFLOHpWa1ZMUENVdy9yTXBReUhNTFdEVGRRb1do?=
 =?utf-8?B?emd4RnJZVDZjVmVOODNLQzhLR2U3cmVNaFpYWWZ2RWZ6bXNwb0xSR3ozcmRT?=
 =?utf-8?B?SVZKZ2htNGo4cGxiZkcvblVGWTBjZm9NQ2d5Z0RrbmlHcUovKzk0Rzd4TW8y?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c107dcc-427f-4388-094f-08dcb162944b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:13:33.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FG3bxcvSNYts7DDECGxOxwIBTZYLJBYulxTcSpC06MdI8cAU/A3D7lFkdhkV19FQuP3hHdQae/Dfe2HNI7xcZoC2ElOS4on12Z/TpUND/SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
X-OriginatorOrg: intel.com



On 30.07.2024 15:58, Petr Machata wrote:
> Ido Schimmel says:
> 
> Clean up various issues which I noticed while addressing feedback on a
> different patchset.

For the whole series:
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> 
> Ido Schimmel (10):
>   mlxsw: core_thermal: Call thermal_zone_device_unregister()
>     unconditionally
>   mlxsw: core_thermal: Remove unnecessary check
>   mlxsw: core_thermal: Remove another unnecessary check
>   mlxsw: core_thermal: Fold two loops into one
>   mlxsw: core_thermal: Remove unused arguments
>   mlxsw: core_thermal: Make mlxsw_thermal_module_{init, fini} symmetric
>   mlxsw: core_thermal: Simplify rollback
>   mlxsw: core_thermal: Remove unnecessary checks
>   mlxsw: core_thermal: Remove unnecessary assignments
>   mlxsw: core_thermal: Fix -Wformat-truncation warning
> 
>  .../ethernet/mellanox/mlxsw/core_thermal.c    | 43 ++++++-------------
>  1 file changed, 12 insertions(+), 31 deletions(-)
> 

