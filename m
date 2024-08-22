Return-Path: <netdev+bounces-121113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1EC95BBC4
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 18:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0E5B22A77
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4781CB31B;
	Thu, 22 Aug 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLv2s/2e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F023E282FC;
	Thu, 22 Aug 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343578; cv=fail; b=iRNw0E43B00WJWBkhAEmYa2gLWPH0ALELdp6N/3TiPi7x6mc0Z6quWus6b5F7iadLM8uNQ2sQfA5nNjgH0qr9sS/tvIxWpmz817TdnztdsunjY7ajOOETx72t1hktZFIyDl8v9D1bSlrjpEMBugOtUWpQVaigdEPfT68iVYZrao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343578; c=relaxed/simple;
	bh=nZMO+ki84N1HcZNs6yUe7A2fsT4ztcOZLO8P/2ZAq3A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VZQ7PgfrIRNfaOHmDYnc3rPIZOrWU62DlQhiTwaJUSzDXJWZVW9Xcw/BggqOLjcqp/Lp9EmcTYeQRRFC9msIfK5J6QHsJ4qTZ2S77i5nT3nsL8XtQ47zvkkXstcxF2DllYG4JFg6xVsdz1b6CA56KmcXb1+eao+hV+wrtdsTuSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLv2s/2e; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724343576; x=1755879576;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nZMO+ki84N1HcZNs6yUe7A2fsT4ztcOZLO8P/2ZAq3A=;
  b=DLv2s/2eOhrOhKw4zRIqzjZ9pjNP7Wh+7cLQtLtwxN5mM1cMzvZFq7mF
   Bhpr06twMQ6nxuKZPkVznhv1XYU1bzblH0Y2kDiCBieRjv19S7CvMMG9d
   bLe4qtOaQlM/f7klYkN9VO2mi7YuP6Yi0SMm/DVauPcxmw+vCyZ5XSRQa
   69jKFF9Qw6G/fsThujfIJEugt/0arw8Yv4ALw5oIfXNEBaVDYSFMfOwvf
   +gbkVX6vnuuZDIQ6Z27+gTY9wcnVq/xV9THX2GMWhCuIRgXht0hOAr1qX
   AMrOMc+6GUzpyDagREUzWAvlmLsliohnJ+hVZtz2eH+mA6VA03EJX7Z/A
   g==;
X-CSE-ConnectionGUID: ftx9MIVlRY6tTULBNTEB5w==
X-CSE-MsgGUID: Giuwsm1+QkeP6cRR2UWAxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40238272"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="40238272"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 09:19:36 -0700
X-CSE-ConnectionGUID: 8fS9gj1HSoW70AsdSi5T6w==
X-CSE-MsgGUID: 3jba2lI/R1CT2MfshaYQgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66426590"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 09:19:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 09:19:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 09:19:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 09:19:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 09:19:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EneqjJHdTDrcoTWuDuLmwpM/s5GyCggc2KIv+Yntpu5xYoPbA5wQ8/taYvIcvVkjhraX1eDuhxfwRudREfONJyfFMeiQ99KeE7xTtlxYYS0F0OXrme7HvoV9XYgFzIoNeJ479LrCn9yFV4XtymlRLuSkVP1fg1AOGCNoxz1cx87Y3HswueHaOIwFAp+KfBR0tzgnuZ+BENxXgS1NNC8YxdCspXiqousuNgbeLn5Azc14ML99m7dsCSBBCvTo0/DCuARzdue1HupceDnxLNv5m7Ifpp8Zd5RtchFvz3AvkJFUBGpnbw7tbgTWFj8eVAlKZ3yGLNhyRTKT0j6GH8V68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2gkTTfSU0azAn4M6JWK0G5gjmkPuhC6s1vG24TGi+k=;
 b=RNZPZ5pc8H9ulvVAApW0MFJZzWqGbcN4XEwb/hkxALXK+7gcfM0ZY+KKpIC6puyTjRwVDI8ym+pZs1GQRuM7mQd5fAnYelXfoH7mt5FetQ0jhb6KDM55NUtUwI8MCZGwa3sKm1Sus7t4zs120ILxSaznmxjmxxVqZLdgcJrd7liCEYQ9ok7kQYn/VPQqGGipDMdNAiQfSMyN19P010k/982ZSTYh8pl6tPRtU8zKyhYtLysLlPKNw1f9M+Yj/FPvj6WtbUVFsUGWudykW7ILywfleeV5YTid5RJBafH/N8SvRK95sYk2q3t4CbKWBGj4/tLP3S97BtuUHlOfE26qNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 16:19:30 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 16:19:30 +0000
Message-ID: <d080d3a6-3fdd-4edc-ae66-a576243ab3f0@intel.com>
Date: Thu, 22 Aug 2024 18:19:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/6] netdev_features: remove unused
 __UNUSED_NETIF_F_1
To: Eric Dumazet <edumazet@google.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
 <20240821150700.1760518-3-aleksander.lobakin@intel.com>
 <CANn89iL+VTJ6tEe-PZ24h+0U9BYs0t4gZDndiy7j1DwuKMBEFg@mail.gmail.com>
 <fc659137-c6f0-42bf-8af3-56f4f0deae1b@intel.com>
 <CANn89i+qJa8FSwdxkK76NSz2Wi4OxP56edFmJ14Zok8BpYQFjQ@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89i+qJa8FSwdxkK76NSz2Wi4OxP56edFmJ14Zok8BpYQFjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0173.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf19069-9d19-48ed-608d-08dcc2c63385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Njc3bUdhMnRIbmVDSU9wTUR2UEFidGJvUmcrSnE5Rk9tcDVwSlIzengyOUpJ?=
 =?utf-8?B?eFI0dDhNL0g0OXRoTk1TcXNKWjhac1g1dmF3VUE1S01sQlBZeTZka2Z5bWll?=
 =?utf-8?B?MDdURktEaEE5Y1B0a2pneTBNTmRkcC9wTGhwOEpuNE5WMWVQVFlEWXM4RTZl?=
 =?utf-8?B?R0VNVU94YmlENlBWSEFYTENuVXZCVG0zWWVGZDlySFFTUXdySzg2MENVU0ZB?=
 =?utf-8?B?UHc2Z2RjTkI1TkpZdithZ2ttUjE0b3QvK250WUkzMVFUQTJXRnRBYUwyN0h1?=
 =?utf-8?B?TnZ1Q1FGRE1wcjhTSkVZc0JIbHV6c3RodUh2REppOEpERXBIamxnREhML1Y5?=
 =?utf-8?B?VTZCQmhwc0d6eFo4YUQ3WCsvVzd2bThZdU5kVzdqeFMzSUJ6WXRoZVF3YW5m?=
 =?utf-8?B?QTRlcXhxdFJuTGFhTndmYWVDUW1rUytPNFMwSEsyWjcrWWZ1TSt4OXBUdmRW?=
 =?utf-8?B?TXNZY29aMFhERkVSQ2NSdnVFYU15aUNIT0E1WU9RSzJQUDZ2YnVwRnBKMHpp?=
 =?utf-8?B?UUNOUGVzRE40eW9GYXBvWE9uSWpBNGd5YTJzZUZTV1ZidmNsSTN4WnFCUWpC?=
 =?utf-8?B?YVZ4UW9ScWtzdFFKQXlTSjlVcWUzQ2JwaFR6M1NPY3QwZUU1N0h1aUJJbXBr?=
 =?utf-8?B?czFQNXZ4aVN4REt2WVBCUTBsSFphVnZLKzJMMUFwMys3ZkgvTWU1MkFVY1hk?=
 =?utf-8?B?bzhTaENOVWNxZ0FGVUhpdnFKRERBMHUxYTBqZTRJU1FzWjU1T0FKeklYU29Q?=
 =?utf-8?B?d21wTitSTXRTS3RqeVpHeTIySS9DbjZmUWlVcTJuWGNzYUp6ZXUxYjVORG05?=
 =?utf-8?B?QTZCS0kyM2FqMWFETGZmMEFYZ3ovdFRXWmZ2TW92YTl2ZzNSVDB6ZlkwMEZX?=
 =?utf-8?B?YVFTUHgrRkw5WWRXZ09pTDk4MmtXa2VpUnVYT0lqcjh1MWJPMG9kV1A1bHNZ?=
 =?utf-8?B?azIySEtXUkoxbEh6SzBDNzlRdG9EOVVZS05icDc5OHlyR015eXJZYWlually?=
 =?utf-8?B?UEl0NkkxdksyMzVkcHhkRFNaTHVZZWpNWmpyY2kwZGpTTFNzMW1JVHlZR29M?=
 =?utf-8?B?U05VMG5zaDNXWDRiUDMwT29xRGwyVElGc2ZLcS9jcU5DenRHZmh4RXp2eVNX?=
 =?utf-8?B?akh4NGlid3RPV3JUQmRPVE9WNStwVmgranZyZlUxd1BFNFJOeitYOEhaUTRh?=
 =?utf-8?B?UlZvZzZpN3h5dDJjSUZ3MHJzYitBWUUxRDF3ZXdTcjhEd2hLMmhvaXdMZ2pZ?=
 =?utf-8?B?bFRQcTRIbkpWd0NlLzlLWDByY3BXcUNxOTRTVlZIU3FBNmZUR2tLVTFmNS93?=
 =?utf-8?B?NE9BUjZoRlVVNmtoODFycytOS0VsNnU4OXUrbmtZSDFkdUJBOEpja0JpQTgr?=
 =?utf-8?B?Q09BNFR6ckFRNHdwMHArWFQ4NHZrSnFrclhZZnF0TVVuYnVkZXFoRzJqVkpm?=
 =?utf-8?B?bHVXZkt0ei9NbnBYSlFxamlyeHJDWFBsRU00NEpZUDF5UlRQYmVlZ0IrZmp6?=
 =?utf-8?B?RDRtaGdDdzdLOFNHTWxlT0lGYnZtTThKai90RjY0V3haMDhiOTB0NkxzWmE3?=
 =?utf-8?B?djZzVnNwRGtHcGx4UHJFRE9NRlBpamtoVndYOFM1QWppVlRoUWhtQ3NxT1Qz?=
 =?utf-8?B?VXBVR1hoZlJqazdqVUl2azVlSkNIa1FWU1prLzUxVDBEUmMrM2ZjbkpWU3BN?=
 =?utf-8?B?aFFlYTRRU2QwZk9vRE9SK3YzNGVRRXl0Y21ON2xQSVltVXFma1UyemN3a0ZU?=
 =?utf-8?B?bllHRjMxV2gxdU85cTN2OWRCQUdKTzlYNk00S0tPZHUwZVlpSS9MMlJSZEVU?=
 =?utf-8?B?UDlkUklMNDNxQ05uQ0grQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1M1d0JjTHJTN3ZJdXFCQTFsZ2hHV0JiU3g0SklzSHQzdUpaSHduSlE5NmRO?=
 =?utf-8?B?UGNCOWxyV29BWG5KZ2JVOHlINzVVclhwOFdtUmlGYnNJc3cramlGZExpVzQx?=
 =?utf-8?B?QkxLY3k5ckF1WFIwYlBkaTNaNWJaeGpBTWVOZzlEdm5EeVNJM0lkSlBaNnlM?=
 =?utf-8?B?VCtoYWZOSDkwWXU3eGtLMG5WY0Vvd2RyT2ZRcmtDUlBXeStUZmV4MTcrVEdD?=
 =?utf-8?B?bjhWbXZ3Q0M2V3pZQk82U05LSmNPTXZzQkYydUhqcmk5SDNQcEFrQmtIUTdo?=
 =?utf-8?B?NWp2WSs3WllZRUx3eXRpTkpGZ2JOOFd2cFRhUURoWWlZSG5KTDlnVmFqWUdZ?=
 =?utf-8?B?Z1dXMmhlUTBQc3JkNm94QXVXVHgxNlh0S0JBQktlMkFTVis2eVpNOWh6ZnJC?=
 =?utf-8?B?K0VhNW9JK3hWZmZRbTBEZ0VSSi9JbXlLWmFra0puRUV0RXBXVFdkTVRxR3Fz?=
 =?utf-8?B?UGU5ckNKRlQ4MEZoMEZTOFRsU0tHZEllWmgzL2E3TVo0aTNCK3h0ZnVuWmZ0?=
 =?utf-8?B?MnFaelcvZ1QvOUlEZkRuRlFMMVRJTmYzdjFwYlR3dmtuSjB0WjVYb1R5WlEv?=
 =?utf-8?B?d1pxOWlHVGlKNXlXQno1bXpTYW5yWTN3dVZ5cTlITnVGa3JjVEJRSEhDT3pJ?=
 =?utf-8?B?MmFTYzZ3NmpPTG4vcklOZUppaTJzbEZCeDQvazBObjUxRldiNTJQWW1pZjdI?=
 =?utf-8?B?K3BDVjN1bHJIQ3JHVDFBRjlCUDl2VU83ZDZrTzl5K2NRc0pMazcxRi9ZdG5v?=
 =?utf-8?B?UktsVzY2blZLMEU3dkFhWkZ6TWJHQWtOdU1CbGlmTUZNS0dsaTBsOVY2VjN1?=
 =?utf-8?B?TmkveGdySXJVSHZPT1RGZXRFcmRVaWtxRU1ZWUNWVCtDMkM1NUNHMU95VFRZ?=
 =?utf-8?B?VnFDbEVMdFppTmpTRzYyR1FqOW90N0Q4cU1IOVZQNkZLampoV2YxSWRQcDBX?=
 =?utf-8?B?T29haGVHTFhYd2RVN3oyRW1HZ2R5amY4NFdqNkR2eEVvTGU4Q203cTdzTnN6?=
 =?utf-8?B?TlJpdTdIcjJaQ0RpY05YOWFoUXI0ZDNNeEEzbkxlUENScE1EaHBLcjExQjJF?=
 =?utf-8?B?SEFYWGlPUGdicFBWY2N5Qk1vRndWc0JSS0RmMmxON0JvTEEvN1lWeGZiTzdk?=
 =?utf-8?B?cXVIWmxyVDd2QUNjbTI1QlNmUTFPUzg2SVNyNHl6ZUFpMHVyQlZIbEd0bWdt?=
 =?utf-8?B?NDB4amwwUUhmaFM5ekdpMXZJZWR3UHcvWWJpckZRTjZQVTBJWE93SThhYUx1?=
 =?utf-8?B?ZnM5RUFIdTdDWXN4RjU2QjRtM2haYTk4bDVubXFsUU1pUU43dkl0VkNQUGNp?=
 =?utf-8?B?a1lzbEVRY3JGVzJCUFFHNlNKUVVVY3BFemJHQUQ3Q0FIbUR2MVZkV1NNWExv?=
 =?utf-8?B?R1NlM20zY3hXOTgvL1QrOEZCdFcrTnBZQnFJUVdxZ2FXcnRpc2lTR0hJSXdz?=
 =?utf-8?B?YnF2Rko3U0s3TWthZ2wvV0xaN2lMZWRkUVFOekN1VWw2MnZ4Sm9FZmlOUzFV?=
 =?utf-8?B?YjBFZytJQmFoRUdqTk5jbmdpbS9lL0dWank1OXpXTndCS1JCU3JCeDh4VCt5?=
 =?utf-8?B?d00xdFQ3NWFzNmxVMXVqWnh6K0cyYlNvUldsQ2dqYTdESVlKazZWZnJieW80?=
 =?utf-8?B?cDNZZUJ3VW9EN3JEcDQwdlJoUjJiVUtKYllIbXBPaFdkVlZGeHBnaFNQODgz?=
 =?utf-8?B?UW1ZdCtUcmF5NmIzRkxHb0tLbTJMSlQyNE51Sll4TFY0b3dZQ3pscy9pQ3Vo?=
 =?utf-8?B?ZUFJY1N2emlCcVIvdFVkRmpMTXJpenlhUjlPYWdVQ3dZS01DVHdxQ2hqTzVr?=
 =?utf-8?B?bDhhMUlYQ2JFVnhJT3dLMFBtRmFKSXBNYnhjSXBYTFVpa24xTTV1WWZ0ZkFs?=
 =?utf-8?B?NUpqYUdVdldnUmtPTWlKalRjUUM2MGNadUgxRzZGWVhGOFFRVXBUWXBVMXVF?=
 =?utf-8?B?enFNREFQcjRaOVB2QVYwK2YvZ2JKem9MOUg5TU0yMWNMZHRndmgyQTdSbTJ2?=
 =?utf-8?B?b3VONWtpSXV6WXB3Ly8reUJBd2JHU2NlSnlWOENWdjBnMmFzUTRHSmkvQzZY?=
 =?utf-8?B?YW9JaGNvYnB6NWp6MjdOc1NlOVJWQWZrTFh5Y3NJejNod2ZjWGttNHVyMWNy?=
 =?utf-8?B?L3VLaHkvK2dVR29WVkdTaWU2VU1GSTBCY2c5RTkvc1BsNkxFcWxIU3VSRmtt?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf19069-9d19-48ed-608d-08dcc2c63385
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 16:19:30.4605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugiS9Eom4w+V1hINlA55Kbbu2go9bPT8VpRJrpChQ34e9ziARaWnVl9H/Lk5NKg2efmdefwiliHdRHc3cJ+9OpELcT3pHGDmqD3/T0FD9+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8380
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Aug 2024 18:12:18 +0200

> On Thu, Aug 22, 2024 at 5:24 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Eric Dumazet <edumazet@google.com>
>> Date: Wed, 21 Aug 2024 17:43:16 +0200
>>
>>> On Wed, Aug 21, 2024 at 5:07 PM Alexander Lobakin
>>> <aleksander.lobakin@intel.com> wrote:
>>>>
>>>> NETIF_F_NO_CSUM was removed in 3.2-rc2 by commit 34324dc2bf27
>>>> ("net: remove NETIF_F_NO_CSUM feature bit") and became
>>>> __UNUSED_NETIF_F_1. It's not used anywhere in the code.
>>>> Remove this bit waste.
>>>>
>>>> It wasn't needed to rename the flag instead of removing it as
>>>> netdev features are not uAPI/ABI. Ethtool passes their names
>>>> and values separately with no fixed positions and the userspace
>>>> Ethtool code doesn't have any hardcoded feature names/bits, so
>>>> that new Ethtool will work on older kernels and vice versa.
>>>
>>> This is only true for recent enough ethtool (>= 3.4)
>>>
>>> You might refine the changelog to not claim this "was not needed".
>>>
>>> Back in 2011 (and linux-2.6.39) , this was needed for sure.
>>>
>>> I am not sure we have a documented requirement about ethtool versions.
>>
>> But how then Ethtool < 3.4 works with the latest kernels? I believe we
>> already moved some bits and/or removed some features or it's not true?
>>
> 
> Presumably most of the 'old and useful' bits are at the same location,
> or ethtool has been updated by distros.
> 
>> I could try building it, not sure it would build though. How do you
>> think then we should approach this? Maybe document the requirement?
>> I don't think we should leave the features as they are and sit with no
>> bits available only to support ancient Ethtool versions.
> 
> I was simply suggesting to correct the changelog, and make clear we
> need a recent enough ethtool.

Yeah I got it, thanks. Will reword.

> 
> We can not simply say that ethtool always supported the modern way
> (ETH_SS_FEATURES)

I didn't work with Linux at all back in 2011, so I didn't even know
there were older ways of handling this :D Always something to learn, nice.

Thanks,
Olek

