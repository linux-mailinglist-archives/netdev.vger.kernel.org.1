Return-Path: <netdev+bounces-119650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE71F9567E5
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8251C21ADA
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75B215F3EC;
	Mon, 19 Aug 2024 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPS7l17h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D5C15E5BE
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062378; cv=fail; b=LqIcfkwzi+e2J5r3vujJOLv+z+NMGuMDL9heLz2/nnazzacG54MnqD29gJwc0ArIzW6dyyHIwf5DcX2Vt5p5IdmY24ZYkKg7TDegBcBoWXAFiyPed4y4xTdoQ9/7T7jvDPBjI6zFLoI6EFp9JYH4CMfxTXuS8S1mMbPiOvXKHw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062378; c=relaxed/simple;
	bh=ysEuTDMtCIW55jBZPC5Mxg7tJLawsZqiZIhDNFWK+4Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BJ3Vhac/VG6R113COA00aVF8hrqbdggEf0oFls+W9A2stOZwo99bggvTGa5Oo4cGNX1QmG/ZZh+LfHrjWVe3Daj0cCWKIFS5u23eppG6Kb11MH8TqxJxXCsrUxiMMaxkTIx5/zbHkYR4pT6XUAIGM08S+MXevG/tOI17t4xObBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPS7l17h; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724062376; x=1755598376;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ysEuTDMtCIW55jBZPC5Mxg7tJLawsZqiZIhDNFWK+4Y=;
  b=VPS7l17hqsoseBKnIsqgvwlZZvRkAyJ8O1T8x457ZnI8tk2YyjQTkqBQ
   /bEJDlTQp5V6jdZ6soKMgQsPc9T0n6Mm/YOVX6Pw3pBDNHoHLksKp4ETR
   8UfKdF95+KkTwEo3QqyTNSaS/ogctEUjmoJEgvK9+nCuc8YQ8fWUhd3TF
   8ovtJEm9S9zdStZj9hmUElJ7PAt5YcCnY9TlRUZEFbQi5VbCoYrlhVKxE
   3sq6wLIp5k2/sJqn4fIV5GtXzWD/FTYwW/IQ1QN9zq4RivMZrX8UNSgtK
   T7tXYZuzWWQmU/b+cEOyeS4ZKPT0WjG6IBG32ZL8dmu6CKek2Vne1p/DN
   w==;
X-CSE-ConnectionGUID: YV59sJRGQfCxaIPD3dafpw==
X-CSE-MsgGUID: f4Jpq8hQQZSKpXRtIYZLeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="13089926"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="13089926"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 03:12:56 -0700
X-CSE-ConnectionGUID: 4z/Xu0YUT7i62Kwi4WTGKA==
X-CSE-MsgGUID: pU4TX9jISlKQVM4UnKmnkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60626999"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 03:12:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 03:12:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 03:12:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 03:12:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 03:12:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmLyXu+sTyTeV4u954N9oupj8LStq7cHbwmkBaHPuuTRPVtSPSlT1ZZzyAZ3KSEt02ns4wnU8+SPpm9s1HZjXaHbSdxPfPngEeCib0bGg/VCKMtBJ3df8VLlADRN8BTkiUjYnqOSGNm6t2t8ix4raTLDagtPjTYu/LRUmBaBd0xMCGlrmoCNMgG02LXgn/41f6deP1LMgQmmzfXo6FLQHPJ3Rz7Mefq8q77C3rcWYksUMPESCtQUjerPlihYROxKwdsbf/H7WNS37ljqR/xpAUWroYtVib+sjw4KPkYKgoQ7cmqRt3d8Ne0CjTOLWnRkVCGEvc0YOT4RccXy2Ugcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAelUGz+GS3gs0uj5TYB2KYT/IWq9/9NYNZYbX8IMec=;
 b=aFblN/lAzFuX2xRDwCmB2dBN+d/6xECWzSm2aek+L50FBZoTgYdfz1Ps2Y4A6xy9g/q1f4fhcBhW0OB+Vr7fg6eLaV2AbpKsnQewaBorE4VGkmZ+aLO2JSZIFJBaMUacqRNnguKoA/gWzy7+1OvKEpsNc9C+EjmDgWwkJQXWw6PRkU0AaluQHlOmPPU60eUSLozUW/KWyQ3Cf1OcSbEjkeHfyh5bzn/so7fFqy6VvMJEzLXB4AUKDr1r3/b5Cl04bW45ehQQbTO015ELmDdPZ/lnwC85AjYPprFB0Te6LazDVkHsvTfcRVL1gtHKy1tZN6Cfdvu0ASlOop+njwiRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA2PR11MB5052.namprd11.prod.outlook.com (2603:10b6:806:fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 19 Aug
 2024 10:12:46 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 10:12:45 +0000
Message-ID: <895f8e49-2bbd-4211-b1a5-6708956a580a@intel.com>
Date: Mon, 19 Aug 2024 12:12:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/9] bnxt_en: add support for retrieving crash
 dump using ethtool
To: Michael Chan <michael.chan@broadcom.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <horms@kernel.org>, <helgaas@kernel.org>,
	Vikas Gupta <vikas.gupta@broadcom.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>, <davem@davemloft.net>
References: <20240816212832.185379-1-michael.chan@broadcom.com>
 <20240816212832.185379-3-michael.chan@broadcom.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240816212832.185379-3-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA2PR11MB5052:EE_
X-MS-Office365-Filtering-Correlation-Id: 6082d835-7e55-4413-78f8-08dcc0377881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTl3SzJhZm5QR0YrYTlwdHZlSWN1cE9tSVFKYVNRZkNHSk9aOHh6YjBYTWJu?=
 =?utf-8?B?KzNreU5hZndUZ0lrYlRrTWFSWm0vNCtuTGNQbkljOGxGUmFoY2svMHZhUjBs?=
 =?utf-8?B?NFhPUnlBck5Mb0dxZE00U2xRazNRVVNMTWdRQWtFZzZsVENqQXg5dTU2OTN5?=
 =?utf-8?B?UTNwM3dHN3lLUFl6aHFnMGIxQnpDZzZYR3dKeHRIZWlvdDJYRkRucTNvVThM?=
 =?utf-8?B?Z0p4bnhwQXMvMzhRUFlZd1oxWmphNGF6dGkySS9RWmxkOTQzN2RPSm9VRy9Q?=
 =?utf-8?B?cjFWYlJzRFNVcDdhdU5lVm95RmFPMVF5ZFlUZFRrZzMyZExKalAwYnFiRU00?=
 =?utf-8?B?WGpxU280bys3UjFhUG1oT3lQR21oMy9EcHdSOVhwbXcrMUFCQittU3oyWXhV?=
 =?utf-8?B?VGtBU056K0FJcHloNUlwMHBFRU82RVJjR29iTElZTWkxS2hrcGRPYmhtZkFj?=
 =?utf-8?B?S1YybjhCSGZDQnlYd0xIOWc0Q3JlTHY3QjRGQ3lITXcvSFRvd3BHWXY4Mm5h?=
 =?utf-8?B?QXVLcHRxRytVeEJmVUhyVmJmcnVkV09sUWVLUkp1ZzlCODN3RW1CaVJPbGJ4?=
 =?utf-8?B?bUZPeUZSREFscmNlTFVRUi8rU0pORXRGajVJZ1VVV21RUjBJQmwrL2lyZGg0?=
 =?utf-8?B?a2tzZjBlelZ1YXpOdmsxMWVZTElncVhHbnhSaVkxZ3ZNZU1zem0zL1prc283?=
 =?utf-8?B?UlhQdVdOY3plUm91elF1SGxuLzRFaDdEaDRIaW0zZEcwS1ZxVWJFMEZwU3dz?=
 =?utf-8?B?S0J5WCtjRXJIUFRPME0wbXI5Vno1c1VGRUJqd0tqVDZZUXNjZEJ0Q0gxRGly?=
 =?utf-8?B?MGJGampQYm05STFJd0lwN1NpaXk1RnZnL2M2N1RxLytkZDR2d2FPR1B2a3RQ?=
 =?utf-8?B?Wm03LzRjWHdGMVB3S0R3TWdiSC9Vc1lTOWhUV1BPTXcwZ0tCdmhtaDhBOFJp?=
 =?utf-8?B?QWVGOEYyS3FsZmpyU01SNkZpNFVxS3luOGVUZVNDYTJ5NnJweGsyQzVVL2FN?=
 =?utf-8?B?ZmNJbzIwTi9UQWRHRWJDOGJuUk9sTXdmUkJ2Q2lhRDRKTVd1RE9XK0hrQTVN?=
 =?utf-8?B?ZW1BL3FTOWtaUEtsTGNsWXAyRUtYc0NmSUs4Q3ZoZ0pGeHhkR2NrYm1NT0Js?=
 =?utf-8?B?aXAvZkFiUnFSeXZUT1R5aGpENkR0bEVXYmVycGZPQ3BQMUNmK2hqYXVBMFdE?=
 =?utf-8?B?SzhGVkFFdmNkYUx3QnViMVlSSUZ5WnpIYnJScWR4U0VaUk1kbFp6aDBDN1pk?=
 =?utf-8?B?VkZqdEJPcVgzalN5UFVUeHBPWlZmK25Zemk5R3VTLzd2WlBpTnZVS3c4STU5?=
 =?utf-8?B?RUlzaGJDVDlUNW8xTEt6dEFUKy9mRWYzVklzRjhmZGV3QTZ4STBUSEhPQkpR?=
 =?utf-8?B?V29JVDlZeXZydkV0eFA4Mk5yZ0wxcEIySVFiVzdRTGlDTTVFanF6bVpGM3ht?=
 =?utf-8?B?NkhPUXQ0U0pTSlY2dTNJaWMwTWxZc0s0cTE5SjYrYVFBb1pPbnl3M0NEUngv?=
 =?utf-8?B?L09xeGZKM1ZQVHhHMHRtS2xVNG80cUNhdnl1VnFTZXZKMTAxa0V6SGh3cTc0?=
 =?utf-8?B?ckFEa1ZLNlZ5YVZQN08yd2JHcStBd003YXdyQnp6YnI3YnRiZkkxa08xa3A2?=
 =?utf-8?B?SWFhMTYwUTNsblVFWVdmSTdIYk1MNDRYZHpvcE9McWgvSDZqRkNEc0FNK1dH?=
 =?utf-8?B?MHM1VU5odUNlUzJOMzBSVmp4RFY4NFpnSmtMbThZcEIxNTlUdU9uN25JRi95?=
 =?utf-8?B?eUxJTDIyT0s3N2dXUTBsMkRyU2pmK2hac1hxN3BvMDlKbitKazI5SFhlRCs0?=
 =?utf-8?B?QjdWRFE0eDZGa0VwZDRFUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHZPZUZPeWxhbU5hOE1wUG1tNmZ1RkNjbjV0SDMyUUpVaUV6a25EY2tMMzRB?=
 =?utf-8?B?UmNjVW1VOWpFL0h4SGdJZ0tFSFNWVTRJM2tZV0E4aWNSUnAvOU9nNk5NZ0ty?=
 =?utf-8?B?MWczb01HTDVrNXMveldacFp5cjUyY0JIK2dRRk0wbEZNem9QS1YzYlRIMFh1?=
 =?utf-8?B?OGhYZ2Uzc2JkdGEzSlZBLzZxOExyYnh2VitOU2w0ZkNQZ25tS09TMFRJb2Zl?=
 =?utf-8?B?dDJNQ1dPUUVBWEduTG8yaVFKdldxV21BQWVLMlNQNGxmeEJhZlM3S2hpTDlO?=
 =?utf-8?B?OVFLeXNoMnpweGRZd3JpdFh0SzY3OWVHM2V0MHVUaGJ1V2dyWTdVRE1Qc2d3?=
 =?utf-8?B?SmkxYmkvS05tekJoRHRDYmozZjVweVFKbGd6ZGw5NEVJOTlZUkhCclFpVXll?=
 =?utf-8?B?ZWc2eXdRUWUzYkdnOGk4dVdYR212dEpFak5zUkFPQ3l4TGhWa0hIV1dSS3NW?=
 =?utf-8?B?ZmRUTVgwcGNEL0ttTUVUb3lVNzB1b0RjRlNWNktwNDJkdWFhamZqaW1Gd2xD?=
 =?utf-8?B?VHZ4SU1BMVcwWkNJMjFwR2NUUU1ZOTRQSDd2UXI4TzMreHo4Q25lcERoMlJo?=
 =?utf-8?B?Qy9LT0VYbVFFMi9nY3VyREZlaVdselQzSWVybTR4alpNTXgySXBhZnpOSGlL?=
 =?utf-8?B?R1A5QVRVUjlwemdSMzYxR3FjSWludGRtb0FmdFpaVk15cTBXWEUvTXdDRGdI?=
 =?utf-8?B?cWE2MnJSUk1Cd2xaaVlYNkE3Y3NISjB0alQwZlFvTUR0ZjFPdHJKR2k2aThR?=
 =?utf-8?B?dEJwaEpWN3V1MkFFWmFOaXoyTlE1MW13Zmh3WExzanBWZXhyNlJrU2ZacVBG?=
 =?utf-8?B?TEFJNW1IZnRMZE03ZEdHV2sxZjdPTHZXd2Rrck1uSFJETW5kOFZqRVg0Wkdr?=
 =?utf-8?B?ZkhQRCtUbmNJaXNjQUl1ajcyVnk2bENjb2x5blV6SFh4TzVyK1lWQnNBcERY?=
 =?utf-8?B?WXFNQ010TGVvcUVEbHU4YSs0NVBUaTFtRER2TkJrVS9ldXR5RGsydEljQ2Q1?=
 =?utf-8?B?VTJUb0V0RlJRRmJyZG95VDZ1dTZnNUhSRnk5WUl1b0o3QUVqVUhlN1pPUlQx?=
 =?utf-8?B?U2NTZ1dsd295RUpUaXpIUi9ySnBMZ05Odlg0bUtJdUwwWUZ6UlBIUy9POEZp?=
 =?utf-8?B?WUhSbE1sNEpLQWhaRlVacVlZS0drdWIxZERXcVJ3SmpBZlFWbDF6ZTIyd2xi?=
 =?utf-8?B?R0cvNzVPTXFzSW52ZzlaQzdveTFBTG1zSE5ncVhwcnhKZzZqWHJCU1p0UnF4?=
 =?utf-8?B?blFRdzBrTFNjVkFmRU9YdGN5dVkrTVlXdmlNS1UvMmExcFlVNFpXTFRxODNu?=
 =?utf-8?B?MlJGeHZ1SGRqL1Q4ZWc0OU1tYTdMc3BhclU5RnVnQUdiOHNkWnBkMUtxay9O?=
 =?utf-8?B?bWo5dXFmWjNyRXJLT0NrVjdYY3hwdWhNMEkwNGs4KzkzZVFNVkRLeDFxNUJJ?=
 =?utf-8?B?TjlOQWRoR2dVK2RhMzc4U2dGTWR4V0Z0c3I4MGh4LzQyWkJGYWpZTmlXMis3?=
 =?utf-8?B?NFBwNzFaVUxoYTFnV3hOdXZGQVh5NW1FbE56NlRHcVFUYmljaDBVaUhqL2Zq?=
 =?utf-8?B?bUl1UWgyUmE5Z0hKNHpzMmhrdzE0QW9MNVdteGdqNzBwMFFaYis4eFdQY29K?=
 =?utf-8?B?dlZWK3lnQzBMRUs2eE81UmVxalZEaFVRYWVMTGJrdTk2enZKa1RWdEFQMWxS?=
 =?utf-8?B?dllOeVIvSE8wYVZIbmZ4aVhBN3h1eWtsVDJNM2NTb3djanBvUHZxNXlHOXZ3?=
 =?utf-8?B?bnhJS1ZnYnJWV3dLVkgxVWJlOHdVRTdlQmhhMjlBcTljZzExejd0cG4vS05n?=
 =?utf-8?B?YnlFQktybGhxYzFCY3ZBWmR3SkFlSU1OLzQ5NFNWeWpqeCtDa2FLQm1iLzk3?=
 =?utf-8?B?TkJzc2tZdndoV1pDVmMzMVk0d2RwdndXd2EwRVRzNjRRUnFya3IwaU9mNzJi?=
 =?utf-8?B?YU9Nb0VWRHFJOTd3Z0xZV3VNRXRYZmtsRytyREloREFKOXRiVmNGUjdmOEt4?=
 =?utf-8?B?OHFHNjZia0N1NHIxV0lCWTlBaEZoVGRNMjFadDRITTN5V3cxVHJ3aThkeFBZ?=
 =?utf-8?B?dFZrTTk0TTVJOExjVHdqOG1vc0hHZXJ2MEdROTJUbmNCY2tqMkxLRlJtdE42?=
 =?utf-8?B?UFU5c3JXVStuWExxWjdqY1F6YmEvNXlmNUgvVkVVZnE5WjlQTmZCQXk1NVM1?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6082d835-7e55-4413-78f8-08dcc0377881
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 10:12:45.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlSXx5APLUqjOoELQU32XNLwqHrvZWBjilTbZR/w1DJMehukQn4RjEJZJJ6njcJFvqtvApUrCdlj9OjTapt3x31CW6nA9eqiGZDS9TZ8c7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5052
X-OriginatorOrg: intel.com

On 8/16/24 23:28, Michael Chan wrote:
> From: Vikas Gupta <vikas.gupta@broadcom.com>
> 
> Add support for retrieving crash dump using ethtool -w on the
> supported interface.
> 
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>   .../ethernet/broadcom/bnxt/bnxt_coredump.c    | 83 +++++++++++++++++--
>   .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 13 ++-
>   2 files changed, 87 insertions(+), 9 deletions(-)
> 

mostly nitpicks from me here

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
> index ebbad9ccab6a..9ed915e4c618 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
> @@ -372,14 +372,78 @@ static int __bnxt_get_coredump(struct bnxt *bp, void *buf, u32 *dump_len)
>   	return rc;
>   }
>   
> +static u32 bnxt_copy_crash_data(struct bnxt_ring_mem_info *rmem, void *buf,
> +				u32 dump_len)
> +{
> +	u32 data_copied = 0;
> +	u32 data_len;
> +	int i;
> +
> +	for (i = 0; i < rmem->nr_pages; i++) {
> +		data_len = rmem->page_size;
> +		if (data_copied + data_len > dump_len)
> +			data_len = dump_len - data_copied;
> +		memcpy(buf + data_copied, rmem->pg_arr[i], data_len);
> +		data_copied += data_len;
> +		if (data_copied >= dump_len)

==, but not big deal ;)

> +			break;
> +	}
> +	return data_copied;
> +}
> +
> +static int bnxt_copy_crash_dump(struct bnxt *bp, void *buf, u32 dump_len)
> +{
> +	struct bnxt_ring_mem_info *rmem;
> +	u32 offset = 0;
> +
> +	if (!bp->fw_crash_mem)
> +		return -EEXIST;

I would interpret this as "dump already taken, no slot for a new one",
while you just don't have mem allocated for it, so:
ENOENT 2 No such file or directory
or similar

> +
> +	rmem = &bp->fw_crash_mem->ring_mem;
> +
> +	if (rmem->depth > 1) {
> +		int i;
> +
> +		for (i = 0; i < rmem->nr_pages; i++) {
> +			struct bnxt_ctx_pg_info *pg_tbl;
> +
> +			pg_tbl = bp->fw_crash_mem->ctx_pg_tbl[i];
> +			offset += bnxt_copy_crash_data(&pg_tbl->ring_mem,
> +						       buf + offset,
> +						       dump_len - offset);
> +			if (offset >= dump_len)
> +				break;
> +		}
> +	} else {
> +		bnxt_copy_crash_data(rmem, buf, dump_len);
> +	}
> +
> +	return 0;
> +}
> +
> +static bool bnxt_crash_dump_avail(struct bnxt *bp)
> +{
> +	u32 sig = 0; > +
> +	/* First 4 bytes(signature) of crash dump is always non-zero */
> +	bnxt_copy_crash_dump(bp, &sig, sizeof(u32));

sizeof(sig)

> +	if (!sig)
> +		return false;
> +
> +	return true;

return sig

> +}
> +
>   int bnxt_get_coredump(struct bnxt *bp, u16 dump_type, void *buf, u32 *dump_len)
>   {
>   	if (dump_type == BNXT_DUMP_CRASH) {
> +		if (bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_HOST_DDR)
> +			return bnxt_copy_crash_dump(bp, buf, *dump_len);
>   #ifdef CONFIG_TEE_BNXT_FW
> -		return tee_bnxt_copy_coredump(buf, 0, *dump_len);
> -#else
> -		return -EOPNOTSUPP;
> +		else if (bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_SOC_DDR)
> +			return tee_bnxt_copy_coredump(buf, 0, *dump_len);
>   #endif
> +		else
> +			return -EOPNOTSUPP;
>   	} else {
>   		return __bnxt_get_coredump(bp, buf, dump_len);
>   	}
> @@ -442,10 +506,17 @@ u32 bnxt_get_coredump_length(struct bnxt *bp, u16 dump_type)
>   {
>   	u32 len = 0;
>   
> +	if (dump_type == BNXT_DUMP_CRASH &&
> +	    bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_HOST_DDR &&

I would wrap bitwise-and with parenthesis, even if not mandated by the C
standard (the same in other places with combined expressions).

> +	    bp->fw_crash_mem) {
> +		if (!bnxt_crash_dump_avail(bp))
> +			return 0;
> +
> +		return bp->fw_crash_len;
> +	}
> +
>   	if (bnxt_hwrm_get_dump_len(bp, dump_type, &len)) {
> -		if (dump_type == BNXT_DUMP_CRASH)
> -			len = BNXT_CRASH_DUMP_LEN;
> -		else
> +		if (dump_type != BNXT_DUMP_CRASH)
>   			__bnxt_get_coredump(bp, NULL, &len);
>   	}
>   	return len;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 39eed5831e3a..265956c45ff5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -4993,9 +4993,16 @@ static int bnxt_set_dump(struct net_device *dev, struct ethtool_dump *dump)
>   		return -EINVAL;
>   	}
>   
> -	if (!IS_ENABLED(CONFIG_TEE_BNXT_FW) && dump->flag == BNXT_DUMP_CRASH) {
> -		netdev_info(dev, "Cannot collect crash dump as TEE_BNXT_FW config option is not enabled.\n");
> -		return -EOPNOTSUPP;
> +	if (dump->flag == BNXT_DUMP_CRASH) {
> +		if (bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_SOC_DDR &&
> +		    (!IS_ENABLED(CONFIG_TEE_BNXT_FW))) {
> +			netdev_info(dev,
> +				    "Cannot collect crash dump as TEE_BNXT_FW config option is not enabled.\n");
> +			return -EOPNOTSUPP;
> +		} else if (!(bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_HOST_DDR)) {
> +			netdev_info(dev, "Crash dump collection from host memory is not supported on this interface.\n");
> +			return -EOPNOTSUPP;
> +		}
>   	}
>   
>   	bp->dump_flag = dump->flag;


