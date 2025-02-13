Return-Path: <netdev+bounces-165855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA80DA338CC
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755BF168701
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFAA209F25;
	Thu, 13 Feb 2025 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKIqPwZA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12331209F48
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431623; cv=fail; b=VmYAfifMoXuwpNknlx+46Juvrq6zIKpjxEEaBr71v3mbd+8YprCEBUDRcV2x5LYSG4vAZ9c4ctApktFdBM+VEEHvsw4MOdiCPijShEd1pzQ8BC7BULXG1gPveO/Zhjh7gjEd37daiTemn09WS+Vorg09bsPQsxIG9/8oto9ki0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431623; c=relaxed/simple;
	bh=onJnIK/eUYvUAvW7Y+pawptk8r/AsIvrMnaX376l1Ao=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k4in+KWrY3oiFfLNmYAgi3rk75Ge9wb+p5Ok0f1KsPY9ock1LuyeSapYe5M8ZpatahgC0W7vS/F4/amqCrjbcad9WAb7EsrlvnTpmG7QOLP15OmaXzK3nD6KE7TEEJxFRKHRIViXbNH8LY9fafydPRfzDCOmYHELm9wc1GlvKKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKIqPwZA; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739431622; x=1770967622;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=onJnIK/eUYvUAvW7Y+pawptk8r/AsIvrMnaX376l1Ao=;
  b=iKIqPwZAQoTK33GeRbD52qNmhMki7slN562YDNzKzUTcqXeH+wHS2Cz+
   o8OB1SIWv7JdfhcujH8R5vohDuCffW2kWEnLc3SvDIYGYbh29fxFaASR+
   282nu6JOM/nPwqpOMKF6ANeCjq03dezayPolqvvtOpP0rdQosekoJ//dR
   PU6PeEVyuPIDtBilyBnpjB9V8MtkYaecgtSHPx2+jY92hH47QEIuPEUI3
   ylIH6cH3S5Njj7dIOb7JfZXU+zna+x0s4piMYA2yA2yChn7MLAr3I8exl
   jeNPWmd0gCA+rTjleVxQowcYhHvGASIPMR2DaKVcNxOzGjA07NLaUX55q
   Q==;
X-CSE-ConnectionGUID: N/arbl1LQSOs9Ddz3Yg3gA==
X-CSE-MsgGUID: UwbWvrvqTUyHZGjUwxzqgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="44050716"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="44050716"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 23:27:00 -0800
X-CSE-ConnectionGUID: chTyu/+CRVO6qMtq3tWBYw==
X-CSE-MsgGUID: tu6vWHG8Tde1ZjSl9xATwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="118152011"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 23:27:01 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 23:27:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 23:27:00 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 23:26:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQsuVv146Hrnu2WGRJPFSorTAO9YNd6ShEaYj7c2fY7B+FzHclIQWy+fyOOSnOYgsgNoLy5ju98Pkpo4vnwu9549GXhOItG6ZnUtwKiYbYaO1UmT7lvRKTuPmsZTSHN4jUOSnRYfRSCv8nn5OE6DPT+hHGd+whM/sKFI2ATvUPL++Vx/dbdiByZ5vEcEHp/mNS5cit2Fp2dN5D4DNbDBiH3XJgtS6BY3UNgRl3YcinV1Y5eCzW5pYw/69msBz6xVy8XgLWUcunJvmvAzDhlyYf8/crIfghAaotuUjAtzhoV1tAChcztFwEpvsyD8VE710CoTbvMbsUpEsxfJvI77mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FXa6GfqXkPZRGzcj/jXU7wdQE9Y8RWDCnuImGiHgis=;
 b=g4CuKCK7uAEiIh3Wci6+b6aEgW7+38Cj7ofJgmgxVkriMJantZgtC2KdRWIJFJRYJuYFPNL35ZI5P/vjaHnzhBF77ZpTGtQ2H89xFqWvuByZ9eKiDmN7aDV2QUB7eZ8Mk2XGK5floijGBSlRAnKOLaMkUo4v9Ea4D8GeDqU2h9tVKGLSTt5udW7caUgwOlRE6S8upsyfQXZFf6aQFlkklHPYRf6MUZvk5+RBH610clz70atlCle5heE97uI9VAcF2GW8J3tCD0/OkU1kCuQgzRN8zoTCP3HaDK1DhKsmXSrU3gWKRofyKG5pOsWyyi5N/wabS5uZJopdbbq1TiUavA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 07:26:29 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 07:26:29 +0000
Message-ID: <8baf9307-daaa-4e0d-b89a-21403019ab2b@intel.com>
Date: Thu, 13 Feb 2025 08:26:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/4] net: introduce EXPORT_IPV6_MOD() and
 EXPORT_IPV6_MOD_GPL()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Willem de
 Bruijn" <willemb@google.com>, Sabrina Dubroca <sd@queasysnail.net>, "Neal
 Cardwell" <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	<eric.dumazet@gmail.com>
References: <20250212132418.1524422-1-edumazet@google.com>
 <20250212132418.1524422-2-edumazet@google.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250212132418.1524422-2-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|PH8PR11MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf121f1-ba65-4b1e-0248-08dd4bffbb76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHJRcVVHRmwyUllPbXFiUStTc1RaQXMzZ2w5WC9qanQ5V280dXhpdlJ4TlVk?=
 =?utf-8?B?YTFDdXhpOHVYYTZpMXN4VEptNzV0elQ1ZGVtMnZiQ0N0Sy9SVE9BTVJjZmNI?=
 =?utf-8?B?RDV4c3FKZmY0RWpTSWJuaEgvWlBlZzBOeHZDMk5FcjV3cEp4Ujh5bmsvdTdV?=
 =?utf-8?B?RmNrdFRxU0paMkY0ZVpnVkFDWEpBN1dYeXJ2WHVTUDVyaTlJMzBlemxJVEly?=
 =?utf-8?B?bHVuNGJKNHhxUGZXV2hkdS9BenBzMC90VEVmRnpEZHc1b0xhQTBBKzlmN3Mr?=
 =?utf-8?B?cmZTV1N0Uzc3RUVLZDRuK1ZZYmNFZjZsS1FVSXp3UVRuQlhtUVVVaXNHQ1Z6?=
 =?utf-8?B?M0JIZ0Q1WitZai91clZPeWw4OEoweGNPcEV2a1lKTmdtOGtvYmNMMWM5Sk1s?=
 =?utf-8?B?a3c2eGNFOWdQUlJvd254OWZrNmJDUXNwcEMrSyt6TlZIRVRqd3VSYzh6RXVW?=
 =?utf-8?B?NFJqbkpwZnNBVmxXOExyRmNCaFN0bFFjVS9kVVlqampqVUdtU2U3bmhjZVFU?=
 =?utf-8?B?SEN6UXNBcitNSSt6YmpRWlduU0ZIRjZzc2xRR2tlK1hzKzV4a0tPREZ5SWNp?=
 =?utf-8?B?eWdKUDNoTi9ycEdjU3RHVTlZWHJDQysvWGthN1JWTzhKcnloWjhTY3ozQi8y?=
 =?utf-8?B?bkdrdVRsdzBxY1NrYmw2SkN4K1EveDNYV3pIekYxMWJpWG0rNzVQcnVlRXQ3?=
 =?utf-8?B?eXNTdUVzTUlXYkJqZ2drQjlNQW1tYlJYSzlaSVJ2bThMNHp2ZnpMSDc5YjBI?=
 =?utf-8?B?VldRQit1bkw2cHFmM1dmUCtnb0pTbDlyai9ma3dldFRCYXdtOFE4Y09TSk9G?=
 =?utf-8?B?ZFZMTEdUOEFiV1Z4dFNNMnZBQ1U3VnJZVjk2UDBlWStJejdyNTVyaFlxc2hC?=
 =?utf-8?B?M2NTamlxamJVakIrQXliN0tDbDYwVXR0bGZOZ3kwUlBYL1l6MXdFS0VQd2Vj?=
 =?utf-8?B?N1U2d0JpREh0MkNtWkg1Q0RFd3dkVjJxMk9SNG05WXU3LzM5c0ZRUUh1YkVO?=
 =?utf-8?B?R1JSdTN3d1ZiOG4vUW1TMzVXK3pBVUNoaEVseWhWN1B3WG91QUg0TmR3TDRH?=
 =?utf-8?B?VjRhUTdMS1Q2dGNmUllPUndGRlE3WVZjNyt5SzltOUplc2lEZTh6dmw3Wlk3?=
 =?utf-8?B?d1M0Y2x3VGNtTHdCdExGeDczT3hGb0JxVkcrbGp3RG1ZWkp5VE5UUFNlb1FS?=
 =?utf-8?B?eUNtV09nelEyN25xUnplREVzY2lSU1lEMGZoMVZYNVVJV0RVQjNwRGhKVkxk?=
 =?utf-8?B?aVJLVk5kZHNQQnk0YitORklSU2QwQ255Tlk2SHI2SjBlYVI0MXlTZnZ4dnFj?=
 =?utf-8?B?YlZybFMwb09PWndvTzBDV0N2SytSejdSNjNkM2ZKSUZ5Mkt2dCsxQmJtMmhX?=
 =?utf-8?B?dmdrVzYrVkpOZmZjd0pKRlZHZi8xMnJCK1JjaGlFZVE1ZS9kaC9ERTB5bi82?=
 =?utf-8?B?NXU5dWwvQWU1bEE1ZVl4VEFjVjJNSExJTi9oOVZWaUtYN3JPV0FacHhESUhD?=
 =?utf-8?B?aVBROTZaVTluUzBJZzR2M2lQdjF1OVlPa0drMi9tcjR0M2IrQWpRMjFQYUtu?=
 =?utf-8?B?dncwcG9RdEhNWENtcmQ1aDdBQ0hXYWs4bmRybnQ0UVYxMnUvYzRoR0xlRzBw?=
 =?utf-8?B?UVFxZHR2MHh3VkNvMnMwVDJhVHhnNjViOThYcHN1OURQN2ljcThWOVFRcTdl?=
 =?utf-8?B?M0czRDgwWWoreHBvK1Y5VjBSMHMzR1ZSRkJWMjlad3puUVMyT0R3SzJIMUpV?=
 =?utf-8?B?V2s1ei9UZlRmck40eWJNNWdLMTVsbVlvSXlydGgyamkvS2xPUGNVeWZnKzVL?=
 =?utf-8?B?WkQ1WC9QcEJWUzVtWnI0Z0liSTV0MmZ5YVNUTmlPYkFPU2VtZ1pmZ3VDTlpD?=
 =?utf-8?Q?pXKR+RzqDzsDq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVp3aTVYQm9ZMFZYcDQ0NjN1b2JpanoySWNjbWVRczZyNy9YMG5RWkt2N3l4?=
 =?utf-8?B?VXB2YklDbmlkVnpSZVNuSWJtMUVnVThRWmVFSVhRMFNCWUptNEVWZVBLSGJ0?=
 =?utf-8?B?ZG43ZFN2dkNhWVBsNFZjekhFM1U3WkE5UHFoOEVWTUUybGRKbjFPaDlqQXl1?=
 =?utf-8?B?ZGtpUG9KOHYyOWR1S3RhVERvUDk0YVhaL2VFWmJrRDJlMWRINzBrTm8yM1Jm?=
 =?utf-8?B?K25HOUpuN3owTjVpakZHY0llNDNQbWpPWThxWG9SNEwrWVBWZ01FVWt0em9x?=
 =?utf-8?B?Z0hJaWdWb1ZoVnpWS3ByWUdmc0ZRQitnRDg3VXdxak5sYldVc2JXQ2RLOEcy?=
 =?utf-8?B?V29BUEc2SW5mNFhqT1p1ZTBPOG55d0NhRDAzUEtVNWxBY00rZEl1TjFjUll1?=
 =?utf-8?B?R0Fod2VYdlNXWUR6Y0YvRnkrSndWSU9vNCtFODJweHBuckFwaEdTNVdNem1L?=
 =?utf-8?B?Z2oyMHc4azh6VmU2TittZEk3M0VuS1VDY3dGajFndlVnZzMvY21FSW4yQkVH?=
 =?utf-8?B?Sk1LWkkzbWFoOUxyMkhhajVVZUMxNTJGVk5yT2ZBMFlpVzBiNW9rT3IwRy9J?=
 =?utf-8?B?U0lYMXIrOGs4ZWhYRUt6U09BbEVKWjhYeFVEblY0bVFMQ3FWZTJwcG5QbFJX?=
 =?utf-8?B?RTdNalVZT3FEWUR0N1N6SklrQis1OUlGS0RWZllpVW13VFFzSVo2S1hZeEFV?=
 =?utf-8?B?VHg2REFBaWVMMmwxNHVzUXIyWmJpUXlWN2ZSUm0xc1ZkUCtDS1h6VmJER09Q?=
 =?utf-8?B?dXVRbWs5TjNxUnFTblBHZUhINUFSdlBXc3VPVzlYcEhtYmNHcnVhODNKREgy?=
 =?utf-8?B?NmkyT0ptcmo2QUJtOCtsemRiZGZLRXIyWi94SXBDZisrTHMxaVE0Uk0yRjky?=
 =?utf-8?B?ZjZDU0p5amlrU3FzaGk3NVY5RDllQnc2cGpVMEVvMHB5VFpkaGdNc3J2MlNW?=
 =?utf-8?B?TUxER3FoOFgzODJLdm53bTR2NEcwbE5MRnRvcFBzeXpTTnIxWFhMb2x4Y1JU?=
 =?utf-8?B?ZlJwTGNlNTlHNTlrWnhqaGNqOVJyRTZHbzltM01zcG92UEtVdTNsVXJWM1Fm?=
 =?utf-8?B?eUdTLzRSYVp0Vi9VamM2WEd0WkRNOGtVRWw4TjNRcXZmQ1BiZHh5bllMUmI0?=
 =?utf-8?B?YUNENGxtWkNObmRCOEtQMUNmTlR2dDAzaXpGazBkcjJkVExTaldyVEtRTTRj?=
 =?utf-8?B?SGdRUWdaTmlhUjM5cFM5Q01VSVFlc3pSUkpoSUNta21QYlUwbjMzYWJQVW5F?=
 =?utf-8?B?azczdzRQVEZ5eXdjWFpjMURPemlyclhGQzZ5a0ZDdzNacHBMVWprcEY3UjJn?=
 =?utf-8?B?TDhjMnMvQXlML2VRYTNpTjd6Z2kzWjRDZ0E4SGpXbWhYNC8vTXY4eHIyNkxF?=
 =?utf-8?B?TVBtQTdabm9JTnprRit2eTc0bUVGUkVNWFlPbGd0enhTRHdkSUFMTGIzZkFw?=
 =?utf-8?B?K0RDeDluOGd4QjZEZXlsbEV6V3QvNkZKbWMxRjRGSDRtT0xPTTlKYStqVm9q?=
 =?utf-8?B?akU1U2NlWXZhSzFIcGFSYVdlOGVSU1M4SHF0UENLOFZmVGN5VXVSTFZVWnVi?=
 =?utf-8?B?RWRobUs2SzZnM1pGNEg5RWV2RFU1em0wU1VwczM0ZHB1YzhSRHQ1RnByQksz?=
 =?utf-8?B?djBqUE53UW90NnNvdklzL29HUklRUzJCZWVqTHFNOHJuREFpSFY4ZjFxNFh4?=
 =?utf-8?B?a1BkVlJ1SDN4cERrN2pqN21CbDE2M3R4UG1XbWVxSXVncUlCcjE1TkZxc0lH?=
 =?utf-8?B?WkdGQlNzMzl0YzVkb01SVlV4R0RzbnVNVnNtQmFoUEdXNnY5Q1g1blhiRndF?=
 =?utf-8?B?UWZKbm1CRTZQOWZpQ1Y0cjJ1dXlqalRBdHM4OVVzcmJPMm9VTUxFN2lkK0NU?=
 =?utf-8?B?TDFRWTBOdTc2YjRIRVo0YURrcUxkS2ZCL2FvaHQvWSt6M0daTktWZUhhYWEy?=
 =?utf-8?B?clRuY0ZQL3FOVHg5T01aVjk4cm00dEFGdk1RbUdidHZpNitac25xOG9GQU9o?=
 =?utf-8?B?MkFmN01PVGVqcE1lazhGdUNQQlhCa0tmSkM1T3lkbDhzK0VnckpMRXFFRkh2?=
 =?utf-8?B?bDIxNVN0SmkrKzVmb0FGNVl2MzhRcFlpWHF1NjhJYTdwRTVQbEJ0RlhqUnMw?=
 =?utf-8?B?ZzgrZUpjaytWT2xGWUhwcFB2YlVYMUJJYVdZcngyRjNHRk9BTmxzbGdZWWEz?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf121f1-ba65-4b1e-0248-08dd4bffbb76
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 07:26:29.2765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3L3KDzorZwhKhbBjJMUbrvlwGjCRYRg3TLAYgmMhwfBidKuIpdpRuUdTB8iuINpGfewBohQNX5k5q/hFTRwAYfxlo5FqHBEwbarUxPx7e0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
X-OriginatorOrg: intel.com



On 2/12/2025 2:24 PM, Eric Dumazet wrote:
> We have many EXPORT_SYMBOL(x) in networking tree because IPv6
> can be built as a module.
> 
> CONFIG_IPV6=y is becoming the norm.
> 
> Define a EXPORT_IPV6_MOD(x) which only exports x
> for modular IPv6.
> 
> Same principle applies to EXPORT_IPV6_MOD_GPL()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   include/net/ip.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/include/net/ip.h b/include/net/ip.h
> index 9f5e33e371fcdd8ea88c54584b8d4b6c50e7d0c9..1e40c5ac53a74e1c20157709e49edf2271e44fe3 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -666,6 +666,14 @@ static inline void ip_ipgre_mc_map(__be32 naddr, const unsigned char *broadcast,
>   		memcpy(buf, &naddr, sizeof(naddr));
>   }
>   
> +#if IS_MODULE(CONFIG_IPV6)
> +#define EXPORT_IPV6_MOD(X) EXPORT_SYMBOL(X)
> +#define EXPORT_IPV6_MOD_GPL(X) EXPORT_SYMBOL_GPL(X)
> +#else
> +#define EXPORT_IPV6_MOD(X)
> +#define EXPORT_IPV6_MOD_GPL(X)
> +#endif
> +
>   #if IS_ENABLED(CONFIG_IPV6)
>   #include <linux/ipv6.h>
>   #endif

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

