Return-Path: <netdev+bounces-109361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D0A928231
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 08:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F501C21708
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 06:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190BB13C3F9;
	Fri,  5 Jul 2024 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S20Cmxoy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1645D67A0D;
	Fri,  5 Jul 2024 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720161647; cv=fail; b=LhLgf/Z1Hbme4EkYdvadQoRNfsnpomEDQHa6Ub7NM+iI1xYWdT56HE354WPrTRki7pFU9vJswuyRLANcjqDXyN+D8JnEVS+DebKfI7A2qcoS/ZFW+DRKG2gSyiihv0msvP/zWVsUUQcjTUWRwEhE/a1L2ypHysnEz8ZJLgdb+VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720161647; c=relaxed/simple;
	bh=fduouayZ597Mvg4c9J4mRwG/kXthJp8+ZXyJwZvfAbU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kXElQQXWtIoXEiBpnAKz0cBVblNeh6/oe2hrKm9APymaLm3DjI+6aPT8ikHWAphks+CcLkAyV6GQ9SG+Xyh8oF+yxFGWwPSFh78IbB2A8aeb6NRZZePyOEu9JONZyKX2XvygPKKNiII7RtKWq31Wpcu4UQKJKN8bx4UYaeoLyig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S20Cmxoy; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720161645; x=1751697645;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fduouayZ597Mvg4c9J4mRwG/kXthJp8+ZXyJwZvfAbU=;
  b=S20CmxoyQUlOAXo4CXa/p4RiIeU85XyvhauCW2oZbtVsmKUUKjDGR92j
   T5bc/bRa7tRsyVqaOlgMnwqedl0ujbeJXCcc5jf9v2mYCOw1cOaW5gAu8
   2wldru4WvsrUAdjGW5tSoMH7rQ4HJBrqyAhhD787Br+6ETmGYL/+IjK0k
   Gq3AYUAyZnnIMyo5WiSXJVntiLprUQZQuMbXZvvE8bl8F9yfW+qk7nryn
   M9ITBL2dMr269dDRLRVc5jfAw6RB5hZvgrEGEWjPp7JghdR8VjqzGOBW1
   +ebG2SZ9UrD3ZRIfYEEcONbvyZl+ELkTiYbvwSnPE9rkEtpHW7FUaE8S5
   Q==;
X-CSE-ConnectionGUID: /SRxWB4eSa+00YDC+V35lw==
X-CSE-MsgGUID: jE6oz7eOTi2r5A2VLegeMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="34985146"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="34985146"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 23:40:44 -0700
X-CSE-ConnectionGUID: UMvomVJTQRiEHm0Uz5Palw==
X-CSE-MsgGUID: TBF3+/eGQje3fEwyj/aWjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="46902614"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 23:40:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 23:40:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 23:40:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 23:40:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 23:40:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWfYhViUC2JXAeDU5L9jYQ5PFiGKanfb+6F1kL0m2wNQ6WNp0spkSKs80VZOghdA8WmQ3pV5wHeR8lFHMop7QG50dzZqL6M4jqgGt6pzbWpiC7Lgqjzg0oXNyNdIuPBqq/a7OitXU5nvwkUzhefLsDNRL4mROKsTIDyt/Qmvv/PV4v2cakNpTFToxQKRamD5kxSwdEG7hULY6Y/6bcKnQFwaFSvfI6R/tB+X89Q7jHPMJuu1ciabyHdU6X9l62AQyzqUpHDexSCRKZnv+eDjc2Rngppt+mEdze8+oQOA9zaQiQHeWwe3GbMqAb0kz5SMu7abe81dv3kZB0R1JloyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrlGu+1G58gb9MxitZd3OGchYalGm9Q8YmVEDI0hHgE=;
 b=D6OUCtT4NESgoVYdCzD2H1AOTL8iqeikz7m5uqO8TLM3HafMWQ3Z1m6VD1egRc1L0PlYA0xzZgcUnGT9THQ6/FYdjPMiZUU/YLGPNvfinpb0KAreqLtUkkjJX+5Wcmjsru/wWv7rNiGb0Dh7tl8bxE+RUPKLZDTfK9JVbjtvpdbA1QxHsAMnzcXwsD5xUmphJIOx1Gi30+/shBnuWshvqK2khPI6Z4isEctvUHxSSGcOY+b9Ax+xjS56lqDi4jecrmq4E1pGEnyRdwZa2EecUmnuuqGhCiZLhIlVIMzLEZFzECu9HX3r/jAKzk3P6BoaX62pZzmGgZkfXECJeOlkLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 06:40:34 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 06:40:34 +0000
Message-ID: <bffbfd82-5949-4796-ba54-b679f608e346@intel.com>
Date: Fri, 5 Jul 2024 08:40:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: networking: devlink: capitalise length value
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, <corbet@lwn.net>
CC: <linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240705041935.2874003-1-chris.packham@alliedtelesis.co.nz>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240705041935.2874003-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: c7619b79-97f9-413a-4ffa-08dc9cbd5f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkE4VzloTDBSU0g5V2dvVnNBTXhhVHI2ZGtPc05DUUVGMXcwNVpsOVk4TTYr?=
 =?utf-8?B?WHhTemFLRHl3OHpLcXhXVnRMSDgyM004UWk0TU9XR0xDMlVsSWp2aWFCMnBm?=
 =?utf-8?B?ekg5SzNaT1J2emk0bHkrSTI2Wlc0TlZOb0RlNDRnV1Rxc1pMZGd4a1BiOEty?=
 =?utf-8?B?L1NLY04zTnVxSDcvL1daSWpwV0pNR2FTL2NIYU9LbWhKeitCRW9QVW1kRHg3?=
 =?utf-8?B?amIwYStBem1rbkpFZlI2MWhPQU80aU9EWkVpOXZPQm40ZDU5NWhMZ0RtV0JU?=
 =?utf-8?B?Y0E4ZEN1aEJtL0RmeEtRZXFMQzJqVjdhQWcxYVMzRTJXakRJNkFKMnI5SGRr?=
 =?utf-8?B?a0I3ZElDMndrdENNQ2pOZG5Ba3ZaOUprVHcydFpDTnpNcFhRNmRwYjVob3pa?=
 =?utf-8?B?cW1sQnRqY0ZhcTdMQkM4QmRWc1ZjRTlxazdkUzFKbm5WZEI2Y1h0SDZ6T3F6?=
 =?utf-8?B?TnBUMGZ5WEIxMzJLcGVodVB1Q1dTWnErWGdmRFJKckRzMmRLdml2NHZwZUFZ?=
 =?utf-8?B?VHZaMExXVEZLTUowZ253aHpXSXhaZ3graFlWS2tya1VjenFUSEl4MldjQmlZ?=
 =?utf-8?B?UVpuK3RucDVNWnp3SE9FakE1M3pMY09QSFpUUEZSTDd5NWEvYWZYWnJSbloy?=
 =?utf-8?B?cDlLN0QxMUVmb3BZd2VzUDhYNTFiTU80YlpOekM4V0xCbVFjWlpVRm41dGJE?=
 =?utf-8?B?ZjBIK2QxOVNKNFJCbmFGMkQxUjIwWGFqMnN0Y1lVc2NQdng4S0NuYnRMd2RR?=
 =?utf-8?B?akc5YVBqdHhvVDBOVEhOdnp6QXpqcmk0NHZMMks5NzAxR0s0aktIZGFONVhD?=
 =?utf-8?B?ekptbEo2VFBCTWxkSWlEN1VobUJlMFRtZDVwdDBLZjdWUzhVVWdiWlcvdnRr?=
 =?utf-8?B?OTl1c2ZGQTZhamNSYlFTTFZmQVNSSFlSODVzVUFrc0ZLaEJZeDB5ZGsrcFhD?=
 =?utf-8?B?RXlYYXF1SkpLaVFvVkM0dCs5R3Z4Sm9mWDFQRGZRTUNSbXFwU0N0WlI3SkQ0?=
 =?utf-8?B?dnlWWld4WVV4WHNrK3B6QTJrRVhWOU9zUzlnQlR4QThEREdneEkwN0YwYlda?=
 =?utf-8?B?Qjc3aFRhaU4vQS9MbG9Tajc0ZWtoMlA4L1hyaHRsV0x3cllNUytZTjd1WnZM?=
 =?utf-8?B?V0R4SWpTRHVPbFF4ZDFKalpZRmZESHNhanhHa0xJNWxOTktpMlZKaksyaCt5?=
 =?utf-8?B?cjNjYkJ3RjJaajg0cy9UUkcvU2lGLzJYMktJNmV6VVVhOTVXbUwrUmJOTFJC?=
 =?utf-8?B?WkFWUjAxMXRYYlJEbTdCYzFyTGJJcTV0UkdqbnZBblJxZ3lVM2VaaVg3R2xT?=
 =?utf-8?B?MDlMamJDKzdxR2w3VFRwUUZublhMVU16bWUyVUI5OHdGOEFzWUU0aFk3M1hG?=
 =?utf-8?B?b3VDSU1GYWlUUjB3Vm9tR1k2YzZGSHZTajEwbDA4eWRWNVZrYjRReXBuTlNu?=
 =?utf-8?B?ZXhGUHIvKzZrWmxScnhzUFh0bG5LV2pzM0ZHQ0YvbkQ1Vmo2RDNkS21BR1Iv?=
 =?utf-8?B?bmYycVFjWVd2d2J4U1JZMVdzazNZblN4eVVIZHh0b0lFSzJSdDZyOWpYR3o4?=
 =?utf-8?B?Y2NBejdTQllaWjRJQWM3OFRmbmFUdkdmVzh3WmtsYnRQOGU3VDhTSzFrdmdT?=
 =?utf-8?B?VVVVNlZjVHNVNHhPU25udWVtUDI3Z2ZVVlprajdEWWJiTnFRcjU3Vlo0Vnhr?=
 =?utf-8?B?RmozbHdwSlZlcWpGT1hWbUFTMm5FSVVpTU9jbFB2ajNORVcrU3BVSlpvam9p?=
 =?utf-8?B?SnZsRFlHMXFkTEppdHV4d0JhRWo3QlVyb2YvZHU0V0t0Zjl6Yy9NQ2ZNazAy?=
 =?utf-8?B?U200ZzlRcENaUWUzSFJ0Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3d3Ri9YMzhOcld4ZitURWEvOGpnaEw0VDl5UDBwa2wxUzFDaks4bDNxK2JE?=
 =?utf-8?B?a1k3K3hneVd6Y0EzUDlLb1FpUGZLT0dqQXc3ZHpBRHhvS3BwUFVmUmFKVVhW?=
 =?utf-8?B?MDJNR21DUjVORVFZblVMMklwUXpDdnhiQk5pTEoxdE03eENFRUlUaUg1UXpw?=
 =?utf-8?B?TUxKOTRNR1d3M1gwdFQ2TVBtWWNPMDg3Zk10TERDa1JYZ1hLMWloeHhhUkJm?=
 =?utf-8?B?dVZZNFRXUVFnK2tjR2NCc2hVY3NLK0d3Mkt3MTdyM2RtRnlSVWdvUWZocnJh?=
 =?utf-8?B?SFRmMkJwWnZoK3NHL0N3eWhCY1pWVXp1aVlLeVFENVlGbmQvYmQzR2tZS3RR?=
 =?utf-8?B?MDFJN0dvQXBlMmlpMi8vWDIyT1RISTQwM3lwdlNqV21QRWhiVzc2eURxUWxx?=
 =?utf-8?B?eWp6SDN6bVhFaUJUVnV6QVcxdkh0L0lmNCtIVjVxbGZOMEdyL1diL0s5dDZ1?=
 =?utf-8?B?eWJyQWhlOENaaWtkWmZ4VmEvQWJrRWZMdkVxK25oaVRHa0l4UWJ6U1U2cTZ1?=
 =?utf-8?B?YnJTUWJMQVdqVnhMTFg3T3pnZk1IUGZsNnp5S1BNRlQyRGJKWFBLdkkrU2l5?=
 =?utf-8?B?ZXJGTEZ5T1l3dVJWQS91ZkxJYk9nUWJSL2JuUFRkbUpweWtsaE9QdVY0NmQ1?=
 =?utf-8?B?VWlyT0Z5V1ZQc0Zpc3dXQ3dJVHJuUzNvWkxaSXkrRVE2MlN2T3ZNVE5WdHYz?=
 =?utf-8?B?ZHMyemZwajZVZUx4VldsM2NLLy9WR1BIOTdrSlM3TlpObk5Fb0ZGeHRDTXlp?=
 =?utf-8?B?bytuWmZsK08zVWhwZFhKNitJRkRRYmNOdzdUT1VpNjFLalhPeXlia3lhVFFV?=
 =?utf-8?B?QWVUWWFnT2Nmc1paakZMbEZUVmdBUWFnTzlOMXdpUUNrc2RydjkxNVI2N3Ja?=
 =?utf-8?B?ZDVnaDNZaEM4YTNhU2U2YTc0QXBxRDh0U05rNGJiMjhjeVlVUEFJbU5pSWxW?=
 =?utf-8?B?R2s4N01XSTlNVmQvalVrb20rWk10RFBISnovdW9LdUZURVJNM3p6eTJsY0RI?=
 =?utf-8?B?NWhkeUsrTG00dFA4R1RFTk5wV0RKY0hPYlFNVW1FVEpaeW4xV2JHNDc4RWor?=
 =?utf-8?B?Yi9tSmlIVVZJRWJCcFBraVQzQmp4bzduQ1pYRVRoaVM5aFFzeG1rd1FUNVdP?=
 =?utf-8?B?bm93VUJaeG11MGNDcmx5ZzhBUGtMOUNWSHZkaFFzUEVxZ0F2VWpLQWlTdVRE?=
 =?utf-8?B?bzQraTZyM0NOUjh6U3lSQmNCRGtnKzg1OUdmWjhVazVzeVQveDVBVGFMUFJF?=
 =?utf-8?B?MkowNGZtZDhBVUVoTTlXOUEvbE5VNzVBcjA5TThFZCtYVldBa3JJK05IOHIx?=
 =?utf-8?B?bjlkejFJc3d4NHJYcUZhWG1PUlM3dVp3UFNVSllKbUNMdDh1Wmg5TldjVWVC?=
 =?utf-8?B?ZEljZ3haSFRoYmo5UDh0d2pDZnVXMVVjSzdVcFREZktQdkVwaXBBWWM5LzlV?=
 =?utf-8?B?VWFXM3pQYnloVEZLYVlkZ2YrL09UV1dud2NBUXlnRkZKZnZYcVhFRmI5eDdo?=
 =?utf-8?B?U1BHdDFlWkZ3NFZaZmpFKzVJWHZrTzJzVExDTGxFSzZtZFhKM2ZuTEVkaGQ2?=
 =?utf-8?B?SGIwUnN3OUc0S2ZMY2U4Vnk3bUJZM25qUUVodXhNSmJPdzI1THA5S1pISHRK?=
 =?utf-8?B?VTlMSTBQcSt2TDRRdUtvSEtzVFVBdHNpMjFhWXkyUk9ndzdzMTFIY1FHck1p?=
 =?utf-8?B?VHU3SGRqSjRNV3BaaDVZU1VWQTA4Mk96UUZHVUF4UStuZ3F3RDhyZ0ltNXgx?=
 =?utf-8?B?aXJ0S1VLT0NRZmpSdm1FbzlFZVBNQjZMSmcveTRYbGlLV2hrcm0wWDdPUlVX?=
 =?utf-8?B?VHdPdjdYSUxnTkgrTFIycVZtNUhTdDlaYXBJL2cwY1hNTHRucjhOTytoTzhl?=
 =?utf-8?B?Tzd4eTJTUjVRVGU0TDhwNGkzK1NIc0VZaUkwUFBwUTBOaGluZW40ZnVNYmVz?=
 =?utf-8?B?S2lBdGF4dWY0U29zWlFBMytIT0JjWjN0ZmJ4elR4UlJLSUdPTmdJMzVMUi9S?=
 =?utf-8?B?WVk3SWt4anZDUi9hV3lOMGxpaEVQSEpkaHZDV0xFcW04VFFmS2pQcmlwcFlU?=
 =?utf-8?B?blMyWmlPdVBEVmVCeStFTlRiSmgxck9FcVNkSWpSK2xvSTh1L2IzMWUxSU1v?=
 =?utf-8?B?WEFTZlgyY3pWV0dFa2NmMGhKYTl0WnB0eGtiV25QZ1poZ1c4SEhHZDJzRUZC?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7619b79-97f9-413a-4ffa-08dc9cbd5f97
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 06:40:34.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8XePaMKMooWTBp1lDU/Cc5VRFAgPqGFNSN1/PHjL1HCW0fmXWfs/+SbEGbylGqXOszXIw4r4zoCh/HKrZiWCBDafTWrDs0zCnkKW8j2yHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5782
X-OriginatorOrg: intel.com

On 7/5/24 06:19, Chris Packham wrote:
> Correct the example to match the help text from the devlink utility.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>   Documentation/networking/devlink/devlink-region.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/devlink/devlink-region.rst b/Documentation/networking/devlink/devlink-region.rst
> index 9232cd7da301..5d0b68f752c0 100644
> --- a/Documentation/networking/devlink/devlink-region.rst
> +++ b/Documentation/networking/devlink/devlink-region.rst
> @@ -49,7 +49,7 @@ example usage
>       $ devlink region show [ DEV/REGION ]
>       $ devlink region del DEV/REGION snapshot SNAPSHOT_ID
>       $ devlink region dump DEV/REGION [ snapshot SNAPSHOT_ID ]
> -    $ devlink region read DEV/REGION [ snapshot SNAPSHOT_ID ] address ADDRESS length length
> +    $ devlink region read DEV/REGION [ snapshot SNAPSHOT_ID ] address ADDRESS length LENGTH
>   
>       # Show all of the exposed regions with region sizes:
>       $ devlink region show

I don't see any other case for such correction in core devlink doc, so:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

