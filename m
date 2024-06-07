Return-Path: <netdev+bounces-101793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC019001AB
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F6B1C21C3F
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC40E18732F;
	Fri,  7 Jun 2024 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdFDNa0D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029E12FB01
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758650; cv=fail; b=BAhmCCUlk453xHld/ZWFczUXQnfoKxkeJEvfW1e0cEv5IrQmLqgRbQux/rE7Zu5tSeQa9yBnIc5eygYrK31zRkkzzTj6esrGWOFfiZVelxdQYeiLLRJbGn65CqyoXdfJLB2KzpFJ4wXs3fhFRuZL1tvueLpKlC6eLDAdoPW4EiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758650; c=relaxed/simple;
	bh=KSY3iK4Dz0li9Dh5vKztVEoudPUk3dMLeqze4wKSAGg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DftYBuV3x8AiLTARTaDx5JDRv1auTlG39pQNFH4iW2zYjYw35p8fHCIqEfsClwsDhY4J4FVF+IwlJ5teA//ruanwSdey+IFN6KvYzSIStl/Od7tmvK3RxWJkFKyM0w0qnW8XPLIdvdqiudP2RTlq9l9YjyzikTnCaGRTrleonFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdFDNa0D; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717758649; x=1749294649;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KSY3iK4Dz0li9Dh5vKztVEoudPUk3dMLeqze4wKSAGg=;
  b=UdFDNa0DRFvpnzae5OTZFPFUnX+LgJx5sV2WsSN4mji2ASmOoXLOox1I
   YnsgRBRaq09fC8OfCXy0QiCr96ZRVyxtKUcjVD/5V3yEfbYIZb1IQJdfy
   WU07aGVtpNIhYlT+mo3/iaFckiNZ1yRD01EGGOPU48WrUEKc04VoY3bLT
   fTyXfksQIQEn/7pyzQTlGtBVA0L/5LLA27c0c45oT7y/ylGmtZjALMQ7T
   pJw+0dSEZObofCNrMFN7Q6fcxEdhFuvXYJoXIO127elGNV/pDnf9pXnOW
   b8B2I/PNoqP2OxKSMp2mZy4BoKH4RT5FP7xJuAwoAO9/VezXGvzPuF0DV
   w==;
X-CSE-ConnectionGUID: 1zcUtte7QVakq5xFVkWnvw==
X-CSE-MsgGUID: Zf/jXCY8SQuh8hZCROojkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25102245"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="25102245"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 04:10:48 -0700
X-CSE-ConnectionGUID: EmnW26VvSk+Nj2vRJk8MFA==
X-CSE-MsgGUID: X1MzklJRQK+jQqHbuHRK4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="42751885"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2024 04:10:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 04:10:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 04:10:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 7 Jun 2024 04:10:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 04:10:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOlmWa+p51GH0zvWVkt4UrUQpGORPzjN4TJQbxyTrRslNE0IaE6QIoPzWLC5kbO1FUOlAUWFXYaPEwYQ7LFGIf1GL2aMKv/ayLRPCv6HtJi4k78qV2qhjZ8fwyDuUiqJWl0lGoFuo51WBKhU7N+vCPGyjrUprAyhuKqN/I/tQSwa2BzVl2Y1aHmiAvZ2AVmbnidnfI8+oYYMX2UNUvTk9ARt9Kqs4w4rR6GYLrMhiQQBaDWLcPPLGJlW7pP2iMu+oGVwANycNa2rTZKmhbJg/mrApSK42+/2xpCc+O65IwVECsjymIUDrsgYQ4Y8420N/oa8npd1moT8bl6bROMCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjEd3y2nKTBv72v6mBBnDRt9WIwacWh3vT1uZg63ALc=;
 b=b4r+I+ZM2TF3AuaKwQm3Kt/zT+xs2mBgw/WtHzkBBQrANhsp1TCsy6NRQCFXEycYNlGYTDvEO11qaQ/pm5XXtNdYFf/vditnwB0jtSaVF6fj6LyKgSTU++MNV3pS5ATXHFqG4F46fx/7a/2l5TkAiT3GrvYgeh/dLi40AcxH0/jcH1QRvxKM0B6UnQteAFPGQ1RFe8NBZBwgXFplgFVRQWHnyWjkg2Vgric7N8TXiH7ksAmkArl8rz5jnonfF5Ev2L25SCtTjqVvjbeiKnGZNHAsR+ZabA/0dJG/A7f3k/QQd66uU/wNPUfZN3fF+PyKoc9ShCaB2mGezm2BZMQMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MW3PR11MB4633.namprd11.prod.outlook.com (2603:10b6:303:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Fri, 7 Jun
 2024 11:10:45 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 11:10:45 +0000
Message-ID: <93204731-2900-4297-9204-f4dfd6c41ab6@intel.com>
Date: Fri, 7 Jun 2024 13:10:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] geneve: Fix incorrect inner network header offset
 when innerprotoinherit is set
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
References: <20240606203249.1054066-1-tariqt@nvidia.com>
 <20240606203249.1054066-2-tariqt@nvidia.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240606203249.1054066-2-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0048.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::17) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MW3PR11MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c2e879-8924-4d29-7ce2-08dc86e27a12
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzBTTms1T1RiYnJYSGIvNmJna3ZkMEFrMDBsVFErSnE2VmF3dGMyMHBxdXFy?=
 =?utf-8?B?ZHpaaTJML3E5U0tMYU9aZm9lbHkyV2g3QzdkMUFNVUM0cmU1RmwwZ2N1UU1H?=
 =?utf-8?B?Rkt4U2pLbGpIUStTakxGMThMZUZRQm9UcEh2UmF2TXU1OEdUeXgxRUwxaHhF?=
 =?utf-8?B?eUQ2K05QUXZJbzNmY2xvUVo2UE1ydzNUZ2RURkVhN2ljMkdxTkFucU5MVisy?=
 =?utf-8?B?SzZYZHUyR09HT2RQSmNTQkRLckhHQ25OdmlONVZBQWRMUzJtNmYxd3lla3Vn?=
 =?utf-8?B?ZXNnNzV1Z2NnMmcrUk1SR3JvYndsTUdrNzVvRnd2R2RnME9COE92S3RRSjVM?=
 =?utf-8?B?YURuZStadE5vbWNwQ1F5UUxpd1JpL2c1U2VBeWZXTGsralNyQmtBYUUwQkFq?=
 =?utf-8?B?R2NlNkE5TWUrOXhJZ09nZ3FHRkxpSXREcnZRU3V4TGMzSlBhTFNTTTk5YmI4?=
 =?utf-8?B?NDJzcnZjTVlleTN6aGppZVBGc3dNSkNIWlpLNkFRUE9weURZN09FUkVMU0NY?=
 =?utf-8?B?VVZTMU5BSlZWcmZuUXlwdHllK0JZc0dEZjBhbGZsWGpSYnFXRFdMaklWUks2?=
 =?utf-8?B?dWRaMGpKbTl3N1UvUlBiT0JvNEgreHU0ei9YK0NPS0NKN0EyekNEbG9qR2Vo?=
 =?utf-8?B?SzNkc09jVzEyTHlDVGpjQm0xZzV3aXFjNjIxcVRORmxUVnJDWk8rbDdYUjkw?=
 =?utf-8?B?eUk1YnY5ZWxBdTI0eTVobVZEb00weS9NL0ZOelo3NkdGMFNldE5ZQXhVU2Ro?=
 =?utf-8?B?UmxyTlpYcmd5blpDVzVUcXZRUE01YS9GRXArRW1UcVMxLzdvbW5sZ3hoY0Qr?=
 =?utf-8?B?czkzRVJNQjkzUTdYeHpmcVZ4YVBRcmVCSnViTk9seEZweWN6Z2lNQ3BiSFpC?=
 =?utf-8?B?SEFRa2xQTFZxREpXZ3E0ek5KMndJVHFldmlRL0VnbHh6dktFWkFhT1l6UmRY?=
 =?utf-8?B?UEFsQnIzdS8yWWQ1VG1YOEZJQVpMT0tycmdTeU9MNzNia0phTjBZZnlVOERY?=
 =?utf-8?B?Y3lmRFNkTFhzMzRsb0V2QnVMMUhDNWcxcjZlY1FKMlR6MDBRck1EWFBqSDF5?=
 =?utf-8?B?KzdaMjYwZVZqTWpJL2VLa3NMbFNNSXFHSWwzbmlPai9FZDJEMjVzS1dkR3V1?=
 =?utf-8?B?VU1wT1BVdnJDRzhRSzFlY0R3SjNXZ2FFczZmZ2ZuRVhkaEpEZ25hWEJMejhZ?=
 =?utf-8?B?Qi9lcnVoSm85bm5WYjRJcG96NnJRYlBHQ1QzZGRVN1Q3L2xIZXUxaFJnYklO?=
 =?utf-8?B?cUx5Ym50dWhONUtkeTcxMHJKYzlaR0J4MDJ2OFRyRjlQV0N5VlRrbCs0cW5v?=
 =?utf-8?B?WWtZb0xYSVJLaHRBL0JlaFVrUUV1ZU9Ub3piRWJuYW9TSVdjRmN6MGl1YmFt?=
 =?utf-8?B?QVF5MVlZTVRhRkgyMU5IOURHMGFzWlMvd0lBWFkybXNoSEk1aGNoaHRNU2o0?=
 =?utf-8?B?R2dBeVRJODdBSmZzSEkwYWQ3cC95bm1TOGUyUTFlaExxc3Y3V2IwMWJOeTYy?=
 =?utf-8?B?Q3VNMVRBaUZhR3hNMHFocU8ya2RoRmkvVU9mUXlUVXhYSElsS1JYUzAyY3U2?=
 =?utf-8?B?ekRSK1JacEEydkFwNUk3UTZYZVNUN0hNTGUvb2U3TUxQZGRrSXNKRmhmMEM0?=
 =?utf-8?B?c2dTZDVrbW5JRjhUR1Erelo4T1ZhQnhROWJUUGZKSjZYRmJSV0h6a1FTR28z?=
 =?utf-8?B?UmRGVTl6Z0ZEOWZuRWlsTW5SckhFaFNLcWZsNzBTbUdrMzVXMlpCU0RsUi9H?=
 =?utf-8?Q?1u2HrGAv5vgC4koO8ajOtmykKrTy00WYWTAH6vE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnhNRmxjMnJlUWMwM3pMZXdqZU96ajJJdFJaQVl6ZHN4TkhJWmRVNjYrck1l?=
 =?utf-8?B?S0Q3UU0wVGcvWS83RE1mWmJFZnYrZTRuMG05dGZkVDQ2SjNPYXAyb2w1SlhF?=
 =?utf-8?B?dlN2SzJnb0tFUDdxcVBZUFZsUDI4UWpsRVNHaUFqeDNnNysyZVdCWnFtOFND?=
 =?utf-8?B?eGJWTnI2WGE3NWVDTm1pRURjNTJ6bVdXaVdUN3BQZThXaHZPSFU5Njk3a1d5?=
 =?utf-8?B?bWZ6TFZhZDlMWGY1MTVmWXR0NXZ2UVZLWlpPQnp6Nnh2Ynp5MUFydjUrcWZn?=
 =?utf-8?B?WTBrNi9TRWxuWkFOMEFMU1hhTW5NMnNlSUZ2OUNQclE5N0NybmVEd3puMkNs?=
 =?utf-8?B?RWIzNFo3ZStjOW4zVmcxRlpsWEJOWlFmV3VZcWRjWFhvUGQ2bVMxS0JlaUM0?=
 =?utf-8?B?S2wrd3hpNlZrL0k2clhHS2xYWmVWSENuR3RraTQ4eXJqQjQ1QUd5M1ppdkV4?=
 =?utf-8?B?ZUQzazIwTzdFN1R3cVBsb2kwbHVPcUpUNDQwM1RnWWVuWkx0OStjZ0NpRytj?=
 =?utf-8?B?RVhzM2YyUkNlS0MwbCtTTFpxdEoxcHIybWZzeUlxSmwzQlFsa0lRN3dUZlJM?=
 =?utf-8?B?OEJleWEvSzlmNUNLbS9WNGZwdE9WZk1RUkZRVWd5ZjZxWXd3T21YK0pLUS9B?=
 =?utf-8?B?QU5UMENiQWtad1E2R1p1bGRtSFZHbGgxdHBkQVlScElLaUYySVBZNFgwU3RT?=
 =?utf-8?B?amZaOGRjazIzYmN5OE1mdUFmUk1XenQ5RWJXZkJPRy81MEIrU3BPTDV5MW82?=
 =?utf-8?B?aWxrcmg1VDJoZS9pSFlkWlVjNk1oZnowRkpUK1NBME9XWHoyRXI5TStJeGlD?=
 =?utf-8?B?ODR1VzE0LzlmMzJpcUxtTWZqVHVaTlk4RGlRcEtMMjRCVWFDaXIyVTlMK2d2?=
 =?utf-8?B?d3hpTjAxOVhQWkhEeDJtSGlMRitESUIzTUFEVDZJU1JsRWVlRlhRVm52SlhD?=
 =?utf-8?B?dmlVUWlSVTRRM2N1SVdRb2xRUGljLzFrQ3lMT25qNTc1OFVvMnVxUWpMM0Nw?=
 =?utf-8?B?dzltb3lnaldaaFJXVmJxanNNOXdzYSthZ3lWRFdYZGZ2MFowcjU5Sll3N25X?=
 =?utf-8?B?OUZWSWFjOWZrUXpqeWkyVVkyY3YvRDRUZDhjRE4rOFhaTjU3eHIrMDBTZVJX?=
 =?utf-8?B?RXJKYUVBdFZpa1dPbEszTzJEZXRTNGk1bG5OaEpTbU8zWjNNUW9vczFoaFBt?=
 =?utf-8?B?Q0tzSVpsNUQ3T2M0OTlNUGIrVzJJVFY4aGE5ZFNUaGhXT3hVZ294Q2VEczNQ?=
 =?utf-8?B?V2VPTzkzVXJXWmM4cmtYU1dQcGFreEI5Y3oyUlFzRHlWWjVTWFBlV0hpVFpw?=
 =?utf-8?B?b2hSbFRhZlo4bkZBcUFYQlZ5R1dUamdMdWFmRUJTNzUzSmRtemhwUGYrUjRH?=
 =?utf-8?B?ZjBkTFdnT2RXOGsyZFZHWXlVZlZOVWVnK0ZqWFlrdm5vOUhBVXlGVFoybnFP?=
 =?utf-8?B?elRtRGxPYzd5ZXRpOTVvOUhuOFZCMkNLVjdURmJWbUc2OW9NdStvMHdTVHV5?=
 =?utf-8?B?M0YvanNQRk9kSm92S3hKODROdU1VSnI0N2Q1RDBjT3ZtZWZyQVZWdDBnblN3?=
 =?utf-8?B?cFdxOG1KSzVaRkNtckNwWGVZVzBOaXJXTUxNRFFVanNmT1BIUGxUZjl2ajFj?=
 =?utf-8?B?Y1RhVlVNMnFJZGhpTUZKaURibEsvY0hRV2t2Q3daK3B6cWIxRE1wV1ZmMlht?=
 =?utf-8?B?RUpzRGNMU2EyZkNFQmVqem91MTVDZnI1eEp4KzZCT1NicnArbWVIVU91T3pX?=
 =?utf-8?B?N3UyM2hCVUJ6TTNsdm5lci9nRHpndkVZZEN2SVRUbUEzaGVYZUtrVks0clhO?=
 =?utf-8?B?WUZWQzhFaWVHLzBFVHRXUDJaa3Azd2RtNDA3MXp0OWV1Q2FINFV2Yy8xYTdu?=
 =?utf-8?B?Ym1hUEZDN2NyL01vRkJuQ2FmQUdBMTZrOFRJRCtPQ2F1REdiQlppWjdtMTN0?=
 =?utf-8?B?QjNnckRKU2hGUHJYSTBMSS83NFpxenlYY2krblJpanR6RkRZTlRIV1hldWhB?=
 =?utf-8?B?dnNjSFdlUDA3OE5Hem5OYjR5Y0FUcS8zMGRjSTZybjRFVGo4YWQ3T1o5eEhB?=
 =?utf-8?B?cGRMK01ZclM3Ung1ajN2UEhhbDljcXNXUE9LUGtOQkhzY290bFAwN2txYTRz?=
 =?utf-8?Q?sG02iSAqUhKg3UQ4ZhSAl+EVH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c2e879-8924-4d29-7ce2-08dc86e27a12
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:10:45.0891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLcQwd9dT4nf4LcfEKFJ0UFoWLhODNO0XE2mXOxSAcmayHfPkkDotwK1FHVovQipg1VRVShc2YK4kuqBw8oFR3Iv3c5dq7UvVkvgNCdAc/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4633
X-OriginatorOrg: intel.com



On 06.06.2024 22:32, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> When innerprotoinherit is set, the tunneled packets do not have an inner
> Ethernet header.
> Change 'maclen' to not always assume the header length is ETH_HLEN, as
> there might not be a MAC header.
> 
> This resolves issues with drivers (e.g. mlx5, in
> mlx5e_tx_tunnel_accel()) who rely on the skb inner network header offset
> to be correct, and use it for TX offloads.
> 
> Fixes: d8a6213d70ac ("geneve: fix header validation in geneve[6]_xmit_skb")
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Thanks!
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/geneve.c     | 10 ++++++----
>  include/net/ip_tunnels.h |  5 +++--
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 51495cb4b9be..838e85ddec67 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -815,6 +815,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
>  			   struct geneve_dev *geneve,
>  			   const struct ip_tunnel_info *info)
>  {
> +	bool inner_proto_inherit = geneve->cfg.inner_proto_inherit;
>  	bool xnet = !net_eq(geneve->net, dev_net(geneve->dev));
>  	struct geneve_sock *gs4 = rcu_dereference(geneve->sock4);
>  	const struct ip_tunnel_key *key = &info->key;
> @@ -826,7 +827,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
>  	__be16 sport;
>  	int err;
>  
> -	if (!skb_vlan_inet_prepare(skb))
> +	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
>  		return -EINVAL;
>  
>  	if (!gs4)
> @@ -908,7 +909,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
>  	}
>  
>  	err = geneve_build_skb(&rt->dst, skb, info, xnet, sizeof(struct iphdr),
> -			       geneve->cfg.inner_proto_inherit);
> +			       inner_proto_inherit);
>  	if (unlikely(err))
>  		return err;
>  
> @@ -925,6 +926,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
>  			    struct geneve_dev *geneve,
>  			    const struct ip_tunnel_info *info)
>  {
> +	bool inner_proto_inherit = geneve->cfg.inner_proto_inherit;
>  	bool xnet = !net_eq(geneve->net, dev_net(geneve->dev));
>  	struct geneve_sock *gs6 = rcu_dereference(geneve->sock6);
>  	const struct ip_tunnel_key *key = &info->key;
> @@ -935,7 +937,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
>  	__be16 sport;
>  	int err;
>  
> -	if (!skb_vlan_inet_prepare(skb))
> +	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
>  		return -EINVAL;
>  
>  	if (!gs6)
> @@ -997,7 +999,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
>  		ttl = ttl ? : ip6_dst_hoplimit(dst);
>  	}
>  	err = geneve_build_skb(dst, skb, info, xnet, sizeof(struct ipv6hdr),
> -			       geneve->cfg.inner_proto_inherit);
> +			       inner_proto_inherit);
>  	if (unlikely(err))
>  		return err;
>  
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index 9a6a08ec7713..1db2417b8ff5 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -461,9 +461,10 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
>  
>  /* Variant of pskb_inet_may_pull().
>   */
> -static inline bool skb_vlan_inet_prepare(struct sk_buff *skb)
> +static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
> +					 bool inner_proto_inherit)
>  {
> -	int nhlen = 0, maclen = ETH_HLEN;
> +	int nhlen = 0, maclen = inner_proto_inherit ? 0 : ETH_HLEN;
>  	__be16 type = skb->protocol;
>  
>  	/* Essentially this is skb_protocol(skb, true)

