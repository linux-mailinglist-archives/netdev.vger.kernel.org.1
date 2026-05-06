Return-Path: <netdev+bounces-284846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOgNKNBG+2lPYgMAu9opvQ
	(envelope-from <netdev+bounces-284846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:49:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 205EF4DB50D
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50F6E300CC35
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A21477982;
	Wed,  6 May 2026 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDn4h7/u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A56131DD96
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075083; cv=fail; b=f3/0wC0ORM5CDFcbCIpCoywusofr9+brW16cZvvkWR9waGxvKNKFwHaJ89fkraiTXf6j3GwB1rNap+UKT6binj29EdbGeOQOCJWkfI0gkY5/KLLaPfdoaLiXr7Kk0mx9VrBjw0ArcelGQSoIgZh6IMj+Q202uC5BT5GVscClyAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075083; c=relaxed/simple;
	bh=JjEBqlgO6j8x/hrTZAn077ZC2Qa4ygVCoUn5Vjfk9Uk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SAaxMDD6eGJstWWemXSuyHFXwWHF865jK/VlYkMwP8LYEuCG7Uv7f19xaTC8muBJkDaT64PM2cTfnp27ZLizQXCYCqXihcMEPMasbSbk0LJSnGHQ/XnjEcie3XlB1c/Wuv7myy3H4oMiq1WKgH1r7yhkpB00Gttju6vXF6cg/eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDn4h7/u; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778075083; x=1809611083;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JjEBqlgO6j8x/hrTZAn077ZC2Qa4ygVCoUn5Vjfk9Uk=;
  b=nDn4h7/u8yKEK6svX/WX4NncMDBm+UB4zDWrHnjptlUagjAILkqasjrr
   9WkporDQT6ydCYr63EvpOyJWOAgrpaWI+Iw4i2lj4uwtir67iVOia7q2m
   3bYWnFSsxlMPRyns/Mqfw3uskHMn2+Ymik8Hhsn8iSbQm07oUkIoVZ+lZ
   y81Imy2+JtS3+t/hd7AWLN9t4yxmTY+QDYXn3xHOeF6lDcG+L60Snachb
   Vixo9irWwKxPvx8R+NUlR9R63Bx46DETdF8ZWwjkr2EQFH7scBGxsLc+1
   3A3FpNU5b2RqItk+0L1zU4aDdVzmV+wrYYaOvk9TjnInBtrn5iSBQKLme
   A==;
X-CSE-ConnectionGUID: 0ObihEaURXGf3sxcJHbAIw==
X-CSE-MsgGUID: mn2j5hA4R/aV5K2wd5IS4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82874443"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82874443"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 06:44:31 -0700
X-CSE-ConnectionGUID: JStyFVwVRtGc0YipUFNkQQ==
X-CSE-MsgGUID: I/BcWnFASn2ZvQhSeOtxtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="274280308"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 06:44:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 06:44:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 06:44:30 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 06:44:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDJEd3IBhsNbjDcWONjaHEkjOOuiaK6iFzryw5ftYhba0/78bGnENkbM1r27fl5wbfDmfHaxnEUG4kLlTXNXBs5NBxzvuNWkCBWdU4uKMBrw6vcadJHxacWALBuFkcsjQDMnVURD+Gqv+RYtIP7Ed6aIw5PKCgjVG4p4wMqrk6vmxLl0bPTUx44dvDzHIgRcCwYcNMmFoX3J8145UKHlT+x2h9c1AXZBDM9uWZbw+7ipbQW6q+mJ1fDEch/3WeAKadaywE1AQF3wx3+n2xIHsBNbBO6Cyh423vRjAK9vEmNm25Ljgzh4vdqXuZEOpMpvKbcRmcfbiYk4LbqFAjB+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82lCdk2C3nvWPQj3gFmlgFYVprJ7Ydr/wiVqt7jFTeo=;
 b=eJE0pBXWG6pG8VvDv+gpvAX7SniXS8JEadgSqaDdSYQ8Vsw6poFnSOrKal7CvM6J+K6nNQXhwLOyhKXBriYQBZnVlWtgS+9Zvi6q48EofuQElk8OBb5zoLmIHrE7RmawZxLESkQ2tO3Ia53WSgDk7RHyaa4cyZaU3P3M3TcLgSXJejzgZPK5vULm9zIQSYa0XF+PMprPntVvuTQjdOA3w7IYDxfhWAlBMyMXEl/1x4Xx27U7mXFZZtsAOQJQjMgo3B2VPfxzLK2z7qad+CAWx0sfBEirDIiz5oYskJxUw6Dp4iLIus/KO778wafWJZH9cZ8XU4UNE0PPZUGYsfvYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB5311.namprd11.prod.outlook.com (2603:10b6:5:392::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Wed, 6 May
 2026 13:44:26 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9891.015; Wed, 6 May 2026
 13:44:26 +0000
Message-ID: <56fd25ec-eb93-4278-84c5-c0a4c40e81ca@intel.com>
Date: Wed, 6 May 2026 15:43:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: atheros: atl2: remove kernel
 backward-compatibility code
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
CC: <netdev@vger.kernel.org>, Chris Snook <chris.snook@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner
	<tglx@kernel.org>
References: <20260506054035.23710-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260506054035.23710-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0004.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB5311:EE_
X-MS-Office365-Filtering-Correlation-Id: c5028d33-3d51-4a3e-7623-08deab759678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /PexYCUqJ2WgX/GgSdDU0LMAqpWUlZfKWGaSPIOXFziTZI3tspzHTpoibvKQFpWXmY3qXZ80SA7vm4NaIVe4L2SGsDHZ3tBAOEMLU6LqA+CrUi6AePyvJX1g6SvwZMw6sS4pGWS8kLwfMirCtzkcuCNOqs9oIrKeH17ThANVxVH74m1D2DkLlStszlviqMjhB5JfTZPIKUbBkYfZDacrLSk1uqWxHgS6MiyOjV82ae1UeG/5RElT6zvaqr5NuKS1DOSwY6pLvGvq+nx0FqOJf6Ez0gxPRlT/iBL1Omp/N6NtSrblxHfSx5FizYrFsdrtEWA5qNyXf6MKUBk9IHMFCIljEgoZES+Kyk5zheLbpQik3PIwCRfF2U7x44j9kLCk27lukgruKnn904E28ukL5K2XoxqL2Gg9uDmmEAwqiVLCaKCwR8BY6m1A8kSV+UIIdFXH1jPemgbSVPpZYZ2422sCMzBrl52uvTNnX7Hotjuq2MRPpCjDZ2tdmjsczdlkdXsFH9OhHu9tQ0823CS9l7CZi+d6kWNE34KBgPUqVslfjnWGf37dFm7WmBxkcUmxsdTwM0UG/hEZCHXiM2rVVHAX73L2AQBlONW75R0mXBNrsumdtjGJUXEpw/g8k2YKeUTsARTRprbJRpcUHhA/3O9S/EaEtBkjaOXSkYWHUJAqGbq/2eNu1g8Y0OmqFrl8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L25nS2JDUS8zNHBYT1BIaVUzdTY2ejdzY21JS0JXc3lCOHZmWjREdDFzUFFG?=
 =?utf-8?B?TXlHQWpqb2RRVzVSMm41ZkljQVNMazd4eERsSFY5alR1S2s1aElCd1c2a1ZD?=
 =?utf-8?B?OEVHU3Z0bkdQNGEvRjg5bEI0VmpkS0RISVdtSlYwR3NkS2JEa0xEUkp2TjNU?=
 =?utf-8?B?MWF2anlvZmhSZGw4TlM4UE9QSXFjd09nWVdWaFJrR1Y0dVB1S3BTS2crVm5j?=
 =?utf-8?B?RFJTYXIzUktxNUQ2TjRkSzNZbjhkYTlJVCtyWDJCKzRLczlEenZIT0ZZMnc1?=
 =?utf-8?B?WkpscSt1czU0cDM4SDhiUjZKZ3phYlpuK1RMUzZGM1dqc2htNnJ5WW4rRzQ0?=
 =?utf-8?B?M0d1WEJ0WG1VdjZzTTBPTkpNQTg1aGg4cHREUGJtWE05NC9PZ2xvcGdCL0Y3?=
 =?utf-8?B?b3lwazR3bUhteEtIdExqZ0RUN0gyS1ZnMjFQeDdlc1dFcm85OWQxaGhLb1BK?=
 =?utf-8?B?eVEyblhGSUNtV2daSUViYVIxQXovSmVpelZIMHZoTWxETmNhL1FwV3AyVDFU?=
 =?utf-8?B?M083Y0YyVTNGbWJjTVdUOFdDclFxcmY3WFc0WFVEL3Z5WjhqQ3J4MFlrN0ta?=
 =?utf-8?B?VjBNbDlNcjNPSDRxeVphSVBBQWlVa084SUFheW5BYVVSK3pzWTlHdDlMcDRu?=
 =?utf-8?B?bTZzcEpnOEF3bWs0bVVXMmppblE0clNtaUMxM3M3SFVXNGNxcG1sdjFiRk85?=
 =?utf-8?B?bVdSdS9KQnFNNzVWS2FLMHUxL3BkU0dKRlNRTDZSVURaalQzQ2gxWmpEYS9K?=
 =?utf-8?B?NzZvKzl3YWVlWFRhQkF3Vi9ZRjI5a3JIdFU4MFpQR3Nab0prWWQvRnRIS1li?=
 =?utf-8?B?a1o1dkx0eUxzbUE5UE4yblcyR05FRU40cnBjc3dQa1UxZytWU3IxNmduSEhQ?=
 =?utf-8?B?VTFhMjRFanFzMjBGOGV3WDVMT0ZWV1l6bmJXY0UySE9yUjFEWHFZZ3dJZ3U0?=
 =?utf-8?B?NW4wVW8vVVpRMFJUSzF5SnZuVlFCcDE2emUzTWEzS0tzdmpSTzY4eDdLbmwy?=
 =?utf-8?B?SEVNOGVxV1RsYkU3ZDhxZmdxRnkvelNBdGdWNkk2MS82Rnd4SS9ad09UL3JE?=
 =?utf-8?B?bHNJZkFUUWZOaGVtK1BLWExFUWpZSjhuUjNvblhKbEE1a3FHaWpHdEJxUEdQ?=
 =?utf-8?B?TnhoalJ0eDlENnEzVjJpOXUyK1U0WFJuWUphU0VESXNFd1VkMVFIMmFnLzJy?=
 =?utf-8?B?UGt0TlFmR0pVUWwycEU0SmhYRktzM0dsdENIbjdjbXM5NEZxNU5PNnFGdTdm?=
 =?utf-8?B?UURVdjNFQ0JPL1NTclhsVVdHOUNvOWVDNVl1SFV5aWZ4Tkx4bzRXN1ppaUpE?=
 =?utf-8?B?MzQ3cDByZGtYK0tJK1VFNUs5MTNKVldYVmZxTlZwNmRDSmUrOGVzaEJ2bE00?=
 =?utf-8?B?elhBWllnZGJqNElUdGFFTGtXaFAwNXNpaG9WYnR6ejcyR09ETEVaZk1UVDNT?=
 =?utf-8?B?a21laE5oOEk1TE1RU1U4MjZXZ0RjQjRsaGI4QXQ2ekFYcnp4UDVTUlA2S1dO?=
 =?utf-8?B?T25VUW1kS3c1Z3puZmYzSWczK2pneWdHOTcyK1g4ZEFrVTVrOThYOWtKdERw?=
 =?utf-8?B?WkwwK3ZiU280amd6dVdVVUd3U21OTkVkaXY3K2xIWHkySlM2L1ltcWJHRTFo?=
 =?utf-8?B?bVBLeElFTlV3SG8ybFFxRllpV3ZCbzQzVEpPSWhRUDMrdkZvdzhIc3lQVlpa?=
 =?utf-8?B?aGdDWkZyVzIzSjB2YVZMVEM2T1dmQXZ5Wm5kQk52NWxJN2Z5azE3YkJWd1NT?=
 =?utf-8?B?c3BQRGs1UW44SWc1NW44SUJmRDhjdDVvQStXeWYzN2J2QlowbFVrK3ZWVS9I?=
 =?utf-8?B?N1BIKzdubUdvNHRuU1lYR05aTVNBalh6M0gzWEFTTlNXU1NEcS91NFZPN1JX?=
 =?utf-8?B?RWdtU09yRzYxRGtyVS90UkdVSmtIKzNRWFZCZ0dxcVNvTVRRbkw0WGc0ckZW?=
 =?utf-8?B?cjFRQURsano2TnczMlRWUS9hS2pxY2RLTUhlRGtSSHFYTjJ2d1hrSTJtb1JL?=
 =?utf-8?B?eTBONys3aEpRMkF0ekhOcUNHL3cwMytsSCtSR2JaRzdNRmVaMjlGaE5UQldx?=
 =?utf-8?B?eGVXRE4xRjRjMFZjTDFCLzJJS0syeW1zUURvTVJsZVRkMis1ZnIwTnRtNjZP?=
 =?utf-8?B?a01HeWh6d0c0cDJMK1lMTXFUUUxZREdnNnBMOGlhK1pEWVQ4K09xWE5XSmFt?=
 =?utf-8?B?RHlOQUtNZkluY2hmRVJOdTVtUW9jNmd1c3RlUmhJcHB3UlVnWWsvYTZxbndF?=
 =?utf-8?B?bHRvSHVNTHJzc1kvQWZiZEloMmFxaUQ4S2hGRWZKNnpvV0drUnpjS1RlSlF2?=
 =?utf-8?B?UnVTcUQvbkdlN3pZVjlwMmVrNFFrUFQ4RlEvbFlta28xSnBpVjN0MVlDUVhT?=
 =?utf-8?Q?KEdUtG1vSJfYnQw8=3D?=
X-Exchange-RoutingPolicyChecked: NB437qyzCqzNqXoryCOjA68lVkMl4LC27sj7AIXdo/ICDcl9qSpXFS9tIp5JmVpZ9kLB13WFvHjaMljP89a+hCqpdAjk519zkQIRMagtxtOkvrIQyPxzVvov4y7ONffYjmCkTGmlH+gsIp9mLEhPhgcTEjFntjo6xKrohhZc5FHlkPqyNjN4nfRJmuCoisszYD7mq3XP0E1GtLuFP8PZukCbN2XQt0sgn3VEbaqX28EUQe8wZUVJCBXhZ/CDACONCBiLiF0zLQMWc588orVF4OfUhg2qwbWeTGTgcTqpBQUA7cOW1l5cgRjrnvhSi5Mj9QPWgLmhFlfW7LdaczdN6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: c5028d33-3d51-4a3e-7623-08deab759678
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 13:44:26.0799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xp5izMXkPJHxl21y33BJR2bXVMA1P3MrOgLzpSPW1PJGHV82O8QfyeWgVqloDJGu4OX5P/PYe35N7Fm7ZNERT+Lhtt7bA7rcQgFf073gTAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5311
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 205EF4DB50D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284846-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue,  5 May 2026 22:40:27 -0700

> The atl2 driver contains code for compatibility with old kernels that
> do not support module_param_array. Backward compatibility is
> irrelevant because this driver is in-tree. Remove this unreachable
> code to simplify the driver's handling of module parameters.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  drivers/net/ethernet/atheros/atlx/atl2.c | 37 ++----------------------
>  1 file changed, 3 insertions(+), 34 deletions(-)

Thanks,
Olek

