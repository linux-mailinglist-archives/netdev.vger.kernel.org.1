Return-Path: <netdev+bounces-295397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id acCXAXbNIWqrOAEAu9opvQ
	(envelope-from <netdev+bounces-295397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:09:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 575A1642CF0
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:09:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Cbuky8G8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295397-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295397-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B9E53008A4D
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 19:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAD737646E;
	Thu,  4 Jun 2026 19:09:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C756A37EFED;
	Thu,  4 Jun 2026 19:09:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600178; cv=fail; b=JumMJqxY8EY9IlUJCV5DvdcPJHvs/FnVMgJUGB1nOCIZDmh5iMt5UgXfwpAO34tjrbcpUjaGWyuPO0Ug4M1bVRiYUWjIKT0YkMhqP/EkJ2fmLUjNkaIfog4OB7Ap0xRtU+tFT5ABWMbtr51/K/lwFo4yS4Td2kx46e1d/Ty7S+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600178; c=relaxed/simple;
	bh=G+XlyijVRXXLP8oEP8PE8Xwl9tgzbunw8yh21/do1IQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vnvml+ge7D0aeEbmPlRKEIqaDoBEixrMeF6a3TqZu9Lr6Kxm4UIaBKaMVuP0GhmisoRtqpY9PglzOhk9JWBWe2kqzsUp/AXAtKUoUDi5OmxEpqX5nzONAcXmDSCYzfdfPZZ+QV8QVq66E80MrgiRaKGlJhrhsYJUA6y/Mq0XSlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cbuky8G8; arc=fail smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780600176; x=1812136176;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G+XlyijVRXXLP8oEP8PE8Xwl9tgzbunw8yh21/do1IQ=;
  b=Cbuky8G8qZEMk7s+TlBdwlQD08BiePRZxfak+zRi9XZ4iWWOzpZNR0+v
   08M10XwyWkw2k2ak4L09cEQXIai3TLF51IVoU30VCyekvm25dwb5QXD23
   4sCfy+E3v2lorPNoqF4AZu8alvH4iBnBD3qbpAfkB1leRZhs1ztFsQt3U
   zjGA9ehxrF8QN5/EMArE1R+WRXa+JJv60BXQIHqjNXa6smddvNv0dbca/
   9aMbquwjPED9FaMsEVi8EpaSGUKtXM7nebzkBFrvHcXwLkr1aIPSqZAYl
   2qhkIYSEyHyCNWXTEFpeBOsBNDerKjVNioOT8T1xhMdnbhzQ3ILxIHsv7
   A==;
X-CSE-ConnectionGUID: 6Orwj6gnSGijDyigMTPPkA==
X-CSE-MsgGUID: CQsAZNjdTHeMNRQ/0IGbDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="98852959"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="98852959"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:09:36 -0700
X-CSE-ConnectionGUID: Y0OKu7+6Ql6+51wxoJ6/fg==
X-CSE-MsgGUID: IQNRWUZXSHSX61sMZoAdSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="282723739"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:09:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 12:09:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 12:09:34 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 12:09:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ll9OQsao810TTzT3U41Q7KO+o8t0VdV+/wAI89b8Y0RD1U5or82xF7wphvZMVoXoiQx7mJnF0mbFS9AHseUSB/1dMXioAL0petC6oBNodki7bGjmTV3JAvH674Ff/cxyJ4ht8SmxE56Uji6IRUK0rtGSs95eiCpxq/GW3HQxmLetmrZTzTSBROjnsgXx0+n2Rh2tGK3AEVSFL1pWtsMm5vCLFs0v7akrDM38V1BzT2Rs3VaXSpveGiUgOFz7UtRz7f7TYxPtWGFrVoR72CEv2dVneueZevHKnXOWsCi7WU4av7IwPEfGBLuPCmoqgTS8vfo837/xw/UKzu47tHAWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilY7yT38FwrT6IMUQGtQ48XEisqfX2yindt2d/J/DUY=;
 b=ppoZmkFuRWtRkM+p//6ZpX79QGrXga40BxOjeTBLk+cHuEScm42gExn4CAMFNdgEIgiStrTmftWVBJFaVMknpAe4KMK9SI0iFNpbOYeQ9z/A/GVVWNcVmUnwBtPMKZ7AmZnK9r3MQTn6AT+APdYx7vHBrjDBeouylIJFJIyKNSUlpKGfUw/wbGxOiU25SXv7cK7CJTm8o/i5/MQ3bB2qFLcmXGt8fClnuM1mh9CGeilbwGO0sXeFvjYTYTWUAhDRXzhXDZUUkNdCOkZj8dV+Tzsowr72LKiIg4BmilHTBQLI0pWk1tUb+GUS0lVUBIIo9c4kFwjx91gbvle4f4b2lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CH2PR11MB8777.namprd11.prod.outlook.com (2603:10b6:610:283::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 19:09:26 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 19:09:26 +0000
Message-ID: <c4e85589-28ab-432b-8148-74ceeb9facaf@intel.com>
Date: Thu, 4 Jun 2026 12:09:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: b44: use ethtool_puts
To: David Laight <david.laight.linux@gmail.com>, Rosen Penev
	<rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, Michael Chan <michael.chan@broadcom.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
References: <20260531000334.388351-1-rosenp@gmail.com>
 <20260604095010.35476abb@pumpkin>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260604095010.35476abb@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:303:b9::32) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CH2PR11MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: b1cc0a80-ed7a-4f35-b07f-08dec26ccbc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099006|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: xoSnn45a3/zMqhcb/ArQ6R4dGtWBa4l2Xcudd+74HbnOoA2GrzhQcpuui0as9nuKt1Z0YsEVQ9hSAAUyu5c4TcJnEfSOD64vueOD83X8ZqHBqQlRVR8KAjN36zO70Vm/AFCo2Yscy0kIGVu2TCkWJNyw79Ub5NcOe6qDj2i1ajoa5bL2PVSv4WGKvKi2xHIhHOZyoEjTHHnRfVOPcNsbtZxke4KV848yC3AbzfOtkBO408rXz4r3PS/sqUjiT5qBOXMRiyYQp/YcfdeDz8MCMzf8RY9uPC4NLxaG0I0sYTIMYSieHGblYINlMin7PAzjMdo/dgOpYp8WUW8grMOR7rgY8Hecr+Aq31tp/gWR5rk0XA6iu4z7XquvARqpj1Fq6IZq62eLDvR3YvPZRQ24gt1HkWfcqEoqMpmcjhio+emJDwRlAfjHFZ+EB/xEMgv8wYrlrSsVa8+1JTfUfRq1d/8e547CwmhPLePeHQoFPM4cey5McIxb9gnzJq2OZUmH2q21zHf8pLZOHdusJEq0zgBzS2+hg7EV8brbQdy2Ft/tkQu7vaoThtUTn+0k/8CscmZwT443Dn8qYq7J0R5k/xh5qop45m8+Pj+OawdS6pQMSq9IpyAIIkSKmewTkZ5qutLYcz52LmmCzP14FlULAxgyKNmenTvivqpC002D+5lBU+frtFIMJruG7/gut7/o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzkraWJvS1ZUVjloQk5iaCtNMlJGejNCektsUVNCdDY4c2VqVlpNbUR2WVVZ?=
 =?utf-8?B?Mm4vOTFaYXcvYWNyaXliMFl1TDYyL0Vid05FWE9JbEg2N3BCVG1RN0hoY1pI?=
 =?utf-8?B?NUhJYUw1VnplT2FNbzlOazlvOXVvNHdBN2lvMzBQdlJ3Vzl0Yy9VSm9hTHFi?=
 =?utf-8?B?bGhRbHh4QTErOW93WjhtZE1MYWR5UWx4MGdoY2MwbXBHNEJWRkZaR3VqN0R4?=
 =?utf-8?B?QlRFZnFTaElyM3JHVWZOZGxpa1FwaVFMVUxKV294WkluM1RpYi9HdFJydXkr?=
 =?utf-8?B?a0tyTDd2QXFrR3VVNUtDWjBTQ2UwVXVRVDk5T0ZxSlFJYUlBdGFUeVV3MGlh?=
 =?utf-8?B?MWczZTdZaWNUN2lIK3lGeDRuRitHVDNTTUdxcDRiakpZWWFZeGZ5cUZnTXAv?=
 =?utf-8?B?c3Q4VVpNQjBPNXp5US8yZWp3b3pFZG9jVHJ0QTI3Y0FQS0tlZTZjUXNkdjRY?=
 =?utf-8?B?R2dTb3VVYk55QUx2SUNMMzdoME1NbEpGN1l3TmxhcGFnd0V5UURrVFJhVzc3?=
 =?utf-8?B?c09SN25BOStDeW9NT3dpZ290bjEyaURSVXZtMjFobzlHcmU5YmxWdmIwckZL?=
 =?utf-8?B?Y2w0V1dkVFRZc2dQQ0U2azN2dWJkSXN2Q1IxSU9IY256cHhidGpIU2FqQjlG?=
 =?utf-8?B?YU1aNG5HMktEZzNSL1RpVENCUHRBV1ZsbXUxYWVFblpKQ01jb3VsS3QrUFBq?=
 =?utf-8?B?Z3p2d093bFBKV3lBM25LSkt6cTg2ZHFRK045VjJEbEF1MXdUd2l6VXI4a3dH?=
 =?utf-8?B?dml6eFJlZExiZEpnNE9VbjVlcllQMW02ZW1SUmtUMkRlbmFjQzNLbmh3SGZP?=
 =?utf-8?B?eWtwZGZvVmVrcFV0TUpDT1pjcVlyYmIvbEE2Wi95NGtZMVpoVzMrQnVQazFM?=
 =?utf-8?B?MzV0Z1Y3eHF5bVpxa243Y3BvWExiTnhyR0hYSEpNbFdxMks2cGdQdEQ0cGtL?=
 =?utf-8?B?UFlqdC9LZHdlZlhORHB5U0ZyL21hWFJ2ZDVoTE9TQ2hHWHZ3Sm9TemM5S2Zx?=
 =?utf-8?B?TVdoNzhLaUVUczVwbUN6RldycktIS21CZFphczZMNDlvbk0wcEJTNHkwSjNX?=
 =?utf-8?B?U0JHYlFmWFlwR0xkbGxUdi8rcXFnNGJ4WHVEODQ3YkVxYXpxS0QrRmNzZ3lz?=
 =?utf-8?B?QnVlMVZQYkw3RDc3RUFXeDFqWFhPWHkzbDVHWnk2SlB4UEpFYVMrdlN2SDJm?=
 =?utf-8?B?TTlrOG5vcnhMa3VzYkt0c1Z2OE1vUXoyUmtBZzZxMWdTMlQrbmMxa3M4ekg5?=
 =?utf-8?B?TStRRFFSbjhXOWEyMXQ1RmF0T2h0bFRSaUViWUJsUm5ZRkZkUW9ySjN2dDUz?=
 =?utf-8?B?UHJYNTBPUTB1M2wydFAxZHREZnUxLyt4S3U2bHNvRDlUWjl6L3NSRmFUM2NG?=
 =?utf-8?B?Sm0yUk9lT1Z3aU1WY0Jta1hWV3M3SXhKaEZPbVFCaUJma0k1aENPcXQ2ODVS?=
 =?utf-8?B?QWhJSFhqWHk4VTBJYWlzQjRYamhVMytHang3N1JrR2x3VERsc0V3bHp2ZmhL?=
 =?utf-8?B?bWNuTCsyNFVybUJ5Z05jd3FFUDcyY1NRWDJCVlJnUlFzQ2tXdWpHTHd3Y09D?=
 =?utf-8?B?NEFpV3I0ZmM0TVZCTmtmOHo5RnZXSWVYOHhoVzlpc1JicGU1RnlOT0ZKQkZD?=
 =?utf-8?B?Ukl6T215TU9UU3pqL2lrQzNDWXlqNTh0akMwbFVkeDdlZmNXeFJpQkFTandT?=
 =?utf-8?B?b3RkUU5jMGFwRE9XYmtwSUhuUjV5ZGR5SWpxRmFNcVd4Ull5YXdVRXZVYTJS?=
 =?utf-8?B?TU9FWGhhSVIwWTZvcFJMNXV2OGhhc0wvdSsyTXBQLzlLcmx2L05zcHVHSWNr?=
 =?utf-8?B?MlJwdWpmMHRlQjJHbEYvdFJ6Z3orM05lZmZmbFloRTFVSjZDRStxNkNITlhK?=
 =?utf-8?B?N0RiWFZCOGdFN1k5VE90ZjZ4NUdnTFV4UmI4Ni9JeUZGNFF3L3ptNVF5enVa?=
 =?utf-8?B?VDFmUnZxM05RTCt5TDZWZEttTzY4Y3hrdDhqWFhLTFpUTFp6eVhUWmtxV2ph?=
 =?utf-8?B?MjQ3aFpNaUR1MHg0bU1vTFNtVjh3Z1NDL0VCS2lpdFp4WGsrQXNDMHYvK1FC?=
 =?utf-8?B?MUl5c0hsWUNOSFQ4VDNTSHZod1FqNGJzd00yVENSRG4wdW40MUxQZXlSRyt2?=
 =?utf-8?B?NHRSdGxvcUFrWTlzYWFrQi80cjQ5bEJRZzJyQmkvNTc5OG1JMDFic1ZlUUN1?=
 =?utf-8?B?V0dyVGpyZWpzWXZpL1MzM21xT3ZKRVl5OU5JK3dwU2l3SGw2cnp2allSN1Vt?=
 =?utf-8?B?MFlIc3p5RlVXbldnTnNHdURoUWIwRWNoNjdtc0dUdUdhOTFxdGJybGk4S0ky?=
 =?utf-8?B?K2VoNmZrUVI5TXh4M044MjRRcVc0UG5BaTVOc3p2MzAwdEN5d05ZeVY2enlo?=
 =?utf-8?Q?ZQyp+ntcmq4RYwi8=3D?=
X-Exchange-RoutingPolicyChecked: R2yclz4gu9brDBxXkTaFY/qSVG1iSLgOIjf5Zu8SlDn9Plw3Ayyzfm3mHJMfdq+uXegQHMkZLsJH5usC48HVUmTZ3/kvWazQaFTeJMU6q1wis8Sy9fMsWYVIWZMtJQWxM8wWO5VZ4P05Ciwd+CMbjfGMxoSoAtD3oexPOw2oUZvhBMf0UJAK94ORjqcha3WylRT1k7BPoJc2fuCPQlEd3woUNbHK3VnrHN8kiuqaBVQktU0xhxIkK0lT+cjcxK3jTjaSF9bt5GJ9oaA8g36WAwnuv3CuImwEypJVALQIN8qvwL4jRg5jjoiAMnxsTvdIh9HZKxZMRNFaROmW+T55XA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cc0a80-ed7a-4f35-b07f-08dec26ccbc4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 19:09:26.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaOPpMVkrIghB2YRsemvENHJuEZZ29TDuKQFrpcCN1oZnXI3UQmU1m51jNTEEqZV4OtfkEsP3Mf32wNwv7EoRiHkmArF0XV6QU9sQHFQUc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8777
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295397-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:michael.chan@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:davidlaightlinux@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:from_mime,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 575A1642CF0

On 6/4/2026 1:50 AM, David Laight wrote:
> On Sat, 30 May 2026 17:03:34 -0700
> Rosen Penev <rosenp@gmail.com> wrote:
> 
>> There's a subtle error with the memcpy here, where b44_gstrings should
>> not be dereferenced. Dereferening causes the following error with W=1:
> 
> The definition is:
> static const char b44_gstrings[][ETH_GSTRING_LEN] = ...
> 
> There is nothing wrong with using memcpy().
> 
>>
>> In file included from drivers/net/ethernet/broadcom/b44.c:17:
>> In file included from ./include/linux/module.h:18:
>> In file included from ./include/linux/kmod.h:9:
>> In file included from ./include/linux/umh.h:4:
>> In file included from ./include/linux/gfp.h:7:
>> In file included from ./include/linux/mmzone.h:8:
>> In file included from ./include/linux/spinlock.h:56:
>> In file included from ./include/linux/preempt.h:79:
>> In file included from ./arch/powerpc/include/asm/preempt.h:5:
>> In file included from ./include/asm-generic/preempt.h:5:
>> In file included from ./include/linux/thread_info.h:23:
>> In file included from ./arch/powerpc/include/asm/current.h:13:
>> In file included from ./arch/powerpc/include/asm/paca.h:16:
>> In file included from ./include/linux/string.h:386:
>> ./include/linux/fortify-string.h:578:4: error: call to
>> '__read_overflow2_field' declared with 'warning' attribute: detected read
>> beyond size of field (2nd parameter); maybe use>
>>   578 |                        __read_overflow2_field(q_size_field, size);
>>       |                         ^
>>
>> Instead of fixing the memcpy, use ethtool_puts, which is the proper
>> helper for printing ethtool gstrings.
> 
> ethtool_puts() lets you pass short strings as well as ones that don't
> contain a '\0' terminator.
> It isn't needed here because all the strings are already padded.
> 

While not strictly needed, I think use of ethtool_puts in the ethtool
strings code makes sense and is easier to understand that it is correct.
memcpy is likely faster, but I don't think that speed is critical here.


>>
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> ---
>>  drivers/net/ethernet/broadcom/b44.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
>> index 90df02e0039c..f994636fbd5f 100644
>> --- a/drivers/net/ethernet/broadcom/b44.c
>> +++ b/drivers/net/ethernet/broadcom/b44.c
>> @@ -2031,11 +2031,11 @@ static int b44_set_pauseparam(struct net_device *dev,
>>  
>>  static void b44_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>>  {
>> -	switch(stringset) {
>> -	case ETH_SS_STATS:
>> -		memcpy(data, *b44_gstrings, sizeof(b44_gstrings));
> 
> Just remove the * or replace with an & - either is valid.
> The existing code is reading b44_gstrings[0] so overruns into the following
> strings.
> 

Right, that would have been the simplest fix.

