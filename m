Return-Path: <netdev+bounces-198184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DFEADB87F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE46B7A2F3E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C25288C16;
	Mon, 16 Jun 2025 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUPMVgha"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342EA1A073F
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097263; cv=fail; b=MAurfGFtso4FmB+WixrY1E7W9P1f7b9DGNVTpux3nM609VDCM5GnDDjZ+GHi6ZxUUtmBVJF6K6ZWsERIsYU6+QgSSoW5ykEdRyhkdXP9K5xkD17LBaV954XuSd5EkovaOh/3R6p+PzEvu5K4mZZsg8NG1U+w0t1CIpMgq17Ix6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097263; c=relaxed/simple;
	bh=Y71xTF+i5VKabl14pNmq9u+pfhKFq0ZskIZF6Jb15Mo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dtPO19yhOSFu0s4gECXA7ay8RP9H6qb8EU6G/P8QxbhBFagVBAUeACB3e5bybhPwye7whaN4Q/WJg1PpqIjXFu8DiwzH5zxZ0gre3IC3XRY1vd0e4jhx14JUyrnvw/XJjCUpe4mCXROsFjC30UQPY6oTuhXOJwXnDMPtXvmVT18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUPMVgha; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750097262; x=1781633262;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y71xTF+i5VKabl14pNmq9u+pfhKFq0ZskIZF6Jb15Mo=;
  b=QUPMVghamHuQqR3twuT//EBgsFOVitv4fyRKLGLdrOOY0G0djaRAy/8M
   Az9N0gYO7xTnDg5tlieoR7pKk/aw466HnE5VuvXKLhEDIHs/VErjhXIZw
   9KRqRiL2omfIzi1Jq76U2AEQXqS1LVFbOdb+LXr//ill9ndfXyWaa2FUn
   7dCGXAD0xtPCLzLFuAVPiMixCtvpclIf3nil9GxPw3xzQwiux49Bw/uBu
   L5mC99B8XdSn6pts6cV4Ak8EG9VTyvtn93aYkY1TNu7uDY7Fq0HJeqH/i
   Vb38tFrUmZ9n7itdnyUrcxoyjicrOQ0YBfhBgwBFHlaLZlb5SPh0E6RII
   w==;
X-CSE-ConnectionGUID: UolT3UBvR5CG6w/xfzsBqQ==
X-CSE-MsgGUID: 5hDyEYswST+HKFP+EAQEBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="69695570"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="69695570"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 11:07:41 -0700
X-CSE-ConnectionGUID: 4ikYLnv6REWpgyH3+9DErQ==
X-CSE-MsgGUID: 74ohs+ORQ8yJD3pnC42TFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="148374947"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 11:07:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 11:07:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 11:07:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.78)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 11:07:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4mcEjN2dhIa4NhsBS5miIPe5/VngG+Zm9cJZS4CmuVw+D5l/FxYqAtmJPkrBCHBWqLGHYugDpJsBXafJ+qU+nnq8/lLUi3nIuI18XmY9/akARcur6XJvZwhUF26J91/375gtjO+f+4SKLnLjCqoe+UOwi1B+hvKyOYG1NAraPObv1b0VRLIyY8Tit77rRCKj9zIJciG2iJ8/wmncSr50y36flIPM6P85rP//hBSkj2pYQ0L9mVtEJvOz1//IJwkRy56Vail4mYMZphtkdj6y8H1rz7hvIvU9Vwf/AYtfvMDjpCks3SYwRmnMLiR/MMknoXxrgFsF6HJKASwrkc3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORb5z2IoIMKn3eVPX5WCcQEnYEFf9XZGhbO+uFJNZvQ=;
 b=RoPbBpKf9D4HYVQwlRaCmZmOWsMhzwsFBD7p7Wl1sl/Gz49wGUJr+xzvdAEeAK+RyGjhpKa5u/Qd+MaPKPQkjYxMJi7dmP06shSSTz9fD3VTXpwD7PFPFTgPg1as9cV9o0k+eZce2BPPpgCuCIA2Bkq4jQnSYDUsCHgNap+3yWoQX7We6i9Nb7S0AitLp8+9GpfXfLzOAcpyNCqlaerFX3GNlE3luVqGXosGkAb/ppnX/+LuZV7P+x8sTuA3WLK0mPp+ZkJAeY9WKUk34eY1NXMTTeJJiqO09haSUWLh72TmF30f53u5T1lGR0fB/tugo0nCgtvNoC7TzmwCOBvNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 18:07:36 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%3]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 18:07:36 +0000
Message-ID: <10b4c1d0-2f96-48ac-b218-a701d027afc2@intel.com>
Date: Mon, 16 Jun 2025 11:07:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/5] eth: e1000e: migrate to new RXFH
 callbacks
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <bharat@chelsio.com>,
	<benve@cisco.com>, <satishkh@cisco.com>, <claudiu.manoil@nxp.com>,
	<vladimir.oltean@nxp.com>, <wei.fang@nxp.com>, <xiaoning.wang@nxp.com>,
	<przemyslaw.kitszel@intel.com>, <bryan.whitehead@microchip.com>,
	<ecree.xilinx@gmail.com>, <rosenp@gmail.com>, <imx@lists.linux.dev>, "Joe
 Damato" <joe@dama.to>
References: <20250614180638.4166766-1-kuba@kernel.org>
 <20250614180638.4166766-5-kuba@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250614180638.4166766-5-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:303:8c::10) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|IA0PR11MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a5254c-cd85-49a6-c039-08ddad00ac62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEU5U0hKV2lKT3YwakxEWUZLbTh1QU0zZmQvWTN2bDdXNWl2WEZhaURxWXd5?=
 =?utf-8?B?Q3NxM1VaS2tDclZMMzBUcmhPcHhqRVk0L1ZPcWtTQVVGN3psTk1mZnZBMGtX?=
 =?utf-8?B?cm5RMEEzWXhTQ2JyWDZkNHpsOG1kd3JodlBSYTRPZ1grWWZnWHJreFhPKzk0?=
 =?utf-8?B?MXlqK0dSY3o4R1M5NDcwcHQwUmZFUGxOL2Q0cmxGTjVZazc1VngxRWdrWXlF?=
 =?utf-8?B?QThhdjF5YUJmanZCN2pXQ0s1ZDVEaEgyWWpTdmlTcWVrbXFqM2ZCZWlHVWdG?=
 =?utf-8?B?OFhKNzl6VXFiL09LWnhCcHFidngxaWlhTzZPR1pORTNnU1pYSCt5QmNLYXVK?=
 =?utf-8?B?K0tmUnBqWkhIaEZlTXdzVExOakVxbitzZXFXVS9tOUFobXJaVmFXUkM0Um8y?=
 =?utf-8?B?MUc0N2dtVERud3M2ODJrV0FRZzlTYytsc1VEK2hHZ0tINVBWZEpJbytjOFo4?=
 =?utf-8?B?RWJPL0hmaGdqRmc2Z2kzT0FOZDhJYndFeEFMUlA0eGN3NzNaV0dJMmZVSkp2?=
 =?utf-8?B?TW1KREl5eUpobGJ2Zkg5c0lPekd3TGtRMkxzWG9CbFhEWGIrNFJ1a0JqYVlq?=
 =?utf-8?B?dys0REU1MTdkbTA4YUUzdkp5bTFsU3lOc1hHeTJKWmZpTGtYc2JKQThROFZB?=
 =?utf-8?B?Vm5JSGo4UjZxbzU1SU5UaHBMYWdESlFaWm1Xd0x3UStKWFFTYVRWaFF0R2Vn?=
 =?utf-8?B?UTVENWx5eFJCVlRGMHJYbG5hVzRNMlhyamYreUkrN2hXTWR0RjhMR0VGM1Uy?=
 =?utf-8?B?RXQvOUdrNUxjbndsZjIwSmhVTklaS2NnbE93YjMwY281bnE3dW9nbkYvZkc0?=
 =?utf-8?B?dFBETGxzRUMrUHZYM1dqMlVqaTNFZjZSYXp6blh2SmxwaVNSRmFUbjZIdHRX?=
 =?utf-8?B?NW9adlBKQ0c0OVg1RGtjYTVQWGdxZjNTMXVXa0gzWW9IK1l6RjFZTm56Y1Iz?=
 =?utf-8?B?RElqalBlZnZaemdYZFJGWXFpckhoMjU1L0xDd0FxbmZhbFJ1a0dpOVBubEVw?=
 =?utf-8?B?NzBmTmF0TE1DRmJZTVM0ZGxBSmtTQ3ZlN2xvMEdCbHlJMkdHUkNodU1SYTJV?=
 =?utf-8?B?R3Zid2xpODZweFlOZHNLK3lDV2szMFVsQzBKcHhjVGtjMEZRcWd5S3M5U3F0?=
 =?utf-8?B?NWlqK0VubW1ybEZHdC9wWURsb1lpVjdqL1UrQzdvNWNLcFpmYzhiR3QwVWRu?=
 =?utf-8?B?OGVFVlQwTW16ZzVlblNSNElOSmllcGZFcTNtZ0dsZ2NCYW8wblMvOVNZbEtV?=
 =?utf-8?B?Ujd5S1NLcHNjZTRoQ21sbEhEeEpzSVVDeWU0dUdGcjlJdzUxSk9Oc0dkaFVv?=
 =?utf-8?B?SXlSZ1paSlN3SHZQbXpxSThHaTNINFFXSmg2NjZxV0V3d0E5Z21tbzdTdUdP?=
 =?utf-8?B?RmQ1QVE3TGEvdS83RHlibjIrdnJKUFNla3pWUHdUdWxORW5MNlVobkdETStG?=
 =?utf-8?B?aHVoZUk0ZFYzOHFpYlFHOUlQSGdiVTNZbDBac0lyT1dKblc4Q09RM0dJejFC?=
 =?utf-8?B?WGtzVmNwLys3TEdPblpKSjY0Rk12SGQ3c0kyWVVoalVqY3VPcTRiMUtIeHlK?=
 =?utf-8?B?Z0Z2ekJ2OWNFN09oUndVWHVEN250dEtNL3RZSDdGNm9yaVFPcWxjd3dpWElX?=
 =?utf-8?B?dVpvZnIxUGo2ZnA3WDdUaUJ3cGlnOUlIS0hlZFd2SmxWV3MwTzVzUmF5R1di?=
 =?utf-8?B?Vm9tNllmWWY3aW9aQjFxSFJ3Z1VyaEgxcmZPeGtEOGc4OFZIZW4rekVxRzEv?=
 =?utf-8?B?YThOMkZhakdpRndPT09KTm9DRk03Z1dkMEQ5VTBHS3ZQVnlUNHEyUkY1U3h5?=
 =?utf-8?B?RzByWEJPbEJaNWdRcnJYaysybjB1UmRFTkNkcjRodXJVQWVIQ1dXTjZtZkxn?=
 =?utf-8?B?Nk9YUlJubEtoekZpUmptaXFoTlBQUFFNWTVVc25xeU0wTHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRvTmp5dWxQK2JjbDRXK1pIUlUzNzFLNjJoYm5mUkp3M3A1SEw2TmUycUdn?=
 =?utf-8?B?bVVTSGVmWlA3T3lYc1NySzJLVXgyZVcrM3ozL0ZmbGlmUG9ocTd2eDRrREdm?=
 =?utf-8?B?RkNQMDdqeWx5clFiMkdkYkVDYUNrdTdySnRRMWFhc2F4U2RjTytnQlJNb3lN?=
 =?utf-8?B?NVRmMUNLSDdSQ2liMFhwUzhPSHF0Y0VXZjZxR1ZORE5qOGY2NTJka0RNOHJX?=
 =?utf-8?B?ZG9NeU1JNGZTbnc0MWhxZkpPcS9MRHpnY25hSElrU3Fwamd2cFBvbzJISXJ1?=
 =?utf-8?B?clJwallxQTJXQndjVVVVM21JWjFzL0Zhb0szSkF5UVgyNVRBQUNLT3JYNzc4?=
 =?utf-8?B?ZWVGNHE0Z1IrKzZtbHRqN2JwbEE3bFFHUFhZNER5eWtwdk1xWG94MDh2SSs5?=
 =?utf-8?B?Nm9rSWlMWFY1eldxbFVjeEZQWTgwcXVsMUx1V0t0VnZ2Wk5CaWdITkh1anZP?=
 =?utf-8?B?NHI2dFN0ZFExY1M1Y2RYd2VmNm15VkxHVDVocUw5TWd0MG5wei9jWUNiaTds?=
 =?utf-8?B?THRTbjdDOTErLzhDdlZwNVhDVExIWC84dndmVEpLem90UUhUSWJZdHNOL1Qv?=
 =?utf-8?B?cTNWVjI0dFkvM05sNC92V2dERmFXaTFDcVdxY0Y1Z202SGhWb2djSW9tOGht?=
 =?utf-8?B?MDJ1dFBxMEF4NU04VGpoaitVdUJFVEZGeUVMdk1uWW1TRDUxVWJjQXpJbGhR?=
 =?utf-8?B?Z2xCR0hBd0plZDQ3WDhqRGNsd1VoNGNMeTBpSGc2ZXJEVEd6dk5WZENnYUNm?=
 =?utf-8?B?elZtWlFsMS93eUNFT2VCM2pEQXd4c0xiWmxMQlBlZ1lFSWtzeDRDN0cwcTZU?=
 =?utf-8?B?endpY3NBTzM0REJ6OW9nbVJlelkvSmR5dTduOGcyKzNIMjFuWDcxRzhObVYy?=
 =?utf-8?B?a0dQTmJvaWs1WXRRbHJZWTc2YzF0SEliRnhEUno3OThUUnVHYnd1bEFGV2Vk?=
 =?utf-8?B?VDdVWkt5Q09sYWJXcVlnZFlTTmpDZnVHOG55M1BGMjhNVE1vMkhzalhEUnNz?=
 =?utf-8?B?NnpEdkovdmZtbDdnMGJRbk1MUzhHUVJ2OS9vYUpQVWh5T0l0Qjdac3FJMzZx?=
 =?utf-8?B?dFNqRkR3MzBJL0hpQ0FqWTUxOTJzWkkyM3F1eWZSZTZvTTZYSnRsNkU4QVlz?=
 =?utf-8?B?TWlSbHlKbzg1TVZVT1ZnSWhIeHlvYkpQWW9IOUttbFgxSmlxZjl4MU1vbjd5?=
 =?utf-8?B?WStzaVV4L0pVSGluNDJHcHQvTWJwbUtNZFlWdHlpVkd0MEhxTVBNV0RMT1RY?=
 =?utf-8?B?ZlBlbVpRWndGeWFzQmQ3OXE4b2k4OVlLdWI1WDRaL0JHclRzb1FGRGNOMjYr?=
 =?utf-8?B?VTFYYTk4enlFc1FObmoxNER1ZUNybGQ0dUZ1THMwRmovTkdhSkUzdi9qcVpt?=
 =?utf-8?B?UEdGTXp4akVwa2NtTVVJYnlKODF5RmV4ZEh6UDEweFVibElycEJlK3lFcVRB?=
 =?utf-8?B?VnRuQzZ5U3E0UVlWSDNyZ00rUGZnVUsyTVcwUEdBdHgycXI5MXNlSVFsYVlm?=
 =?utf-8?B?eEtkSURma1RPWGJTaWJjd0VWemVyUFBVMm1INUVxUWtXMzd4b0NJK1Fla0hX?=
 =?utf-8?B?c01JRk9WMHZsY29uM0szOVVObXJMTXdZUFdQSURGbFA4anVOa2xEajdDc2tv?=
 =?utf-8?B?TUcxTWI1djhGbVhNTVNxV1Z1Tnd1OG1MTnpsS1pPcE9WME5Va0JmdUg4OGk0?=
 =?utf-8?B?VEZ3Zmw3Szc3Z09icUxyUUtwU3ppaHVRcTU1aTRBMEQ3bnZWalRGT3VzN0sr?=
 =?utf-8?B?LzlURzVRYUY2WmsvRjQ1aW11djREL0tDWHdDYS85dThCZDlrVjd1RkVwNjJS?=
 =?utf-8?B?aXVEblIwM3dxNDdkZ01oWThaVVFDaGVldUFVb3NKaXNFSmZWZjRFUVlDeDJG?=
 =?utf-8?B?eTRsNVFwVU8rYmt6THRTQTZzSjMzbTd2ZTVPWEpJQVhDeDdJOTUxVWplZHlw?=
 =?utf-8?B?K2ptODJMY3piNjR5V3dveFl1cHNvNHEwYkNGVVdFR1ZaY1JTeGIzODM2ZG9N?=
 =?utf-8?B?MnMxaVV0ck5LVWZidG4yTUlNZ3BNZ0tSK1gwOUJhd0dxNEUzKzY5YkdlMkFj?=
 =?utf-8?B?VEZ5L2FKRmNaeGJiVTFrSS96ay9WVzlrUGFtcVBZbTByNEIwVHFES2ZnQWdJ?=
 =?utf-8?B?Y3dBK0l5ZDRQRlhQSVI3blNrZ1hSdDExQXFkYXhjcDRyVEZxN0hqaVVZT08v?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a5254c-cd85-49a6-c039-08ddad00ac62
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:07:36.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huaglUfItle2SOAuAw9DI7TTP/zFzSns8QfgELwqSMKH14CcdWmidTayb4QEPmv2LLvI+2lAP0NdDQNdGMrX4rfPR2NrnED9y5j6Pl5ku34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
X-OriginatorOrg: intel.com



On 6/14/2025 11:06 AM, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> This driver's RXFH config is read only / fixed and it's the only
> get_rxnfc sub-command the driver supports. So convert the get_rxnfc
> handler into a get_rxfh_fields handler.
> 
> Reviewed-by: Joe Damato <joe@dama.to>

Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

