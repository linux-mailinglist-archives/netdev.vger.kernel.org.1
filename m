Return-Path: <netdev+bounces-104939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7450A90F3BD
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AD61F2283D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DFEA29;
	Wed, 19 Jun 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+5Yc/qr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840835381A
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813428; cv=fail; b=sZQ9x9fqMrc5BZez/kf0KkNHesHE3FVU0aXHEPzbCpKxpWge7RBfeNaxTBvkOo72YmIytpLJykV9/UbCT4EjzX/uMR4JI1/iS99xghyA7LtscsAn/vPqKh/DqBgcQZ2qfeZEumnc0hgtPkhx2Utx0sM0gwf2cMAv2EslzDvxjS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813428; c=relaxed/simple;
	bh=1dS7P87Qujl4oiynmMSoFqKga/sUABsDMS+qhy5IN5A=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yble8iudiJEdQkKkfd2QbPiZefeXJ7VExMAHXvDBcvA+hL6XAW7qUzqY08tPHdhRmvKE2i4Ynv5yjesnjgmFp9YB9zU4c+HOpOSg7QRHxNbVGvYb4TvbYCxWv4rs52DmQyfXiqOU2LgmNVOY9Sa6sn0M/f/wafkAQ4r52ls464Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+5Yc/qr; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718813427; x=1750349427;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1dS7P87Qujl4oiynmMSoFqKga/sUABsDMS+qhy5IN5A=;
  b=W+5Yc/qrLSeECUZ2m2FPFeHqtSbOKgxAmwmVqQpCPf9k0GIQ+8DiYedj
   ee48LyUWPvlXlNDakwAH8Fk6rkp65DnonnYf7TionaFoNONyxXlD4fOQR
   +F93cwhr1i0K4TuZvTenAFxyh+7IpjOpqHoWaxy57aiyLRbtWD7W+4Jqs
   AnfnyshUf7DIlwH+T/LKmqCy5EGZ28K6uOd+dQffBmjlW1F8nkmhOYfHb
   OB/zjXfGoVVLIFSuGFuYxAfSez7kGVA4++NjGZPxmwb/WdFXMvKhxibDG
   U7KO16VYv97AQw8yMnokE7Z2TJI+Mo+uUqfDDcArPH4Iy8ANVlqRL3pV6
   w==;
X-CSE-ConnectionGUID: 1tbNXWlVQCinAckXELOrVA==
X-CSE-MsgGUID: 59t3Ktr8QrK+F0lNRg7tKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="33308865"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="33308865"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 09:10:26 -0700
X-CSE-ConnectionGUID: RAM0ef82Qfm0FZ2NT+ZYWg==
X-CSE-MsgGUID: 6a0Y8zjvQ52uRldJn0tyKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="41857921"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jun 2024 09:10:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 09:10:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 19 Jun 2024 09:10:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 09:10:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlNFgzZ+rg9BmhZ6EgxC1qR2wqeP1XI8I90Z/b2rCA+yRlavEv0fZczHBSHb1ewidVo1nFtmG5RgNohFiTd6bPxRoQ+KbHg4j5xghYRW50p3VjPPzZEwgEvfljkLTJSsaREQ+oRIdu1r99FPsoJcjX2ZZA9FCd+hFrbZ/k2CBQin/okh5hp3h6vUgCZTuselAwrnaoUGf5j37weKjt7ONaxwkhO09LndO5swJeG/4mt40bDFq4KwUqQLYua0c2I8YnZuhtwBsQgSeRLxcbNkZtXx6U5qLzEirGrJfXP941Uj/s3XLnIb12aXEQh86y3axWzpHrJT2OsxhrGV26vGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRfQlLEojsrSVg/pL4M5CdlBYm7E+Z/KYbCg2pDuZks=;
 b=CQc8/O4WRm3ENAqgnHZfr+25oBJJef36Ap+jlJmw9a7n2S9aiuYVOCM61encJOBuI+EZUsxXjRPkySSeS3f+OazjvREP6K7AaQwJ+7gl67ruKF8fg14J3AiiTSo7PznMTshx9YhefRuuq7wIDowvQIo35lRZgiO/Sd50GCkTi6dJmMIUEffOpMPlXGaZ3K5n2RilSo+m7EO6uW+Jp/hXeVcJAGSYw0oUdovUdoqLShvTY/hoABa2fYdNbSGzcrsCollBj374fV0ooENgMuKjFxr8TTIxJURLTk0KRXQPUdSHrgLbkC67q5Zo7PmCkQwCcBqGx2cf1ts5XmaAM7zQsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB7399.namprd11.prod.outlook.com (2603:10b6:8:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 16:10:23 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 16:10:23 +0000
Message-ID: <171a8f73-5dd4-4d0f-b871-a341539a2fca@intel.com>
Date: Wed, 19 Jun 2024 18:10:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [RFC net-next (what uAPI?) ice: add support for
 more than 16 RSS queues for VF
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
CC: Pawel Chmielewski <pawel.chmielewski@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Knitter, Konrad" <konrad.knitter@intel.com>,
	"Ahmed Zaki" <ahmed.zaki@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Simon Horman <horms@kernel.org>, "Mateusz
 Polchlopek" <mateusz.polchlopek@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Paolo Abeni <pabeni@redhat.com>
References: <73ac167e-abc5-4e7b-96e3-7c6689b5665a@intel.com>
 <20240429185941.6229b944@kernel.org>
 <9be9efee-6adc-4812-b07b-007c0922183a@intel.com>
Content-Language: en-US
In-Reply-To: <9be9efee-6adc-4812-b07b-007c0922183a@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0126.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::24) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3a7d67-cc57-4e3b-98da-08dc907a52c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjdhNFoxdlQzWDlCQ0NDTnFsaDRnQm5zcWxlWU0rdndaZ3RTNlp0dHIwZ1NG?=
 =?utf-8?B?UmNyQmUzcGJQQnpyVEtsN2crQytwNC9YR1FTanBmeFB6M2hJL3lodEtCLzVn?=
 =?utf-8?B?Q3lrNG9kTDZHVTJLcVNCZmIwN1FSV1pLNUFsSmFxOGVNMnBMQ211bzFCTGRy?=
 =?utf-8?B?VGlJTXRjQWJIc201Zjc4ZnNrZ2NkTklxa2hZQkE5ZHorZldnenRBMW05d2x4?=
 =?utf-8?B?RG1yUVIwaSswakVsQzBqNWgybzZoRXVzNGtnd0Q1d0YvZC9TYTlVaGhUNnpE?=
 =?utf-8?B?ZmlxdHExZTNyMFFUZllWemZibWU1SjVGUERPNHFFcUhCSXR5djNqY3J1Q2N4?=
 =?utf-8?B?cGx3RGQwZ3V2enlnZmhwLzUvc0NwbkEzMzRWNWU3NmVNYXVWS0pUZm0vcy8v?=
 =?utf-8?B?OUFQa2RTMVhqT0MrSkd4MmN3Rzc2aGNjVEZUckMzVi9lMy9ob1Z6cnZGK2lk?=
 =?utf-8?B?SkkrWWJwK0EybXlnVlFtaFYreU4yYlVmSlNnRHhzUXByY01RZFpvYmoydStt?=
 =?utf-8?B?akdsWlkyT2crVFJaaFp5NkhvT1VQak10QTNZQ1djQW9ya0xHOVZDZE1pUXhn?=
 =?utf-8?B?Y1dqUk5KblUrcnB6d3ZVNWU3cHdJNUF2UEViMjNHdmRMcjVqdzI2eXdKRHJo?=
 =?utf-8?B?T1A1NW9OZWYrRUJ5NWkzTW5hQ2t1SExtZDNjQmtJRVh0S2RGRXZzWG9hMVU4?=
 =?utf-8?B?VHR2Y3VvMk1xMDBHUjBuZmg3aUNYZDBNRWNqbHcvc1VYY3VUcHh1Zm9YOUhN?=
 =?utf-8?B?TDMxUUpzSjNFY0U0T0NNdStxOVh2d0YyUFZ6YlI3OEJ4bHQwTXZpR2JIZDRM?=
 =?utf-8?B?K0RRZW9maG9zdXA4N3NYeWp1K3FNb3NUNW1QR3EraE14MjdpTC82MmdWaXJS?=
 =?utf-8?B?V3AxWWI0MjFpak0rTE9LZ1QzeEk3RWFwandOdzZ2WnhlSU4yWk92NjFYcG9V?=
 =?utf-8?B?TDJSVjZQS0hCVzE1bExXb1Y2YUkwZUtOSkF5L1hZejBYZkxNUWxPQXdrRTNu?=
 =?utf-8?B?NFV3QzQ1L3gyaUVYUDAvZEg2Sm9DbVJyMmV3alhWY25xdzdSRDFpaEVPcDBn?=
 =?utf-8?B?MUVsR0puUTJmTnFBb0VuUSt5TTk2UGFSZ3BIUWRnWlpzM1hGcEhDQ21xODN2?=
 =?utf-8?B?ZXN3ZkhIUjZhTHprazZFdkFla0M1dFdEc0RGMkprY1dpNTVWbDU5UzlEWGlU?=
 =?utf-8?B?N2JHWjUrYTFjODJlNjh2ajYzc0MvTTJ1ZkxPLzcvTDY2aUFQbU9IL3hzMno2?=
 =?utf-8?B?R09SUXB5azIyVXpaRHlWQnVnK0NHcGNTVXlDZzVnUSt2QnpuZ1ZoQTREUERP?=
 =?utf-8?B?bGxDR2NjeWFvNlRseTMzaXNncTg5Ti83VXQvYjdVU2oyRldGc1JLSGhvdEJR?=
 =?utf-8?B?T2VXWDRYaGF1LzBWL09KTDg1cVdsdWRLUkNSVDhwbGpwckpuM0trQkdBdG5Q?=
 =?utf-8?B?TURqWHFRcmFEZHNISGlnZXd0RXVjSGR0UHpnYUdEbTF4RjFPT2Q5ZWIzbVND?=
 =?utf-8?B?ejZlNFRRNTh1ZFY0WURYUUh6bnFKaml1eTh0QnJqOEtrcTFtR3prZ29HUitP?=
 =?utf-8?B?eXN0K0piVnpQbnpJbEhvNkFmemFCYnlYdThkNGtIV0Q0eHZUZEQ4RDl0MkNy?=
 =?utf-8?B?Y1NsRGFZU0hNTHFQRlIydzhXWDc4QmltcmE5anYwMENOVkdnRFNSWkVTWFA5?=
 =?utf-8?Q?URHtjL4S7l2q70QSA90y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkhrNmFqVEwwZ2hiZHlYdTdvQ0EySTFkM2p6SjRreC9Ud0pMMTBEVW1nOWU0?=
 =?utf-8?B?Yk9naHcwNmRtSGdpcWNFNmNacHZvczA5NWE4cUJrRW5JZ21ycmxqM05ocHo3?=
 =?utf-8?B?TUVZbkpwV3FQM1cwL1JDUkM0cDBTdzB2djhtZHc5dk5ObHI2S2p0TUFkVnB4?=
 =?utf-8?B?Zk5kdzFYTkNib1dSMzhuUXJ2QTJMZDc4UXc1bU40M3c4dExYZEd1Y0U1Y0do?=
 =?utf-8?B?YTI4bDV0SEVnUVVjemU1Y3J2WGplcG82TkxNelVKTEtPRUM3WlhUcnpvL3Zv?=
 =?utf-8?B?NEJpWW8rckJGbmI3bEhPT1RvMGtsWGlBMjhuQWVidVlDSDNhWWFWMkdhSU5S?=
 =?utf-8?B?VVp5RUo3WjY3ZkMxYWZRY0hEYVpQSTBBSG12TUkwaHZXbU5CYlZ5YnBCT1NK?=
 =?utf-8?B?cUk1enhRL2xxaFhZQS9OSmZSbllyTHdvMEMxNHB3OHl3ZmxMbFRacTh3T0xw?=
 =?utf-8?B?bjRhWFpteWoyaEQ4U3drQVRZMTd5cVAzSUx3Rm50UXFla082Rk1HTXJtTGEx?=
 =?utf-8?B?b1dwMExWTURua1BsN0Z1U20zOGZuWlVGaDhjNlowNXNYNjNiUnBPOGorVm0r?=
 =?utf-8?B?cEFnS1FjSzRGa0lrR3pFU09DVC9iOGZtNzcxMXl3VXR5YUdsV05sYjl5MHlW?=
 =?utf-8?B?YndqTnBYTzZkOVFxRlpMTkxjck9tekFkL0ZaRGxSdk9UYmMwSFViZVBtNGpK?=
 =?utf-8?B?NlJzbFdHQ2diczBxMC93S3ZyR3pyeEVZajhOTDR4eUc1ai9zaEZqVVRYRW1i?=
 =?utf-8?B?OGNocVFzV2tGbW8xT0ZOazVOUkJqVTlpZzFBV25WR2ZtR1RIakxvVWgzcUhH?=
 =?utf-8?B?b3lpZmRUQk1FVHRmQ0hkd242djlvS0N3NU5vbW5ROVdhcnZ5eTBKQjZabHd0?=
 =?utf-8?B?cGU5cHpnQjd0d1BLOW8ydTB1MHMvMjczMVl0anZmdHpVK21ZaGVjcEtyajBi?=
 =?utf-8?B?ZFJYdlByU0NvaGNWK2dBNzY5Tnp6cmZGUWMzQUxZZU5aNG1XSDBEY1E2L1Z3?=
 =?utf-8?B?bml2T0hETmE0K0oyUUw2aTRCYXpqS0xVYUxpMTFMaHdocjJGbkwyQXhBZCtJ?=
 =?utf-8?B?QjRRQVUzY093RjZ3RndjUFBTS3U3QlU5SWhZVXZkMnYrdWJRNklXU0pxaGhL?=
 =?utf-8?B?NjA0NEpCTEdld3p0bHg3V0o4cjRJQUlSU3JwYms4MmozYm1DYmxTejVUVlF2?=
 =?utf-8?B?Z21RMnB5dHdJc0pEV2N5amdkbUdvOWpUUXBaQ0dLbldWTkN5UzZVTW5Wcisz?=
 =?utf-8?B?MnMzMWNpbE8yWStaanRwNEE4aGxsMkVQMFRQUzlrZERJNTFVbWNPUGZDay9G?=
 =?utf-8?B?VGppMDVEcUdXN3JuZ3h0R3U1aU5wME5zckk4T1oybExxSkRUVG9wNkliY2Jl?=
 =?utf-8?B?cTZvVm9vTlRQVVFiWDZ4bStrcTB2RXhxcjZUT1hlWWMrZ1dqRDkvZWlYUjRh?=
 =?utf-8?B?cEFpRFVuRVdONHVHdXN5U0VrK0FsWVQrNEdxSHN2cXVscy9UWWJJaEhWL0kw?=
 =?utf-8?B?Y045NG1yWFhtR29PMzR5TUtEUTVTRmczcFFKQ3FNVUZkWDlSU2hzT3RZRTl6?=
 =?utf-8?B?THNxRlYxVklUTXBobk9LZVYrRTR1d2hzTDUxTVlucUtZN29mN1FtSG9jK1lw?=
 =?utf-8?B?WllUUE42clJRZkJGSWRsUXllWmM0Q0lLYk1OVE5hSzltUlRYTGxpeTFsUjZT?=
 =?utf-8?B?bnVwaFN6eDNwR3RlZHN4UmFnNzhQeFZhblA2My9xT0JRVHFGd3FvMjBaZ0Jt?=
 =?utf-8?B?ZGFLL3hLM2FER1FJaEdlOEFUajIrZStNeTFRMkIzRmJqZnhKRDR0YlJxUGpR?=
 =?utf-8?B?eGFrWnpTRXQ4dTVLYjUvUlRSWUlEQURwMVFaOVMvVFB0QTZrRXJrdEpJZW1B?=
 =?utf-8?B?Q2hrNk9zUmcwdjA5NFFTdFFkV2NHSEdZNXhsQk8wQjNpcDhNd3RVNnphOHp0?=
 =?utf-8?B?RUhrQUdMUEp4U2xGQW56VWtSVXRWSG51YWc0TDRZUnNUS05kVmdXUHVlOVpK?=
 =?utf-8?B?a1BlUEsvOTVhUjlZWUpxakdyRUhtRmlWMDJyajF5bm8vejBDSTBBZWhBbk9F?=
 =?utf-8?B?UFBuM0xtdVVuc2pBd1JHUERxbGY3ZFJBWE1rTDBTcDRoK0QzOXZOZzlJRnM0?=
 =?utf-8?B?Z01uUVZKU05KOTVLWlM2RmsrVVZGc1kzTFU5NWU3NTVIMk4vQ0dMdGtaWngy?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3a7d67-cc57-4e3b-98da-08dc907a52c1
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 16:10:23.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vifY7vzzeo5gbG01tI+lJ63BYss0big4H2Om7DP8vgWNGU5EtBxVbQ1Q56N+hNQVWyqqJPd1G6s2N4/KlYeLV7ZO6dykWq+zhBng0WfmyU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7399
X-OriginatorOrg: intel.com

On 5/6/24 16:34, Przemek Kitszel wrote:
> On 4/30/24 03:59, Jakub Kicinski wrote:
>> On Fri, 26 Apr 2024 15:22:02 +0200 Przemek Kitszel wrote:
>>> ## devlink resources (with current API)
>>> `devlink resource` is compelling, partially given the name sounds like a
>>> perfect match. But when we dig just a little bit, the current Path+sizes
>>> (min,max,step) is totally off to what is the most elegant picture of the
>>> situation. In order to fit into existing uAPI, I would need to register
>>> VFs as PF's resource, then GLOBAL LUT and PF LUT as a sub resource to
>>> that (each VF gets two entries under it; plus two additional ones for
>>> PF) I don't like it, I also feel like there is not that much use of
>>> current resources API (it's not natural to use it for distribution, only
>>> for limitation).
>>
>> Can you share more on how that would look like?
> 
> something like below (though I have added one more layer to illustrate
> broader idea, it could be chopped down)
> 
> [1]
> 
>>
>>  From the description it does not sound so bad. Maybe with some CLI / UI
>> changes it will be fine?
>>
>>> ## devlink resources (with extended API)
>>> It is possible to extend current `devlink resource` so instead of only
>>> Path+size, there would be also Path+Owner option to use.
>>> The default state for ice driver would be that PFs owns PF LUTs, GLOBAL
>>> LUTs are all free.
>>>
>>> example proposed flow to assign a GLOBAL LUT to VF0 and PF LUT to VF1:
>>> pf=0000:03:00.0  # likely more meaningful than VSI idx, but open for
>>> vf0=0000:03:00.1 #                                       suggestions
>>> vf1=0000:03:00.2
>>> devlink resource set pci/$pf path /lut/lut_table_512 owner $pf
>>> devlink resource set pci/$pf path /lut/lut_table_2048 owner free
>>> devlink resource set pci/$pf path /lut/lut_table_512 owner $vf0
>>> devlink resource set pci/$pf path /lut/lut_table_2048 owner $vf1
>>
>> Don't we want some level of over-subscription to be allowed?
> 
> In theory we could reuse/share tables, especially with the case of auto
> filled ones, not sure if I would want to implement that with the very
> first series, but good point to design interface with that in mind.
> To move in this direction we could make numbered LUTs an entity that is
> set/show'ed (digression: this would feel more like mmap() than malloc())
> (The imaginary output below does not do that).
> 
> The main problem with the [1] above for "current API" for me is lack of
> aggregate device [2] in the structures represented by devlink. Let me
> show what it would be with one more layer (so I put PFs under that, and
> VFs one layer down).
> 
> Here is an example with 2 PFs, one of with with 3 VFs, each of them with
> different LUT
> 
> $ devlink resource show $device
> $device:
>    name lut size 4 unit entry
>      resources:
>        name lut_table_2048 size 2 unit entry size_min 0 size_max 8 
> size_gran 1
>        name lut_table_512 size 2 unit entry size_min 0 size_max 16 
> size_gran 1
>    name functions size 5 unit entry
>      resources:
>        name pf0
>          resources:
>            name lut_table_2048 size 0 size_max 1 ...
>            name lut_table_512 size 1 size_max 1 ...
>            name vf0
>              resources:
>                name lut_table_2048 size 1 size_max 1 ...
>                name lut_table_512 size 0 size_max 1 ...
>            name vf1
>              resources:
>                name lut_table_2048 size 0 size_max 1 ...
>                name lut_table_512 size 1 size_max 1 ...
>            name vf2
>              resources:
>                name lut_table_2048 size 0 size_max 1 ...
>                name lut_table_512 size 0 size_max 1 ...
>        name pf1
>          resources:
>            name lut_table_2048 size 1 ...
>            name lut_table_512 size 0 ...
> 
> where $device stands for the aggregate device (covers 8 PFs in case of
> 8-port split used)


As of now I started playing with that so I have an aggregate devlink
instance, but it is registered for the very same struct device as PF0.

So that presents an issue for user trying to show only PF0, but output
shows all the data (otherwise there would be no option to show
all of it)
Assigning resources will be easier as aggregate device could simply
disallow it, but it is similar.

Perhaps some userspace devlink tweak would resolve that, but would it be
nice to have different devlink handle (without creating a dummy PCI
device).

Any advice how to make it distinguished?
(IOW: give my aggregate/whole device a different name that any PF)

Please find below what I have now in terms of nesting (doubled device
addresses are easy to spot):
iproute2 $ ./devlink/devlink dev
pci/0000:18:00.0 # PF0, as I devlink_register() both PFs and whole-dev
pci/0000:18:00.0: # whole-dev one
   nested_devlink:
     pci/0000:18:00.0 # PF0
pci/0000:af:00.0
pci/0000:af:00.0:
   nested_devlink:
     pci/0000:af:00.0
     pci/0000:af:00.1
     pci/0000:af:00.2
     pci/0000:af:00.3
     pci/0000:af:00.4
     pci/0000:af:00.5
     pci/0000:af:00.6
     pci/0000:af:00.7
pci/0000:af:00.1
pci/0000:af:00.2
pci/0000:af:00.3
pci/0000:af:00.4
pci/0000:af:00.5
pci/0000:af:00.6
pci/0000:af:00.7


> and all named PF/VFs in the output would need "dummy" size calculations
> (I would like to remove this need though)
> 
> When all resources are assigned, all "size 0" entries should have also
> "size_max 0" to indicate no room for growth.
> 
> [2] aggregate device discussion:
> https://lore.kernel.org/intel-wired-lan/cfe84890-f999-4b97-a012-6f9fd16da8e3@intel.com/



