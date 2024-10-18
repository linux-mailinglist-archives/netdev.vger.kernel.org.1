Return-Path: <netdev+bounces-137149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4D09A4945
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79065B24751
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 21:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4D618FC99;
	Fri, 18 Oct 2024 21:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxj+IcHT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2219005E;
	Fri, 18 Oct 2024 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729288260; cv=fail; b=TjFw9AC18mNzFtj+L9CFxUTqR/W0Kqu/T94yNzUY/ITc+nqY+FUBpyCkEo0RgoNdUnTxpL1P6TBBEsWxzYeb7R9eO7WcADK6nr8/0DHBG78KU0oMsaKHnzXMWJxd8iKUn6D0u/hLDvZtzC+EwSAGC7Bs4Bcetqg6s7SUwhdg/Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729288260; c=relaxed/simple;
	bh=EIGXjcIE7Bkah3CBbHjJxoDHDXh30yfiC6EusNqT+y0=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oRDMotYXYDVCBUqvvdWOm5St5upoetpZxYHemEudbVQ7EvSLO8Mn5BnWyNQCqboBfqtvJ0jc6lPcsF+VYOKxJkjE1P9hs14C1xBh9GiOiHCPp2DoajXqvWbGEB+3XuTXqCy68lzHRifQa5UA8X8IrpsJXtIb5yLuZEjOKaiOM7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxj+IcHT; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729288259; x=1760824259;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EIGXjcIE7Bkah3CBbHjJxoDHDXh30yfiC6EusNqT+y0=;
  b=cxj+IcHTnzd9xrFxdvm0rEE2Km69xNdlYB6WLrSSL6QPXJAFmkH2k62c
   YS/rkX2gVjuZT1tuorqiUAYUOER+/CU1h2P0PlaD3gTUc2Zexe57hkU5X
   sWDb3emnnjgrPbTIUZj1Yn4KXHyDRsk7IZzJ1MgV2YJBZzVlt7shVGn+/
   6g5QZIwaEfH+lrPkl8l5fxfcUayfDZGmWICVfSHciNM29vwgaQCFrvh4O
   CrN5X5a6lGGMcNDatiKAc1Yf0RrD3G7r/Vs/Ji4Zc2yaPdLIsjlYVDEJJ
   O3AvECz1L5DBQP7ChHqz4narb9Mr53SwLfmxW8892etAB/8QsbQUNKp52
   g==;
X-CSE-ConnectionGUID: v2oE9sB2QW6IhTfdMLnA4A==
X-CSE-MsgGUID: t3J/QoawSw2KplIPbGS+JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28926789"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="28926789"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 14:50:58 -0700
X-CSE-ConnectionGUID: 2PiKtH6NRAO7iMWh0qtP3g==
X-CSE-MsgGUID: YD2mpn9fT92b6GTLQ7y7aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="109810117"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 14:50:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 14:50:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 14:50:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 14:50:56 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 14:50:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBGKBj7rFURLL3hk78lsV784Qq6wIz5r4ADnHQi2+oVcy9LwdKXOSVrrz6niUU4cmA/f+k6xhtkb8mXQspovy/S1L47B6lhLemAW4hhj2WWNj5d3g3mNuDrgFwFJDgioEP6GwXX9Y/PEy2aC72kCoyCQf4LnErsfT3RBUQfU7Gfgf1HyxGPb2UatetHUiiI+9ET8532v5uxLj2/G2hXM/PMa0DwJDOFnlAjCzJYZUcpVoNFM+/WbBN5bp892vZ8fD1iqZe+J0+P4g8kOZ2qMc1aEronCKJZSXGU/8Nph+9DbOBKQFMy9CCi7pP0Wso37JClcIiLgy8ypkHyu6mtN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPUM4Nn8MbXfC5B3wyJSUnzdms2rxS8PwLp+v9vtOQQ=;
 b=RNrVu31O3qcH9GqVPSeaGnI1ZAC4ai9XLPay1tKK4POL2kWBWjIUPHe9ZcDEsDwgc9BsaGvyhrTJ+Tks3EgOpsF3D1DQpatNP5u8qtxXZsXs6f7UfV4erMP0i+si21m3307cJtXgCbsMsJGmCqlrX8O75PmClWtl4TErs2rM6rVlfHDEZ7nHbdBqb77BkhLo02+yLky4ctdCIKOzCFGEWFD9AP/AUHvMDRXnwCrybApwERuDw7sXukcO3waBhHS5LQo2+uuYeJBsJ/JK/R9cEWD/qsrvr4MuiVn4eEYBGhzdvvJUigQV+n1hQfPz8yITIPjEAiQafsbvvSs1C5LFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CYYPR11MB8332.namprd11.prod.outlook.com (2603:10b6:930:be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Fri, 18 Oct
 2024 21:50:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 21:50:54 +0000
Message-ID: <e961b5f2-74fe-497b-9472-f1cdda232f3b@intel.com>
Date: Fri, 18 Oct 2024 14:50:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] lib: packing: add pack_fields() and
 unpack_fields()
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-3-d9b1f7500740@intel.com>
 <601668d5-2ed2-4471-9c4f-c16912dd59a5@intel.com>
 <20241016134030.mzglrc245gh257mg@skbuf>
 <CO1PR11MB5089220BBAF882B14F4B70DBD6462@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <CO1PR11MB5089220BBAF882B14F4B70DBD6462@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0079.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CYYPR11MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1de267-2de1-4c1c-e4dc-08dcefbef0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGkzRVNMY3ZZT0pvbnJIaTR3dnhjRE1iaHZnaVlxaFZSVEZRZFBFR2RtK0p1?=
 =?utf-8?B?dlBRVGk4Qi8zMHlWYlJVQi9VZDVhYWhhNDh2eHdLcHNlTkRielVJRytuVXRS?=
 =?utf-8?B?QmVnMm10MGpOa1lRM1h4K1ZzaTFQSEZYMmdLdXl2VlJiU0RvbDNPcm81MFFn?=
 =?utf-8?B?cXRTWEhtZ3VqRjFTS3ZxR2dreURuK0ZNUWVsdUc0ODhmVzRhb2RUdTE4TDFz?=
 =?utf-8?B?N3MyZnpLL2hUa1l3eWQwVWs0ZDZWSjdOa25hbkN3elZyOFZJUm9hY2ZFVGVO?=
 =?utf-8?B?d3NhcFZUZFZWL092TUJ6TzU1WU0zM1k0OE5LRjhQUFRZOFNjZHY0SmtDRkJM?=
 =?utf-8?B?WGtxZkE2ZEZHb3pwbGFlTk5PTjUzSmtGdlYxb2RtbnJNUE1DRCtjQndmaGU5?=
 =?utf-8?B?R2o4ZEtDenYxTWRxVytwWndaQUxjSTNzb3dQd2lUeUVEWjl6Y3lELzJtMnBJ?=
 =?utf-8?B?YWI3dU5VaUZJQlZOYTVsQldwN040cFpBbUluVG4wYTNpcEg2UkFOd2dhd25F?=
 =?utf-8?B?V2hKZTM0VlZuRkFkMnRnekgrdkw2ZVN4TnR5RHVxeVE4eEgzZm5qMFBXZXB0?=
 =?utf-8?B?cjdDWE4wY3cwcXU2Y1pNUmVhU1d2c2VMbUdzak1Lc2l4TG0xR0M5U0dkdDQ3?=
 =?utf-8?B?YlRBZFdVVjVrMmlDTFIyZ2JDcUIza3NHYkkyWWQ1d0RCTTBjUE5ZZnBBZ1FR?=
 =?utf-8?B?NG1tcFBXc0lSWHp6M2xZKzJjeW1EVUw2WExRbkt4Q0FmUnhMVHF0aStqd3pL?=
 =?utf-8?B?TG1nM2tjZkJpUDJTd1NSQXJib0RmbFhIUTBSUWZSWGFzVG5oV1VvU0ZrT1U5?=
 =?utf-8?B?N3FZN3VNTDJwWml2RlBuNy92dWJnamF4WDZFSXEvU0t4K2drRDMzeUZhMUQz?=
 =?utf-8?B?UUQ0dlZMZmZlZFZtZU15VE9aSmw5ZnNRUDBwZjVISHFnMktDb3RNNkVaajZ5?=
 =?utf-8?B?bllHaUVVekNTSTBwTHJVWXpCdFhQSXF0bEpOVkQ2bFpVSVhvYW53ZUcxVEM1?=
 =?utf-8?B?ZHV0NTQwMnpNamg3NE1JTFExUS9KdlV4YVRBOEpQcU94aTBpaHpXK2NrMlh2?=
 =?utf-8?B?Z29Qa1dIRWpIN2ZLdk0vdEdlWDRQRFZ4ZURHNkw2eEJmWGVwSVlxWTBNNEVx?=
 =?utf-8?B?bHcyZXhiRG5YT1hhSi9WOG41a2lFTFVjcFVaeWpsNityVXh2RDEzb3VDS2dm?=
 =?utf-8?B?a2FSM1ovbkxsRkU5d2hMV0s2dWNnODJGQ3NXWVp6ZlltVW1ZVWxjVnluMUNr?=
 =?utf-8?B?STNhV1BUbEdRYjM2UmtDdkZvc2ZhSmhpY2FJY1hBYjd1UXhxSU9BOGs0ZWtm?=
 =?utf-8?B?YzhuM1lvYjI3TE03aE1VME9HeGNPc25WS3hsRXBDeFp6YmdxRXRuUVpaazVl?=
 =?utf-8?B?RVByMmJEdzd4VmJmQ3RJSEFxWVlLMmZBRktUNlRJR09wV1pDVzZLTklEd21H?=
 =?utf-8?B?T1ZFU2RiU1djbW1MUU1hRU5iSFRGV1YvdGwzN0VRZjlNbk53bFAvMmtNZytQ?=
 =?utf-8?B?OXd0cGk5YWtvSFU5Q04reDdyY29acVQwSWVWSXo2QlpLL2l4REhBNVpTVDRN?=
 =?utf-8?B?ZzNNSlhPNzY1NnU5bWF1Ry83QkdSdzJIMHl5dk1DU3NjbWJzT1lJYUJyOHlJ?=
 =?utf-8?B?ak41cm11YnJXUjZFUzQ0YS9rdUdscTYwbGk0ZGViazJFOGFNNzF0eE9RWHhr?=
 =?utf-8?B?TGdEQmVtb0ZaQ2pHNUNWU3BNUm1hMjh2bHFSZElaTEpjZkRFa1FFamF3ZVBT?=
 =?utf-8?Q?3JWRCFmAwcyaUUbEHjeZhSqmqAmZ3cMAFJCkr1T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R01qUDZ6UCthalNRR0NPbUkxZEZuWUZ2K2FEZUk1Q2YwNis2YmFkd2tEcERQ?=
 =?utf-8?B?ZGMybmFScy9hbnNLaWxrQUFSVnhQU1hxeDhjVDJ5ZlJEbkM5ZU8xYTFzQytW?=
 =?utf-8?B?T2Y5Qmx0Sk5IZ0VFVnRuKzhVeitmNklsWVNsTERYSTFwSHUrRlpCdmlvR0Jz?=
 =?utf-8?B?N0R6T2tsVTRwL09CUmQyVVlXUk5kZ3hNK01EcmxxY0xBNUkyMnFNUFFxMzZp?=
 =?utf-8?B?NW0yZG9jdEJzVjRhUUZROTI1MDh4c2ppdGRlaWdJS28wQ29CWGhLWUtyank3?=
 =?utf-8?B?Rk8rTFl6L3dpUGd4UmxtenU3Z1RrRm44dmdZUVRCUXd0SmRmR2xxVVljUWI0?=
 =?utf-8?B?ZkJQTGJ6T3RqVDE3VmNIK1Y5ZWYxMVUzdDhtK1JwRWtzeVhWTHFZdnJROEht?=
 =?utf-8?B?dC93ZmlnVFlKcG0rY2htRGpCWTloSmNGWjdqSzByZWxNcHRwQW1NTzhsZzVH?=
 =?utf-8?B?cWZidWY0UlhTTlVTSXNXUzlOL3UxeUJpQW5oQVFvQ1RmMzRmYzU1dHZMYVNy?=
 =?utf-8?B?M3BHdUJWazNBU3dPUDdrV09YWW9Ha3U5UkFxejQxcHZTQkg2R25JbC9WVzF3?=
 =?utf-8?B?dSt2dlNvZzVOQlJleHVBVDg0M3dIdkpybVA4T1JrcjhBb05mVEhVVkZYaTFE?=
 =?utf-8?B?TFdRbzBoL0ZFWGxTUTRTTXZ1QnEvMG1nRkxrZTNibVBFYkNCRjVsanlRc3dN?=
 =?utf-8?B?UFJaYjAzODJodnNjb3R0ckFwVWpwN2g2R3NvY1hUblJMM3hrVjZXdUhma3kv?=
 =?utf-8?B?WitxS2dIQnVpVVNDa2R4bkk3R1JJU2ozajNuMnJKZ1lSS3lOUGdycFR2Wi9R?=
 =?utf-8?B?cFJaVFVFZWc4YVk2RHg4RjRCWGVVU3dJeUZuVlZ2N3hON21FSmxPMlBvcnM2?=
 =?utf-8?B?ZmZWUk9pWWJwWmhxSC90eGpMOUZmYWFTS1JkM1dpaDNKaUw3VHJEdzdZeXhu?=
 =?utf-8?B?MWdHOXBPNEF0NnNQWUd4RjZWazlCVjBWdG80UHlYUWNGS0MwUjFiaDh1YXVF?=
 =?utf-8?B?VCt6c1VkdHFJY2tiRFpkMDZjZ3FxQ1lZNG5KN1RGTFVrVXpxaGlXKzNJQzkr?=
 =?utf-8?B?RysvVXlEcFFGSkJlN09rYjFCNzJGU1ZiRE1UUUdhTTlkR2NRV0RxbDBIZUpl?=
 =?utf-8?B?bU11UzRBUmlKOERCOFI0MHhRZ1JDSHZ5NkxJSDdONFIxemFjMzkrVUVQMlJq?=
 =?utf-8?B?dTBPT1dONjQ0MDhCZ0FKclA5eTQ3SGgzSFU4QStRWllsUzJhb1crTlMwZmdP?=
 =?utf-8?B?SlR3OWpROS82U0t5S3V0MEx4bkFkaGJCR0N1eGc0MStXcllKcXhnVXVNL0Mx?=
 =?utf-8?B?cXk5VzFVcDY4TzNjOFZMV2JtdXRISDZkUFpLbmxkbG16OGM2V0p5UzFlOFBr?=
 =?utf-8?B?ekVLRlF3MmV1MWRoRHAyd2ZZMnpCeVdVU2RxU1FtR3hXUFlLeXBtdlpSNHVu?=
 =?utf-8?B?T3hPMldWQTBqWWw2OXNrNitMWnFodU0zN2FHSjgyOWJzTjNaY0pCSDZYQm5C?=
 =?utf-8?B?WklvWGJuUDZ3a3ZzUGxkMTV1MWtXL0tSK0NPUjc5RzFyM0o1NHM0NGRwSWMz?=
 =?utf-8?B?dmVJNHpVR3kzVHphVWsrVGdabkpCaXgzNS92blE0akxKMlZjRVJ1Sk9BZTJ0?=
 =?utf-8?B?RFdCcWdORlJaS3c1WDYrQmlJR0g0eFpSRGpGWVd3OHE5SXhPQnlubzd4TTRT?=
 =?utf-8?B?b2FGVnZ6Tnh5ME5ydlBZWnMyaDhHRmRBZWlNajFtdWZXQXkzVk5YMmtzREV5?=
 =?utf-8?B?M1JlQ2wzaVpnWHdHbEZBTmFIM2hsbkdGNWRKRHc5YzEzZU1TNVdNSld1Z0s4?=
 =?utf-8?B?OFJ2TVozbzZXWlMrSWZZdVlKcnBuZE1UdUhNMnNFUXIwMmVOVkUwd1VQM00r?=
 =?utf-8?B?SHVUK28wbVI3MmRlOFlkQnJZa2t0NDNUSnY4OWhndjU5YXFnVk91dGxYdS9R?=
 =?utf-8?B?OTVyeUhsZDlBTEZXRDFMRXdud2w4a2E2U1lMaFdMVnZSRFdPdVZ3WlJaaFFk?=
 =?utf-8?B?L2cyR0VsOUJ2TmNXWHZmTGJnUXQvR2xKNVNsQ1BkUkZpUitCamttVExoUUNI?=
 =?utf-8?B?TlJ4ei96RlBEN0k3RlZhVFdIbkxIY2tCUGRVeG5LZkh4VmFQcC9veUM2TmN5?=
 =?utf-8?B?TDhhbmc3dy9ES2dhcEJYT2VBaEdzR25ta0JpRkF0bmJTMWVrYTdpRDNkTGQz?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1de267-2de1-4c1c-e4dc-08dcefbef0ea
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 21:50:54.5757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uT29fUN+CLKty3EP42kSwYpNn1bGxfZvmVN3EcJp9SlMQHPSos7i4+02ibDDrUmla77+sIh5wCz0fhVb+vxhYaQqDmr4xi6Oyq49qGMmXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8332
X-OriginatorOrg: intel.com



On 10/16/2024 3:31 PM, Keller, Jacob E wrote:
>> On Wed, Oct 16, 2024 at 03:02:38PM +0200, Przemek Kitszel wrote:
>>> On 10/11/24 20:48, Jacob Keller wrote:
>>>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>>>>
>>>> This is new API which caters to the following requirements:
>>>>
>>>> - Pack or unpack a large number of fields to/from a buffer with a small
>>>>    code footprint. The current alternative is to open-code a large number
>>>>    of calls to pack() and unpack(), or to use packing() to reduce that
>>>>    number to half. But packing() is not const-correct.
>>>>
>>>> - Use unpacked numbers stored in variables smaller than u64. This
>>>>    reduces the rodata footprint of the stored field arrays.
>>>>
>>>> - Perform error checking at compile time, rather than at runtime, and
>>>>    return void from the API functions. To that end, we introduce
>>>>    CHECK_PACKED_FIELD_*() macros to be used on the arrays of packed
>>>>    fields. Note: the C preprocessor can't generate variable-length code
>>>>    (loops),  as would be required for array-style definitions of struct
>>>>    packed_field arrays. So the sanity checks use code generation at
>>>>    compile time to $KBUILD_OUTPUT/include/generated/packing-checks.h.
>>>>    There are explicit macros for sanity-checking arrays of 1 packed
>>>>    field, 2 packed fields, 3 packed fields, ..., all the way to 50 packed
>>>>    fields. In practice, the sja1105 driver will actually need the variant
>>>>    with 40 fields. This isn't as bad as it seems: feeding a 39 entry
>>>>    sized array into the CHECK_PACKED_FIELDS_40() macro will actually
>>>>    generate a compilation error, so mistakes are very likely to be caught
>>>>    by the developer and thus are not a problem.
>>>>
>>>> - Reduced rodata footprint for the storage of the packed field arrays.
>>>>    To that end, we have struct packed_field_s (small) and packed_field_m
>>>>    (medium). More can be added as needed (unlikely for now). On these
>>>>    types, the same generic pack_fields() and unpack_fields() API can be
>>>>    used, thanks to the new C11 _Generic() selection feature, which can
>>>>    call pack_fields_s() or pack_fields_m(), depending on the type of the
>>>>    "fields" array - a simplistic form of polymorphism. It is evaluated at
>>>>    compile time which function will actually be called.
>>>>
>>>> Over time, packing() is expected to be completely replaced either with
>>>> pack() or with pack_fields().
>>>>
>>>> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
>>>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>>>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

<snip>

>>>> +{
>>>> +	printf("/* Automatically generated - do not edit */\n\n");
>>>> +	printf("#ifndef GENERATED_PACKING_CHECKS_H\n");
>>>> +	printf("#define GENERATED_PACKING_CHECKS_H\n\n");
>>>> +
>>>> +	for (int i = 1; i <= 50; i++) {
>>>
>>> either you missed my question, or I have missed your reply during
>>> internal round of review, but:
>>>
>>> do we need 50? that means 1MB file, while it is 10x smaller for n=27
>>
> 
> That is partly why we generate the file instead of committing it. We could reduce this to 40, (or make it 40 once we add the sja1105 driver).
> 
> This would somewhat limit the size, at least until/unless another place in the code adds more fields to an array.
> 
>> The sja1105 driver will need checks for arrays of 40 fields, it's in the
>> commit message. Though if the file size is going to generate comments
>> even at this initial dimension, then maybe it isn't the best way forward...
>>
>> Suggestions for how to scale up the compile-time checks?
>>
>> Originally the CHECK_PACKED_FIELD_OVERLAP() weren't the cartesian
>> product of all array elements. I just assumed that the field array would
>> be ordered from MSB to LSB. But then, Jacob wondered why the order isn't
>> from LSB to MSB. The presence/absence of the QUIRK_LSW32_IS_FIRST quirk
>> seems to influence the perception of which field layout is natural.
>> So the full-blown current overlap check is the compromise to use the
>> same sanity check macros everywhere. Otherwise, we'd have to introduce
>> CHECK_PACKED_FIELDS_5_UP() and CHECK_PACKED_FIELDS_5_DOWN(), and
>> although even that would be smaller in size than the full cartesian
>> product, it's harder to use IMO.
>>
> 
> Another option would be to implement something external to C to validate the fields, perhaps something in sparse? Downside being that it is less likely to be checked, so more risk that bugs creep in.
> 
Przemek, Vladimir,

What are your thoughts on the next steps here. Do we need to go back to
the drawing board for how to handle these static checks?

Do we try to reduce the size somewhat, or try to come up with a
completely different approach to handling this? Do we revert back to
run-time checks? Investigate some alternative for static checking that
doesn't have this limitation requiring thousands of lines of macro?

I'd like to figure out what to do next.

