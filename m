Return-Path: <netdev+bounces-106818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6B8917CAB
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F051B21C3D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70A416C696;
	Wed, 26 Jun 2024 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuXKBbNQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968C16C854
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394732; cv=fail; b=tzYA2Zm8Xx4dukYEmMfqibDUL18x2KUTOw4Vz9p8/FaD6LgmsWKDqNFDXhHukO+ASqKavT04nHAZiZT66WUzNAEd/4J3CLjaUmBhi+noQmxU2WpzZg9db3l4oqKxxa5yCP0eHcham/PVqydZNL9LArYrQKCrVrUkJ7gSgFQjxE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394732; c=relaxed/simple;
	bh=57NLpiknwRl3Blu8XfJiXBCGMQCGCLEesgIzxzkHPz8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZSW/yvezKwxGareWf3MyFQvsKzxoLZQLdsJRUEGwkKE4aq+bqR/Q0eBYmuTc0VcK/JYPfOHJvG/+4kTnILP9CKl4dABPlpXYj+NyfSJflubWcn9sMQsbXgOoSZzjIDiehJQRcV04IqXfClUOwJ+UEkk55IkH4p7YmtkTqIhcPtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuXKBbNQ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719394731; x=1750930731;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=57NLpiknwRl3Blu8XfJiXBCGMQCGCLEesgIzxzkHPz8=;
  b=OuXKBbNQtZ4vIF2yYlJfvTTeYgn8i8e4m34yVXdBZpGOi093nsipX6SO
   F0E2HC7hBx1A7HRzrm45sorW+Ve/8x7NOAOxI4y4pyMdq5yIV4GrWvque
   zIEqY1xba5bT05W3ZEMd8DbxPLLRB9P+zohMHC7Yc9woGDwzKUozpBiRK
   iEQdmv7wnCMCsNTsGsfvZhKx4IFT1OHnKBwD22FNo+EFsVpvEPjuj1sam
   G5GTJ2pNUZBEFss1Ihhb3ElG2AXS3c+NlHrM62M6a/lhknf3I7iWFjjwm
   F+1VDV0ktmhRFPWrPmDJFbSNUGPq7CDRUCUTCoPWb9Nm3f/C6y/vyDon6
   A==;
X-CSE-ConnectionGUID: QPpDvMRzS8mtgVcPWzD2AA==
X-CSE-MsgGUID: bs3f1kMJSp+pl2zLktfeew==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16586113"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16586113"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 02:38:50 -0700
X-CSE-ConnectionGUID: Bkgx3riySeaZ8/ifKaduaQ==
X-CSE-MsgGUID: 3DKyfkvDRzuDL7XwkVheKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="43835171"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 02:38:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 02:38:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 02:38:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 02:38:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fe0YDfOiWfr6nWL7qHb9q03PgulnSLta+28TkRE1AB2am0BGBhbZR7VxnPWTT00FfXWyFA7NhAhHQd/5phEQqxY/DUdo5ld7tklJ7bWlyvSmAZtHDB/kVJtxI1kuCCgRkWMzIW0cVDRtkp7gO18oSblCoaN4rARH2a3oVGr0bc+Xkq3C9nOQY2t5nv9hDYcsMZTyKAiieUHWM/5flqB6rygrQ0w5HRWD5VyuJSFh5a9/ykLcXGSiCMrtfFUfBkRBGBUHoX0k757YexkrZ/bkmRpdb0BZsE0+jbR8qk6lqiUeAPJwmk2ocLO3NhJKFzoO/bR6JhrjQ7gEgQvEdB/vjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CM50WYH6cXArvjBAxmOViBDQMsCF1aS4Nf/EZALMTa0=;
 b=Twdz73v1dA6oZJLGLJS/ptmq9JQumNjj0EG32MUIADt5TsTfjqd4GmUutT0VYSHTGMFCxuKA0TQOxU44Q30Ij0U5g7XXGrFMu8L76VVbv8bPNKI8YreuP4T25CXDx7WmvSZvnw7ZRwCjkqmHtKUkd770XSO+8wcR3FtnRqbe11fj+NuhfqxxIw2vGmCQbJ0rRkXE43vI3LfmxEKgBOQfWopcrklyrmYRYUos/eFhZOHuG2YWL8Uy5hgNG0ZDxg/9uC13yHHa1xRuvdEw6cTvYsRj0DyoS+3n06nTzUTwx+LzM1Owa3BWKv9uOFA0GIyl8U+dNNy6gNAJiMIQRlOkYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN0PR11MB6301.namprd11.prod.outlook.com (2603:10b6:208:3c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 09:38:47 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 09:38:47 +0000
Message-ID: <3e0baf8d-941c-4bce-bf21-41940c3227ac@intel.com>
Date: Wed, 26 Jun 2024 11:38:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/2] selftests: drv-net: add ability to schedule
 cleanup with defer()
To: Petr Machata <petrm@nvidia.com>
CC: Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>, <leitao@debian.org>, <davem@davemloft.net>
References: <20240626013611.2330979-1-kuba@kernel.org>
 <20240626013611.2330979-2-kuba@kernel.org>
 <d7a8b57d-0dea-4160-8aa3-24e18cf2490e@intel.com> <87tthg9hvv.fsf@nvidia.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <87tthg9hvv.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0096.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::37) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN0PR11MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d40bd50-100c-4fd6-3d07-08dc95c3c766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2dPN3l5b1FheVM2U3lJMjg3UEdWaGJLVm5jWnhuZmlKK3A3NFpRTFpnaXlL?=
 =?utf-8?B?ZlpheXNXa3ZnNnRWTlNhLzUra3NxM21pOEpENFVvUGlLbm43akpMUUY3MGJ4?=
 =?utf-8?B?NGllQk1vWGRwYnUyRkowV05LdnFSU2lsT1BwU0RZKzI0UTFYbWdQN0NqcVRq?=
 =?utf-8?B?YVdqWUpLbmhpTGhER2F1eHg5aGNnNUU3S2VrQXBKOXQ5c29vQ1cvMzM4SFVN?=
 =?utf-8?B?M2VpUkZkamsrc2JhMWw1dG16OFZzM2lFVHBZQjVHbHBFTVpvSnFzeW8zbmhC?=
 =?utf-8?B?dDE0QjFmMHQvMnlWYXppTlp5NlV4cFRlK0R3d2tHZ283bkwvZ2d6cnpaclNV?=
 =?utf-8?B?cHlKSmN3eGNTVjJBR1h4eVQ3bUtIRm5kMzZnM2RoN1pxc0ZPV0hSZXZ3YTln?=
 =?utf-8?B?bDlGWlRMbk1pNklCSGJuODlNcWN0UGwvd01uSXlxd0d6TFMzci9nZkYrWjBN?=
 =?utf-8?B?cHdQY09McjJrcklNZkZkWG1pQVhDbTRaYnFBYnFOQ00yV1ArOEVWb20vS3J5?=
 =?utf-8?B?bnc2dXI1UHY5MEJYZ3RtcEZSemExZ3o2YjNad2tHdW9pbTBBbnhDa1RObmJp?=
 =?utf-8?B?UFd1N1ZBRFpTNnlCZ1pCeXRDYjAwV3JZVCtRMndaNGRyRHFJSjJyM0M0SzVT?=
 =?utf-8?B?WHpXTHZOck84QmR6NDZpTzdJeE9MRjF0dDQrOFZVWThKY1g5RmZhY3kxaytD?=
 =?utf-8?B?R3RScDIyZHBYakpxWGUzb3BvYzhQREdtUjJPVmd5S3lZaVRZRkFocDFudlZs?=
 =?utf-8?B?d3JVcjAxUUVnTjB1SWYzTWY2YnArSHNZQzFxaVhFVWNUWHFSdUtjYkdxdmJ0?=
 =?utf-8?B?NHc4VzdyUW1yNVVKS2wzQ1cyempjZGIzMUgxeDZ5aG5CdkhxZ01UZUN1Mk5i?=
 =?utf-8?B?S1ZMOEFSQm52a3cyRXZWamFGcStjSy93eDJzUlh6TjE0YnQyUWRaZ1lQam5w?=
 =?utf-8?B?R3Rja3U5aFpaanAxR3BCSGRMdDRGRUthUFIyTXR4MDRaYmlFUG9zM3RkZnZI?=
 =?utf-8?B?R0tuZ2orNzdmMWdZaWRibWVEUkZhLy85ZXkwZGZHYXVjWnJoSUNFOENidnlU?=
 =?utf-8?B?Z2ZLeVB6SmhYcDR0clV5cmdJdnVSY1NpM0F2ZFB0a2tDUmcrSDUvUlJzdUtO?=
 =?utf-8?B?YVE5QkxnZHpUY1R5OXI1Z3lsS1FOQjl2T1ZNck10M25jcHVBRUdjcGN3eGNs?=
 =?utf-8?B?YTUwV0JVUkh3bFF5RlNUeVlyakZzckk4MVMyUmM0a1FlbHlHUlYxSEJiUjlv?=
 =?utf-8?B?SXhhNUFNYTA5bm1iYjFKTnM3MC9TdDg1YlJwT3htNUVaYlFRNFlhSG51NWl0?=
 =?utf-8?B?aGFFNDJrNG5Mek9DZUtXZmFjYSt4S0VCYjJ3ZzVVOTdmZE1SUDQ3cmdDRHd5?=
 =?utf-8?B?Qm9ZR1FpNnlOOU5NNXo0bDA5aHQ0SHdUNGtsM3d6cEw4cm1oOE93b2NTOTE2?=
 =?utf-8?B?VjB1RERHNkVRWDFFcFl1Tm1LclVvQmlSZEExSjBKd2VHQUk0VE91RzNXdVlp?=
 =?utf-8?B?cHFBQW9XVTByM1lWRVZIRENjZnIrcVNvcFR3cTYvVzM2Mzl1cVdtMmF2WThz?=
 =?utf-8?B?ZithT2ZrVm9yNFEyZktDdzB2VTMrTnRzOUsvWEoxNytjN20vV0taTk1RemRJ?=
 =?utf-8?B?eGxVN21GT1RsOGgvNHZ1WGNJQmM0TlJ3d3d0ajNUNlRBQWJmM05EdmlES2Uz?=
 =?utf-8?B?aC92bVhVR0puVVZOamdqNFlmb2EvK1FIYlNZWGlTdGVWblMxaThnVnNJWWRO?=
 =?utf-8?B?TnU3SFo4NVZzczhmc3pXTHFlV01YbEhjSU9FOXZOVWRkOGJyTk85bkpDcDd5?=
 =?utf-8?B?eWdJNUtqYWZGdS9WdXA1UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3FROFhjdGJ3Mk1Ka1RzTFVaUGpVQmZBcDZYRksxWG1DeXJENEFTSkdLZEhj?=
 =?utf-8?B?aUJjM0cyK3IyVnMxRzhnREdacnlUK3lZTkltK2Q4QVZSbWwvOEs5MjJGMk52?=
 =?utf-8?B?ZnlidS9UYWFaQXpGd3BVTm5aK1RObUJqSlFMSVpmSitzTVV2c09hMlhqZk0r?=
 =?utf-8?B?OS9yYXJwUUdrZ21sM29jbjNMbGJ6TmY1S0pUbnB3WmsrZGNaKys5V0x2ZjZI?=
 =?utf-8?B?OTdMMnJmZHJrQXNHVnBIMy9xN1BaOHdMYkl5SWV5STdmRHVGT0VhaEpKbm1T?=
 =?utf-8?B?T1N0MWZobjdTclRsc0dyQW1iS3hxeWZiVHZCbVJiZEZvUHVmaXpiS1NtVGhI?=
 =?utf-8?B?azQ5UUgyditWUEpnYXlGcTJacmxPWXV2OWJwQXlRcmlNQ1FNZHZIV0owOHpQ?=
 =?utf-8?B?Y0tsN3lYMzRqbGtyazM2L0NCcjhIWXQ1eGJudGFneGVEZzh2NnliNVRPTWlT?=
 =?utf-8?B?TGNDSWhzNUpLMkc0dUFtdjdzTG84M3BIL1FvODBqb2NQZXAzU0tRemVMamM5?=
 =?utf-8?B?Y0liZHl2VXpJd3hlclBkNVBoZnlxQldyTmxuWW9QeWhLcU9Cb3ZUL0hpdVVI?=
 =?utf-8?B?Nkk5blJkcGV0cGl0b1poMzlvVHUySHlNSDB3cDZLYURvQ0dPKzQ1eXh5VTds?=
 =?utf-8?B?ak42cTRGd1A4U2cwYU9uZ1luZHVaT3VWWmNKaURmOWR5Sk9LV3BKZFUwQ0x2?=
 =?utf-8?B?VHE3QmhNVjc4QlhIQmZYN0VaNFFRdFJZOXhQVjhIN3AvSEh1NVlORmxHb1V4?=
 =?utf-8?B?Vm53dHRvaUJROEZqTG0vSTQ0SFdROE1DZDN5VlZKcXZvNCswZnpCMExxSWh6?=
 =?utf-8?B?TE5vRjA0NktHU3VJUWF4ZEkvc2Q4eWNBNllrdE1oeUhhSzlnK3l3SC8yanNt?=
 =?utf-8?B?N0xQRk9MdFpFeGdHQjM2bFpKQ1BpRW5RMGl6VndNaktpVHdCdXBHQlUrNG1n?=
 =?utf-8?B?dTdwU0IrQlNHU1k5ZjhMOHpQcXZKRjFvRmk5RDBKWWh5WXVXOGdxN1lXb2VD?=
 =?utf-8?B?RmdSZEVua3FBSm9SbUYwMk52YnJwSGh4ZTRQVFFnSFhXUWMyYXBDSENkNzNk?=
 =?utf-8?B?dTJKazAzdkNZRjlGLzk1eGxobkVYMUM4R0JkN1prMllQZTh1Smk5eXh6YTVV?=
 =?utf-8?B?cXBjcjhRZkp5V1liMjgyNmhYaFN6T3N2dHBKeFF3dEd4RkFsRUhsWkJQbUF4?=
 =?utf-8?B?RExmaDBlSGE0RjNoSEZnYlZqTE1IT0cza2hZVDJQbWlNMSsrVUt2dWxCYmQ2?=
 =?utf-8?B?VzBBaGhYb0tUNG9yTW1GMXUxUEE2NFgxMno4Y2VRK0hWRjNRYkM0RVNaNmJz?=
 =?utf-8?B?VVdLWjVab0Yxc3E2ZEJyTk54cVoyaG9wSDdiVFBMOVlBVlN5WUNSZGhUb29X?=
 =?utf-8?B?dVNXUjNEUmJjTW5Rbk44VmFyQzBMU1RHYUY2d1R0Ykk0TTlhSy9YSTRYVFgw?=
 =?utf-8?B?Y0pnU0ZXblloN202K1ZRQ2NmdHl3RzRDcWtVdi96dmlIQ3lVcC9lbDY2aWxR?=
 =?utf-8?B?QVZlU0dyb0pTU0lpaFQ2bUJRUEZrU0RHRFJCdkM4MStJdnY1UTNaNTE2cE5J?=
 =?utf-8?B?TDhFWG81VkdpK3ZVVzY0dUNDZTNJcXIramV2MThrRmxtQld1SmFXQWF5Rk10?=
 =?utf-8?B?Z3BzZ2V2R0RyZy9QT05lUTdodmR2bFZlYXlTc1J6Y1RXeU9US2VNZnVJbTVC?=
 =?utf-8?B?UHJnMzZEWWJDdWRjLzA4NTJVUXVaa3JTLy9wcVZzazQ1STAyZGV5Qk9jUkJj?=
 =?utf-8?B?clJiYklqSG5PZTdTbXVKRGFkTlE3VkJHbnMyTzdWUGEvMHFqeEhkUlB1VXo2?=
 =?utf-8?B?emY1aGRuT1FwMVJUVnFjYzJqb0lKN0x6b2V4ZHU4MnVOQ2NTMHhwckZvWW5M?=
 =?utf-8?B?LzBUM0lsS2tFVk43YzFtcndQQzBlckJjK3JsaEdma05zSlVGUUpsdU10U0pF?=
 =?utf-8?B?ZlBRa0MweGRDL3J1dVArWHU2cC9mMm0wQUpRMmZ5TnNHREh2RWU0TXFjQ2dk?=
 =?utf-8?B?YnliR0JKTVlsSk9EQnZiUjJZdjNPSkxRaExrcmtUMVpLSE5sd3lCMFAyQ3Y4?=
 =?utf-8?B?OXZkdHRURnBURFQyeFQxN1N4VHBTS0wyTjVqWW5wdGVPdWJXMXJaWTZYaG1I?=
 =?utf-8?B?T0Vyb1ZMQ1N6OFRTdGNTaWthOUQ2VU90dmdwYjRYeStFK3F2TTM2UkhQOVNO?=
 =?utf-8?Q?mLCSegTD4jP0P7yFV1hDCw4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d40bd50-100c-4fd6-3d07-08dc95c3c766
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:38:47.8081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovBK3i9252RFo4TIhrQ3jwD/+fGie/CHFrriukTEgm2hb0ofMqwH6qSL+yPjsLiC6yqA67UsxILEkPlAv4l050a5TAahcpDCrp2sCfi9QJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6301
X-OriginatorOrg: intel.com

On 6/26/24 11:19, Petr Machata wrote:
> 
> Przemek Kitszel <przemyslaw.kitszel@intel.com> writes:
> 
>> On 6/26/24 03:36, Jakub Kicinski wrote:
>>
>>> There is a global action queue, flushed by ksft_run(). We could support
>>> function level defers too, I guess, but there's no immediate need..
>>
>> That would be a must have for general solution, would it require some
>> boilerplate code at function level?
> 
> Presumably you'd need a per-function defer pool.
> 
> Which would be naturally modeled as a context manager, but I promised
> myself I'd shut up about that.
> 
>>> +    def __enter__(self):
>>> +        return self
>>> +
>>> +    def __exit__(self, ex_type, ex_value, ex_tb):
>>> +        return self.exec()
>>
>> why do you need __enter__ and __exit__ if this is not a context
>> manager / to-be-used-via-with?
> 
> But you could use it as a context manager.
> 
>      with defer(blah blah):
>          do stuff
>      # blah blah runs here
> 
> IMHO makes sense.

oh, nice! agree!
Then this little part is "the general solution", with the rest
(global queue) added as a sugar layer for kselftests, to only
avoid inflating indentation levels, great

