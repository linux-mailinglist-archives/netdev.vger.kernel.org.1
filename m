Return-Path: <netdev+bounces-96990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D708C8936
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 17:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FF11F20F73
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDE712C7E1;
	Fri, 17 May 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IptnDhyo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D8612D1EC;
	Fri, 17 May 2024 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959168; cv=fail; b=raoKgVByfYR+CRrYBgcxvxT3QCdSnY7cohVfxA1MV9JCryCVd+YeOFRhQwO+OJE63ttWT7kDpsi0pfUgCSkkOI5ixnh5CJmYA9r/G22V03LGB/D4nOjJlKfSnfDViB6izpy5mA3Mc8PqS6UDtOLN35bwSBF7S0eYBiG0y6eqxQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959168; c=relaxed/simple;
	bh=GaZl5+b4ZUAimqtNCz3bKgsWLIB+wZJGy1h55MrSyPs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c5fXkxhIj9f2JP4JusARxJ79oj3tuMWRI1bUal4kVNMq3FSHfcMKh1LxU777xTK73Aqe80nc3hCeXdh25kVFBMWoE2WP9VWY0oaQf6Lq0CofB8NwGgQfhWHqCt6RamIe5RcTitRjf0KcpGmHOH/AsnhbRji24a2W0ov8CIDiSEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IptnDhyo; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715959167; x=1747495167;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GaZl5+b4ZUAimqtNCz3bKgsWLIB+wZJGy1h55MrSyPs=;
  b=IptnDhyosIGrAzBDBpYjUFBae626iZTQtz9kfCwTy53ekX617tOWP8p0
   oTeAyWlxpu6Xi3PnC4rOg2Al1eW5vt9fkDg8lI1BOMGRp3c6WsHRfNUro
   A9KWr/yE1W7NgH0wzZMmxNQw1WKEATtrO38owohBOBBwvx6RBg49A8vyk
   c/0wVIZSrJ2bNm1o1YQjs9oIJktO1XC9/uCWjmXPtqkh3SZMjsvyhkYre
   a1UsVQLt4p/gF/VV/G6juccOSofN/VR+e7THV92McqExtV/nh5H8LCQza
   HJNq5npxrUIQ7tmbU+HrRjTdlbJmLhVSzxh+4pHe1g3bxZmA+jgOsHULf
   g==;
X-CSE-ConnectionGUID: g8z4t4+AREmAjX7tBJVWgA==
X-CSE-MsgGUID: qko6JQ7nTWCtdgBELKmC+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="15930322"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="15930322"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 08:19:26 -0700
X-CSE-ConnectionGUID: 5Z2ikMtsQF6TcSANxO6cMw==
X-CSE-MsgGUID: yKO33kUPQCaLD6HDuNaWmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="36237103"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 08:19:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 08:19:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 08:19:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 08:19:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 08:19:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtdF7OjbaDIZ7JLYTX70iGz8S7eJCgJ10JgMGuAd6kEdak161INJLTlhKuCYOQ6JJpvXahYxjxHu1ZGYSU2RTG0lFvYVEOJfoun5xwG5k2uKiUJUm8s7WTo7DgA822iquwRDjxqXCt5kVnjUBOmUQyLwbnxaj9XZkmrmlc1ELNDOtm6C3RdybwtGu5U77xePCWrOslDZ8ecUYpOv5/pM5LfX9sw6KCsLuCZi19ty/+WjY2Ol8Y3hwzL/2KdGHNHtfD+vk1MP0+NYwvZ4sPSAJxypot0Bl6LCjHQ9xvO2zus29rsy6O09NL8T8kXtR6Z9YBvlBbY3LTaxIz536CQfpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ8/YwgXwSTVy9Li4IoW/j5P9+jzgWVSAWMdYhNHJYc=;
 b=H3aFJefk0DSZFXFzevVeVOGjc8PqIn2PsUt6hAFLyYi+koCYI/IZ4IIJPSqsWxoQznpLyRFuwLRYG++RyqHkf8ZJwr3n1DxbB8TOu2U0QeYLbmsuI59ji1w+cQqN9KmcqySVe0X+LQocP1RISiWkajbB/Yk708g99nn4UmREhkvjJBUSi2F5a8zSoeoHjPg46QdX9cXseYKmBje4ObGfDvZXCxuUa2emu+XpeKk5wCxBagx6g50UZLsQ7XWOkZE+rCBCg9m8ciK41JBPe+f5v/KVRoayNxOZjvslOx1oHbbNsZu3PWkm6x3HU7mYrvHWENoIKwjShUqDGmU+R8aJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ2PR11MB8422.namprd11.prod.outlook.com (2603:10b6:a03:542::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51; Fri, 17 May
 2024 15:19:21 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 15:19:21 +0000
Message-ID: <dd7d2f53-3b58-401f-81b1-1690d5d88e51@intel.com>
Date: Fri, 17 May 2024 17:17:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: Always descend into dsa/ folder with
 CONFIG_NET_DSA enabled
To: Florian Fainelli <florian.fainelli@broadcom.com>
CC: <netdev@vger.kernel.org>, <stephenlangstaff1@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean
	<olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, "Alexander
 Lobakin" <alobakin@pm.me>, open list <linux-kernel@vger.kernel.org>
References: <20240516165631.1929731-1-florian.fainelli@broadcom.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240516165631.1929731-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ2PR11MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b06403b-c83a-47a0-f892-08dc7684ba6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K21aTUdWZUVnbmFQYlh5cmY5ODNVVTNiQlRoYnZQYSt0QjBvUnIvZmhidWt5?=
 =?utf-8?B?MEZEYkQxOFlpNCtVWW5obENPeVo1YTJzaWs5STduSDV0OE8xdmlPdDV6UTI1?=
 =?utf-8?B?WGxqQjNyTXVMQStGbkRXSjJxM2ZlOE82RDlLazVtcGltUzV4UURyQ0U2UnJG?=
 =?utf-8?B?M0dKTXhTdzdzRW9lS0VjZm50K2tZbmVNejBLRC8xRGUrQ005N1NHa01TVWlH?=
 =?utf-8?B?Si8yZG8vcmdPNWxGWHdWNXV6dnVHMlRuUzFQbkhRbEU3MnlkSDZSUXAxM1Z6?=
 =?utf-8?B?enI5S2R5d1dLOTdzVWlYYUpZR3RTeGFudE9yOXFtOXRRK1pmVGdCNHozbStM?=
 =?utf-8?B?YmtXR2JKNkk1Um1XREtJYk5mbU9uTlZJejQ1dlNCTEJremNmRFFPczNmQXpN?=
 =?utf-8?B?TGgveTFkY25WQW5xQm5UNFQvRUo2UUJJRVBpVlR4YlhaQ0N1ZW80Q1ZNZE5E?=
 =?utf-8?B?ZzlVd2kzSWhhdnkwaitldC85M2hDbUE2TkI1OVoxaWNVcEthVGNSZEpVcUV6?=
 =?utf-8?B?NTNXTUFwUUZOcVZNcnFOQ0YzTFl2QmZIMEZFUExUT3BBTUxsT05JUUFKanNW?=
 =?utf-8?B?RTdZNkE4dzZKRVM1VjhCYytzTUxMZ3R5QjFUZE9kdHJPYURzQ1BhMWVKemNX?=
 =?utf-8?B?cm9RRTVpdG9GOVlPTm9nMGdWL2hnQ2JVRnVLVXNOWTdpZ0ROeTh5bGx6djRW?=
 =?utf-8?B?MnB3YXRaYjRiSEhPdTlwY2VvR3RvZ2QvWTZrM2JjVDlYS0o1TERVanlxTFdB?=
 =?utf-8?B?blJKNXQ3WlVITXorM0ZUUlpQY1Q5UzZmRE05S2VhVFZyVGpSS1c2UUJBdHlw?=
 =?utf-8?B?eVQvTG5TSCsxZCtaQitFSmJFTU5lbFFZWGxIOGFLYzJiMWc2S2Q0ZmVhQkNN?=
 =?utf-8?B?MHZnVVVKUDBtY0tqMkpWWFlPc2xXMGxOSTMreHVqQ092WmdkZnNVL3g1VEFo?=
 =?utf-8?B?V0NvNEp3RUhYUUNuNlErZVVvOTl5UnpXY1pqbko0a1hvT29tcVdpOWU3OWMz?=
 =?utf-8?B?dHJhZE41STZXQlNrKzREN1BwclIySmttVUNpbE5YZFM3TzNjYm1OSmxYbzdM?=
 =?utf-8?B?OVZhNTYxR2F1SVNqUm52MmZna2hEZ2xZVUVhbGVJek5SbHpTZTZ1Q24rbHVv?=
 =?utf-8?B?UFp4VlNVSm5jYTdPNkRrTnlVc0cvL1RRUTl6VzQ4Q0cycy9nNkZpWmtORkly?=
 =?utf-8?B?aU5xVXNEUnFJK1VjTkdxdEQ3K1dNSjlEb3FXbW9CT3F5NW9tM29SNnNsU2VF?=
 =?utf-8?B?bjk4Z3ZnWERORkRHOStYVC9sbGIwRFFaUmF5Mjd0RDNYZVlGRHVoekxJNDBJ?=
 =?utf-8?B?bFNCdjR1VCtKWHV5R3lWK2RKRURFdnBka3RPd0hIRllNeXZNWGRoY09qR3U5?=
 =?utf-8?B?Y054K1lPQkM2dG83eWVZbzY3YXlBMFBRT09OcFNqUUdFbUtLcFpmb3lMQUo3?=
 =?utf-8?B?b0pFVW5iNHhseXRSRnJLbDZVM0o5Vy9ieTNPUXhLUnd1VUcrR2N2bklEcGRC?=
 =?utf-8?B?dm56ak1Mck5SYkZTMExrYzNNMmJUR251bkx3aVhzeGg2QTAwWFM3UmV5WlZk?=
 =?utf-8?B?TXk4UmYxa21zWVhZdkFPMlZtNHFpcC9jdStpQ2JBUmhreXNmVmNOdTZsbU5I?=
 =?utf-8?B?LzkvOEgyRXN0Yk9lVzVzOFYvU1Q0NkwyS2U0ck1TUEoyQmhpajhTUjRZRE1N?=
 =?utf-8?B?Z0xhWXFaMC9BMFdXUS9OTmNHeDZ2MUFnTFBjdVVXNWVPcmdnak9tcXFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUI2dzM2Y2FXOVhVWlRRbjVlcHI3Wm5xYVFrL0EwTCtyYnJ1NnNHTXZSQ0Mv?=
 =?utf-8?B?UnhPVVJ4Mm9yamg5RFppTWhkajVTY2h4S2F0U3ZFN1pTdkFWblVsamZHNlEx?=
 =?utf-8?B?Q1RYT1NZMllFbjBVNllkeWh0TStsbkN3OXdtZENRd2IrWEdzT05PekYwZGNB?=
 =?utf-8?B?ZStzSmxUTUxVNjVrbmFpSVdwdzlzUXppdkVmUkZFVmdzT0g2WDZBb2twc0Ew?=
 =?utf-8?B?eGlWZHVsNkFwclUxMGx4dmkrWnFDMVNZQlZEVThtWGxzNTJtUTZzYWlOcHYw?=
 =?utf-8?B?WS9hNFVJdnpuQjJoaWJSR3NNcGtuSWQ1SGFqYkFKL3hQUWE5MGd2VFJGdUNU?=
 =?utf-8?B?N3BMNnp4dUpuTHk5RjBURGVvaU54TVF5Si95Q2FFdlpyVWUrQkoyd2MyTHR0?=
 =?utf-8?B?VE10cnB4c2h4WVhIQ0c2dW9FTklMeEFPMkNXNGkrNjg5Tlc5d0NpbS9LaGho?=
 =?utf-8?B?c3BITkFEZDE0UURuenNMNFNYVDNnYTA0Z3lhcHdBWjFDdHc3bVE1QVpscnRD?=
 =?utf-8?B?K29BZVFNUjVCa1pBQnhXRkFFU0pURFpFZldDZnJLa1diMGxVaFgrK2lmbDlF?=
 =?utf-8?B?VTdsWFcxVzBRM1dlNTg4MjJZSHQ1TlFqNDFHWGVnS2c2bTJBTnpFa2FhN21M?=
 =?utf-8?B?Wk9xZFlDcHdvNWFpeTh5YlUvREZMSHpwMGxFNHU2czdxdk9YZHBYRlFuWW9C?=
 =?utf-8?B?TzhlaThwMVhIU1MveUFVbU10U2pwVkhhQWRMN0dCRUM2TnRPNzZaYjNrNjJO?=
 =?utf-8?B?TndzVkN1Y0kyUklYTTBhSWNlNEJHaStScTdPSGl6a2NaNmhFdUY2cVRWczlC?=
 =?utf-8?B?dGh2aVhGckpneGJQZEZGTENWME80b2hNRllQTlVIekxJUC9POGlncEduSEEx?=
 =?utf-8?B?akR1UXdxNW1lMlV2Z3NyUDdIaTdMd1VnV3ZSOFYydHdqNGUyVlhXWTJKWWM0?=
 =?utf-8?B?M0dReE1kVUFkRjdhYnI4VVUvRWdPUE9GVXRmN09mVy9ydktGVmhwU1pEQnFQ?=
 =?utf-8?B?ZmJmSVNCU1dQTFh5ZSt3Um80aCtVTmQvQjRQelhQRGl5MkxWaXFsTEtMMlBM?=
 =?utf-8?B?MUxrbjV5blBRRkRDOFVPLzIvc3RjLzdGVE9uaEhPWEFLWnJWOHRST0gvZ05Y?=
 =?utf-8?B?RXp1T3ZwTk5QU3pEUWMvSXR3UnRvdk1mcmNiVHQySHB4bHczWnYzUTJrU1gw?=
 =?utf-8?B?VFpFVDdVZ2pNOEVJcDRnN2NMMHk3Ky8xclJNOXZJSTJpT1VBbFBzNm9WbzlZ?=
 =?utf-8?B?ME1Nbk5UaHFnUE1hL0JzSXdZWlNoMmdIVzN2TUxIWm5aVU9HUTdLQW9QdUdR?=
 =?utf-8?B?VGl0R1lvVGVmR1RTQitRUU5LeUxwQU82N0VTaG1ySG83T28zc0o3YTBSQU1V?=
 =?utf-8?B?ZnZvcFBDb09OUUZtREthdW02UHZGSFEvZjZHUVFpUkNpOHNuYkZOMHJmLzVG?=
 =?utf-8?B?ZHFTMzhuMWZ4K1VEb0YvRzBoMU43MkJSZytvV1o4YUZWamNyRkU4SlVvUnZv?=
 =?utf-8?B?STRXV3BIWWd5YjE0NXJyZFk0VXRueG5EWE5XMXF6aFRFanBZNHBWNmNNY3JH?=
 =?utf-8?B?MmhLMU1jSW1UOGsxbzhxWENMTjJSOFpLc3Z2U1VRcE9tOWloazlVelB2blFP?=
 =?utf-8?B?WUFhdFlKZnRPWWhpK0FudFhFdCswTWU0bWFzZHJrVm5OOERGL2JhS0dVcXcv?=
 =?utf-8?B?S3YrL21EbkYyZzROQU9QaE00OWFwZk43Y1g2NDhBYkNrU3QwSEs4Y3pUdUVi?=
 =?utf-8?B?NGxyTmxXb21nZ1dzWXBSZ3NXWTlMdkpScmFIVWdlc2l0RGQ5c2R0blZqMDFw?=
 =?utf-8?B?TmNFa2lxNEx1djBTMnlzK1d1b1djSlIzOGM0VzNYZzQ1ck53azI5Slg4Tzht?=
 =?utf-8?B?VEpaUXk5RzVEbnFCQlliQ1RidGlQS3ZJV3VaQ3h4dkZKbFJxeVRidTlWcnZl?=
 =?utf-8?B?VUl6am1lOWFvTjR1Ym1pZHB5eEIyYTNCS2FZVFdFWUd6MHl5R1A2b3hhMnYr?=
 =?utf-8?B?R3kxWDBNSFhsd3g4TnkrZ3JhQmcwYnpwdHIyUzg4MExQak15OUd0ZEloWDlC?=
 =?utf-8?B?MWhtY2NuOXpQR1hCWVQ0emliMGQzYjk1UHVNcWZxR0J2ZDhiWUNvRmxzbTNF?=
 =?utf-8?B?UEpGSjVEenBLRks2NkFHYW5FbWZyRitWTEhxSk9NN2RJUWU3dVptNDJOU2V2?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b06403b-c83a-47a0-f892-08dc7684ba6e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 15:19:21.7673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6F0T2whEtapeccaloX0OBFS+7vxMJFaPmAulUNgerypjWizGlG2kA8Cblc651ug1RWTX5A+ejjkspENJFaDH5DN62dDLPKxj3IAV66QQFic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8422
X-OriginatorOrg: intel.com

From: Florian Fainelli <florian.fainelli@broadcom.com>
Date: Thu, 16 May 2024 09:56:30 -0700

> Stephen reported that he was unable to get the dsa_loop driver to get
> probed, and the reason ended up being because he had CONFIG_FIXED_PHY=y
> in his kernel configuration. As Masahiro explained it:
> 
>   "obj-m += dsa/" means everything under dsa/ must be modular.
> 
>   If there is a built-in object under dsa/ with CONFIG_NET_DSA=m,
>   you cannot do  "obj-$(CONFIG_NET_DSA) += dsa/".
> 
>   You need to change it back to "obj-y += dsa/".
> 
> This was the case here whereby CONFIG_NET_DSA=m, and so the
> obj-$(CONFIG_FIXED_PHY) += dsa_loop_bdinfo.o rule is not executed and
> the DSA loop mdio_board info structure is not registered with the
> kernel, and eventually the device is simply not found.
> 
> To preserve the intention of the original commit of limiting the amount
> of folder descending, conditionally descend into drivers/net/dsa when
> CONFIG_NET_DSA is enabled.
> 
> Fixes: 227d72063fcc ("dsa: simplify Kconfig symbols and dependencies")
> Reported-by: Stephen Langstaff <stephenlangstaff1@gmail.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
> Changes in v2:
> 
> - conditionally descend into the dsa folder based upon CONFIG_NET_DSA
> - change subject a bit to reflect the change
> 
>  drivers/net/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index 9c053673d6b2..13743d0e83b5 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -49,7 +49,9 @@ obj-$(CONFIG_MHI_NET) += mhi_net.o
>  obj-$(CONFIG_ARCNET) += arcnet/
>  obj-$(CONFIG_CAIF) += caif/
>  obj-$(CONFIG_CAN) += can/
> -obj-$(CONFIG_NET_DSA) += dsa/
> +ifdef CONFIG_NET_DSA
> +obj-y += dsa/
> +endif
>  obj-$(CONFIG_ETHERNET) += ethernet/
>  obj-$(CONFIG_FDDI) += fddi/
>  obj-$(CONFIG_HIPPI) += hippi/

Thanks,
Olek

