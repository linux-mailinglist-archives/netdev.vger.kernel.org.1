Return-Path: <netdev+bounces-153268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E59859F77DF
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DDB16AFAA
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B89921639E;
	Thu, 19 Dec 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ee8O62cu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842B622144E
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734598847; cv=fail; b=ac53fbb40p+Ia1D0IyrKd3UsvuYYeEa89ckNfSoM0RNTWAaJgIGjTM8vMXVL+PWFkV1qXTNDnTpNXrOC54e4K7aG3OMOu1giqcf9kwhi+j8o74nwb34Y3SgxVeC0eO99tzf4SGqQi2dBpN8fMRdaBbPKfWuXoZ3miI2dbMWhbXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734598847; c=relaxed/simple;
	bh=F+FYsXC3+A2chpM5gNVphjKXwJBGlNzhe7Yix0SOckc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CPAKu5Qz2keYWMJG/zDCJ4ht+rNSKGV4c6w8SiKV0YV8M94LlRHGqrDPktOfDOWNCCW7yQNA5pTiZZTY5IwznkH8oP7FXM9+suM5MzQGr86xzbE5LCYKfM++Ayf4yh4SKbvLQcdfDQPiIsM1fYjIoeTcDR48OF72ztRJSukadHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ee8O62cu; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734598845; x=1766134845;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F+FYsXC3+A2chpM5gNVphjKXwJBGlNzhe7Yix0SOckc=;
  b=Ee8O62cuymv9sHDRZeZFG7c0rcWGvs//Etwumm91StElMJs7NxuaWSHc
   ISWSRUK6jUVqiJ/jUb9y0DJfvUuP9T1FbqTUX97h+qsKtsQWj3N2Gcq52
   XnLKWxZZIlj28BLQo7RvsoJF+tf+6LHYwEe6Yqm5JcrBqQAHlzu7CBWK7
   c9tc5p3NgptjXCN+QjAI9cumBHoxUV9UpB6S2h446Qryp1VdQoff8bhHy
   6RSkFy+1c3hXvFTqsTrwv7udWnbtc8sJllRmO/4yXjn0+JopKbOaAoCWF
   e3ALrUwoPWOfjtec9Pz6uRGgjmjkZccqq47y/+pEuugw0Y3HcPLcw5EgG
   w==;
X-CSE-ConnectionGUID: lfFBs5WzTGaECzPRoUxRbQ==
X-CSE-MsgGUID: yVxEnCg4TWKRQg/Fkeu9vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46518231"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46518231"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 01:00:42 -0800
X-CSE-ConnectionGUID: Rp08vMnmR6uU489hTbmEog==
X-CSE-MsgGUID: Oa/xgc6lRN+l7nD91gUulQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="97927241"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 01:00:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 01:00:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 01:00:33 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 01:00:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xj+AmI/L1qB9aQcl9QsC9+xhxzQ+j7VaWn1etGoAWnNwuXddxTCjLPRo53tZu3POewB1b/bBMeJP7s+39o6cZ/11lKyy1NPOY2edxTYVikrc8HEcpguQ2NLKeikzIY391Ur7ZWZMG9loBLtCejawVPa2nfSIaEau5i6JoNnbg9x3E1HmJ5rRsryc6ZDHTb85uga6VqRCO6rAPjp/dbulUf0/9jfTEFoVhc8OAluTfQZJjAUGPL1zwwa8dPzVP4TLBj7aHZjdzZIYMENdh5dCCwaJCmq/VSjpiNH7APpisgtre9+q+7hbUdBbPY4uZOs2m4l6HcVY4zCtq5EwNbeTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l70XbZ1O0VzHxatGDEQMxoufJSpVt9nyFtawvBuuTCc=;
 b=S3xs4aNmscnHFgMvg8XqlplRqS/imCpB2FSW/pJZ9XE7Ose9qRajjQo8MlX04CyNXptio64nP8s53b6TOGxpgV1vyYReSbx/8F4uT29J+sIfv7SJfX6PdwUwSY0rrz6zLCH82yCKimpxrshAcX+AVP1Szhf+7nKQhBkTy7fNKLl5poxlbVowL0VoVjCAdYrLhmYE8BAoeDq4o3a4bTyivTaYhzdt79BKWdY05TMTgfi+dcsWgAkP4jZ+0N41Zranfv8B7YDMyu7YJDTBHpRcl7n1JQHnIGHzfsfMa753Mlb39AW9uSkz562NH/91RgVonQt5IyxgfPaN8ZknrxMLQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by LV3PR11MB8532.namprd11.prod.outlook.com (2603:10b6:408:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 09:00:22 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 09:00:22 +0000
Message-ID: <015ad3e1-9526-4d40-af4e-ff852d9dd117@intel.com>
Date: Thu, 19 Dec 2024 10:00:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 03/11] net/mlx5: fs, add counter object to
 flow destination
To: Tariq Toukan <tariqt@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>
References: <20241218150949.1037752-1-tariqt@nvidia.com>
 <20241218150949.1037752-4-tariqt@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241218150949.1037752-4-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0171.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::9) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|LV3PR11MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f78436d-f488-4332-7b7b-08dd200b91e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDJMTXlzL1RNU1hFblV3ckVYM01CLzBQRFhsR3RpdjhCOHVFSUJ0VWpPV21J?=
 =?utf-8?B?eHhjSnU5a1JiL2NnQ2xkNlpSMTQ3NWk4SmVFM003Y0pRQ2g3SnZxRk83RVNJ?=
 =?utf-8?B?VG52WFB2WFhDd0RBWmtxRTZLdE1ZNk1leWU5NHdaOGRjV2lWOXlNaTZXUm54?=
 =?utf-8?B?Y3JBbW1TNVVwVmFrdmhTNDV4WjRVK0RjQnBsMGo3ejZ0WGkxYzJHSlJjMDE0?=
 =?utf-8?B?OHhlWHdYekp3STBYL1ZUdGpIZWphdVJvbnNjUnNOdnlyRElucFpEZkhDZEph?=
 =?utf-8?B?NFZkMHNzQk5VQ3o0aXRDbVlzcm01OGR6eVBqTEFYd3hBWTdzamtnMk0rYXlj?=
 =?utf-8?B?SDNic09UU1B3V3E4akgrYWVwVHp2dTRQY3FSY2VnRmp0cSs5N211OVZ2S1A0?=
 =?utf-8?B?cWFtcW1ZelNjLzBQNWxVOG92QUlrSHNPM3FCM09XYWhCbHlVN1h6M1hxTTMw?=
 =?utf-8?B?ODg3bmRGendxSHJreEtBRlg5cER4VU52bGM1b3N2akREZVVja2s5elhxZTlI?=
 =?utf-8?B?L1RJdHFoTUJhMDR2VWpMNlpiNmtDaFRZWE5GMitMeFRHZCtGWW15QzFVQU5P?=
 =?utf-8?B?L0VIR3drUDN1eFI5blVReGZqQk5rV1JlUFB3K29YQzJibWdRZ0lnaE9EZmdm?=
 =?utf-8?B?N2lHTGtQQ2lqMVQ4Zko2WHBrbSsxeXZDRGdwYnBXbkxheis3RzdDc0xCdTJq?=
 =?utf-8?B?U01WeWUya0xqMk1JVDh1ZXBWWDJlYUd2MWlTZjdIQkFQdGVIRFZqZDJvOFRO?=
 =?utf-8?B?aUM3eHl0bnZ5QkE5dEx0SzB4L1J2V1ljLzk0YnNleStCVGhXWngyQ3ptbnMw?=
 =?utf-8?B?QXNlSjNYL1g5eUdkNzRaMm90Y3E2MUFVQUg5NkNLM1Zaa0haZ05yWkZEbVZ3?=
 =?utf-8?B?SVovU1pPbkVpQTVsVnV6M0FRd1dNZ1hjNnRSc28rR3hOQUFmYmpxSTg0dFFB?=
 =?utf-8?B?dWkrV0oxSWFqdTRCMjFPOGpyNWZLdzBRWENjaTlwSFZpOFlGakF3eE1aV012?=
 =?utf-8?B?alRYUXBacTJFMEtqNi9qS2t6ZlBUcyttak1RVkVaNHVYbVpNa1dyZDkvNERC?=
 =?utf-8?B?c3F5QStzQThUT0o1TkZ5Z0RuZGxjZ2dZai9yUEgxTmNEZDF5UWpvZ0sxV1VZ?=
 =?utf-8?B?NDdwSnRSTjBjc1NZNTNnSzFYY1JTeHdHcTMwZUFGNjNhaVBFdFk3YzFUdndi?=
 =?utf-8?B?WjNIRlpJZXpLanZiQnBkaGVZZWM4Z0hXRkMwNjJac1BSaTFYZ0xHTVZMN3dr?=
 =?utf-8?B?aEZxZjBYeFNRZmVrblV1WjRERjlFdlN5SHQxNDEzOGNlMjFTblFpd2tMcEgy?=
 =?utf-8?B?bUR3SEZSMUV1MkdVV3ZnaEJRTjNrb1FkdUMrZXV2Zit5OUFFRlAwVE5BR01Q?=
 =?utf-8?B?ZzZZZmNtOGFkbngwWWsrQW9jZXVEQVhHMjYweXJlQjU4ZmhZYkMydlZkUFk4?=
 =?utf-8?B?MVJHa3psNS9kOUJtdUVyenN0M3FEVW8yVE8vekhyM3JkakYwdHNVWENIVVRN?=
 =?utf-8?B?Wlc4a0VQLzNhMDBjbW1IY3JobmE5eGZuV2VjRkxEaTBTTXZlZWd2OU1jQTBi?=
 =?utf-8?B?OW9OK0tjRFpZTUxrbHpVN3Y2ZEI3NGZGK2xhS0xmRXFYUUZKUFJoaWF0ZVF6?=
 =?utf-8?B?dmJvS2V6S2pZVG9TUyt0a2pwRVh0TGRqZmgvOGtiYU1pdnBFeFZUc0dpKzBG?=
 =?utf-8?B?aXgycnhtQktXUUJHOEl6bmpQSnl5TTYvK0k0QVhUNVBXZ0tVL3NON2diTElZ?=
 =?utf-8?B?NG9hMjFWdjNLQVl3MmJPWlpEaGZqcGltMkV4MVBDTWNabFA3WEE2enZVNnN0?=
 =?utf-8?B?TGR2Sjl3THBWbXpaRURDTklucGh6MzFZNzE3bFB3K1FBQWdNWjhGTVpEZnZv?=
 =?utf-8?Q?fAhv8SDk0w1/a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWd6N1lBUHJlRDJsdkxUdFVSY3M1TS8zc3BnZHdzUmJFSk1tdm5pa0Mrc1hN?=
 =?utf-8?B?RkROSUZuZmFieW9jd1RUSS9McitxeUVtUnU3SENvTDlSbkxWeTRVK3hPc0Fs?=
 =?utf-8?B?a2NFZDRNcThYRHJVU0VwSXpITjFqaDFha0hCNFg4VERlZlhuall3dG9WM0w5?=
 =?utf-8?B?eG9jMC85cm43eVFMWCtsYWFLdzRDODgyMDBrN3liSERWaHNCMDY2SGxNMTBV?=
 =?utf-8?B?NnpneFhsRGZoaFl4M3dOdXYyTm5KVTd0cS9XVnNNQVg4aWVCb0h0SFM2Y3Nm?=
 =?utf-8?B?VFNSOWJPWTVwc1VnQUZvN3dMREZXUTNmRGlhS1lrR1NnVFoyVDVzd09NVDBx?=
 =?utf-8?B?bW1aLzRIUVA5NVFNanBEWlVJdW1hZ1ZRNHFIeGZ4VG1nN3grTnpwaW1WeFNh?=
 =?utf-8?B?VE9MUzhSZUJ4MjRDcFBPU1Y2QTNEYjZ1WXRUcmNNUUpKWWk5MEpXYVdwTmRn?=
 =?utf-8?B?NW1vcFk0UDQ4cE4vemVmUkJUTGdYdjk1STZob3JxRDJJQ3VERGcxcWVzcWRN?=
 =?utf-8?B?Y0R4U1B6RFozc1FlSk41ZktHajQwOWE0eHpEMCtkY3M3SEE5TUNZYWF5Uzg1?=
 =?utf-8?B?N3d0U3pwRy9odzRvdHh0Z284WGtOZnVGVEVUWnF1UGNLUnNGSldHRVRUeXVS?=
 =?utf-8?B?L0dyZVIrVW5LSFdHaHAwUE82cUtGdHN0TjhyVTJEZUpxR3RRckdpdHVNQks1?=
 =?utf-8?B?cVJvczcxUG5tbWRETFduNVdUTm5Sck1aVHFJZXpPTlZYVmk2QnRBQ2NtUUgw?=
 =?utf-8?B?OGRUdnp4b2JPZlhjTktxT3Z0OWhVM0dSTmtZbGZhTzBoUXNIRng4emwzd0xR?=
 =?utf-8?B?OG1TMzRmQ05TSjJQTS9JSnhnOHhpNHYrZ3dReW9IR3Nqbkx6Qm1uSGs1MVdr?=
 =?utf-8?B?M2V1T29aVzlWOFJYSEtSTnMzUjMyVHNMd3JOaFVYQk1pdUpsR0hBN2RvTTly?=
 =?utf-8?B?OVBTcWZmeGpUaDRXenh0MEt3QzVadlIwQUhFRXVQVnBjUEtRVFdWcTBCUHBU?=
 =?utf-8?B?S0RqOE44RmRDdnNnNGhOdnRLSjRlUUg3dTJTbmdlKzlMZlpDb0VJTHdsOEdP?=
 =?utf-8?B?L3dzeW1jVTlRMlRBbFo1SnpxeWlVOU9ETm1MUEtQSnVPdUNoMXc5ZW9XVFpH?=
 =?utf-8?B?UXZGaGF6UXR3Yks1RUVvZVQwd3JHTWpnK0FDQURraDVtYmc1b3p1ZXBMeis0?=
 =?utf-8?B?ZXlseks5N0JwVVRUZkljdWhDQnVET3lGb2puZXc0Qk9nSkdSRGtEM0FmWDE3?=
 =?utf-8?B?dVBvNnoyOCtrY01HRXBXaVMyOEUyakR4dGgxcW5xMXZrZUpnVkNCSWlmTTla?=
 =?utf-8?B?VmR0YkVpTnNPbTFvL0hYNnYwQnJzalNMODFmdjdKMWw2ZFp2RTNUQnF1T0wz?=
 =?utf-8?B?UytCWkZPTlZhOW01bXFSSWJZcENIZjJHMU5UTFFrT255b045eDZDTENyazlP?=
 =?utf-8?B?dEZJRXZhWXBBTWhMTXI3QllkRzQ3N29zKzc0b2g3d2dYNWxCV0tpL0dUVS9h?=
 =?utf-8?B?VUdlZUQyOGdtcEJHci9helBYSXBXR1ZwcGpUYmw3VTdXa1ZVOHRsV0E2UVFq?=
 =?utf-8?B?b0pLZ0xGcXFjQnJrTGZDT2JTdWxlelZ3c21JVFBlYXR2eGtyMmdtazBDbkEr?=
 =?utf-8?B?eUdFaXFaREhnTzI2SVVtbXk1cFNOUTlxSVpQWHpwRk5tdmZDZHVuL1A3b2h4?=
 =?utf-8?B?L1hxSGdPNlpwcG1wSUp6dzZzSCszYmY5eW13TkNHUUZZVTE2RHVTTDg4QVdQ?=
 =?utf-8?B?L29GYStFb1gyQWhPQUtsM1N3NFJXL3lQT2RvZHgyc3Vqci9GN1ZISTI5cEJh?=
 =?utf-8?B?ZmhDWDZEUnF0L1p0RXFwWnN1alBsMjJLcWJ2SHpsMkg3WjBsb3BmcnhlZExS?=
 =?utf-8?B?ZlorZFQ2bDJqQUVqN0k3UkluUWo3WGF3dWxnMFp4Qm5yWEJuQldJZEJHZkUw?=
 =?utf-8?B?Z0xNRkFoQVZiWEFHN1QzY0xnOHJzaVJacXFpb3FsZ0o3Ui94R3BHcnFEWE14?=
 =?utf-8?B?NFRzencxRVhidU12RGF4QnZyYWxja3N6Z2pjY3lISUw2VDhwbDBJTkFyaEM5?=
 =?utf-8?B?M2lIKzVseTZTWnlyM3JHNzBzVUJ3YW91VjJGc0ZuVjdQUHJaZ3JxU2U2Vm4w?=
 =?utf-8?B?VmFDT2dCUmlZSWNXS0o4T0pJNjRBcjl1Qk01ZnhudGtWbkxud0NxaWJSUmNP?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f78436d-f488-4332-7b7b-08dd200b91e5
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 09:00:22.1922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhmDnrdynAqPDdvk0Nq7k6uKu3e9QwsC2gtTr+5WQN1XoIBoiLXs3Qzh705XpNDZnaCa6+UEK88wOPCKb4KJLLsT916/M1nt+4m50UK+isc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8532
X-OriginatorOrg: intel.com

On 12/18/24 16:09, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Currently mlx5_flow_destination includes counter_id which is assigned in
> case we use flow counter on the flow steering rule. However, counter_id
> is not enough data in case of using HW Steering. Thus, have mlx5_fc
> object as part of mlx5_flow_destination instead of counter_id and assign
> it where needed.
> 
> In case counter_id is received from user space, create a local counter
> object to represent it.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   drivers/infiniband/hw/mlx5/fs.c               | 37 +++++++++----
>   .../mellanox/mlx5/core/diag/fs_tracepoint.h   |  2 +-
>   .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 20 +++----
>   .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  2 +-
>   .../mellanox/mlx5/core/esw/acl/egress_lgcy.c  |  2 +-
>   .../mellanox/mlx5/core/esw/acl/ingress_lgcy.c |  2 +-
>   .../ethernet/mellanox/mlx5/core/esw/bridge.c  | 20 +++----
>   .../mellanox/mlx5/core/eswitch_offloads.c     |  2 +-
>   .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |  2 +-
>   .../net/ethernet/mellanox/mlx5/core/fs_core.c |  1 +
>   .../ethernet/mellanox/mlx5/core/fs_counters.c | 52 +++++++++++++++++++
>   .../mellanox/mlx5/core/lib/macsec_fs.c        |  8 +--
>   .../mellanox/mlx5/core/steering/sws/fs_dr.c   |  2 +-
>   drivers/vdpa/mlx5/net/mlx5_vnet.c             |  4 +-
>   include/linux/mlx5/fs.h                       |  4 +-
>   15 files changed, 116 insertions(+), 44 deletions(-)



> +/**
> + * mlx5_fc_local_create - Allocate mlx5_fc struct for a counter which
> + * was already acquired using its counter id and bulk data.
> + *
> + * @counter_id: counter acquired counter id
> + * @offset: counter offset from bulk base
> + * @bulk_size: counter's bulk size as was allocated
> + *
> + * Return: Pointer to mlx5_fc on success, ERR_PTR otherwise.
> + */
> +struct mlx5_fc *
> +mlx5_fc_local_create(u32 counter_id, u32 offset, u32 bulk_size)
> +{
> +	struct mlx5_fc_bulk *bulk;
> +	struct mlx5_fc *counter;
> +
> +	counter = kzalloc(sizeof(*counter), GFP_KERNEL);
> +	if (!counter)
> +		return ERR_PTR(-ENOMEM);
> +	bulk = kzalloc(sizeof(*bulk), GFP_KERNEL);
> +	if (!bulk) {
> +		kfree(counter);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +

I would expect to have following line added here:

	counter->bulk = bulk;

otherwise that is memleak?

> +	counter->type = MLX5_FC_TYPE_LOCAL;
> +	counter->id = counter_id;
> +	bulk->base_id = counter_id - offset;
> +	bulk->bulk_len = bulk_size;
> +	return counter;
> +}
> +EXPORT_SYMBOL(mlx5_fc_local_create);
> +
> +void mlx5_fc_local_destroy(struct mlx5_fc *counter)
> +{
> +	if (!counter || counter->type != MLX5_FC_TYPE_LOCAL)
> +		return;
> +
> +	kfree(counter->bulk);

in the whole patch there is no "->bulk ="
you didn't catched that as it's fine to kfree(NULL) of course

> +	kfree(counter);
> +}
> +EXPORT_SYMBOL(mlx5_fc_local_destroy);

