Return-Path: <netdev+bounces-106785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F3917A00
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F871C20EC3
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC6315B999;
	Wed, 26 Jun 2024 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4Lsr93J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808F015B155
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387847; cv=fail; b=d5xJgFD1/iij3JnhJO7KfBVPJEua4mG6F43VKrXa5z+/UEYgMPwweNLx0ukl2COBQRyHPb10Xi6Uszaqbp0eXaWRvoUEyZoUFlsxzhrq+AejnrIpsPMqCPEdkq1sQRT6Q0xJhB+tK/ajg2iS6Ovlk7hOGo0iWp5WTDbdWgeCvrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387847; c=relaxed/simple;
	bh=rRoZ3jfsH6drPt4kq1f6QAObWorxW5rPeSgnm3r4ljY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R2Qg3GQn3I7NA3c6Pjo0m7HSGcFCjwPrHo/RMvuF8qajmH2D2bgwzdi6coduMIIa8U5a3M3UWgAzt4bvyHM+dl05rIgVNzRKMxH+X8VPqhEJNLEJcw8X+ZCtOWiWneAfKuWq1PK7MQHnP0KZZ1IKL9DxAzOn1+8KsJDzEox3cVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4Lsr93J; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719387846; x=1750923846;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rRoZ3jfsH6drPt4kq1f6QAObWorxW5rPeSgnm3r4ljY=;
  b=X4Lsr93JG0aRaW+b67cHe7c5lGIfUbX6lU/8uYV1rrWjtYszE23cDt1B
   9pXAHt6lg3nSGDWxLDX4RIGc+GQdcT+90rIPuibf3sNaHEv9yKxw48D/B
   ONq4pWrZaYGB0ooabm3mc5sGMK8fVVi+qK45LN8snlTPhNEu8ZNTk6bDO
   zHd4ysERGEBOTCPRdRUbpwGdU6aD67tN+TbaGK/FldfG7B4mkuK8T+73C
   9zEUBTC6t8MqJOV5/EaLLQPW+ScF0SZlU4JFbBveMiQZ7Ie3087eA2cSV
   PmPCXCX1phQCXZXbHcJi/dOPUTBM8hSm3d03KV856U7Ep27NWTDAHW6Al
   g==;
X-CSE-ConnectionGUID: V3BmpBpyTFmURONF+WsPJg==
X-CSE-MsgGUID: mufSkFb5S3OyBzF2Oo4JmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16668647"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16668647"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 00:44:05 -0700
X-CSE-ConnectionGUID: oOkbSf31QgqSDoobGWP5EA==
X-CSE-MsgGUID: gyIeA3oUTZWk7jqWGjHT4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="49086972"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 00:44:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 00:44:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 00:44:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 00:44:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 00:44:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsguFKvvA6uA/lmhvEsXYWLJn+jaEYjYtHyW6uNWPTwL4lpeWKKWPW2cdGm+RlxJXRMqiQRoqpoG11t7irAvrbGClXnMNFr8knVhLN+72qs3qrBhj6Nik0RybRGUwHlAxooqtOe+kz+Awk7fojU4Gd8nJbanj4OIum8fhtM5l8TUF1qgjpPiWkqedInLlDM7cmV4udfkNqOscLwwy22ONzbqLwkGuwMC9NwHiQrWg8arkMmNbGGCJPVkZB51RSUmMk8QLSlg9a81ObUWsEcgWpTttXTgLtxlg+FfBKJtwJDvOn8uQeZf4NFJoUHl7QCUZGi44KA2J9vdTOwSmuf6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf3V21UOeKCzSOpOdXbrDDUTtu1O4B1/Z4tXYW02jH8=;
 b=XR0JP7uX7Xpfd/+A4gWLNFgBTrCbu0k2uM6ntHst5qi8wwPab0q5jAzuaFzvU7Mbsv8yT6vRTWb9dWDgf6wEuahrVGoTQN3zCb3LTKBo8hEyR3TOj7Y+OhRt/0wyFbzP/S7s6UTZz4zfv8+EMlDqFGRxTGIuibel6IdRMLYolXXdAVdPaelHDIsXjFDi/qTSJoxPC0Rd6e+TLLZQYD3HgXPipBRf3HH4vo0vFJV0/fkTS1TUCfm+oT5aOVoKxk82yycfHJ/6pJ6F4fW7PKzL4SIBVqg2flF7+lQBaliYtI211e58ohe01LE0sJ9JsnsHj9hN+R1uAamaEkcjEhjbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB6758.namprd11.prod.outlook.com (2603:10b6:806:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 07:44:01 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 07:44:01 +0000
Message-ID: <d7a8b57d-0dea-4160-8aa3-24e18cf2490e@intel.com>
Date: Wed, 26 Jun 2024 09:43:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/2] selftests: drv-net: add ability to schedule
 cleanup with defer()
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>, <leitao@debian.org>, <petrm@nvidia.com>,
	<davem@davemloft.net>
References: <20240626013611.2330979-1-kuba@kernel.org>
 <20240626013611.2330979-2-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240626013611.2330979-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: abb8c2b2-f731-4ccb-7f4c-08dc95b3be96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWc2Q2JWa290MWVSRUYxeHpWWkhnS2NVOUhhZTJyNXU0V01kZWNORXoySTBw?=
 =?utf-8?B?R2EyRE5OSmdTakpxSEZ0UW84Y1JCandTcVI1ZE5uUGFJVWJJV29OdzNmWTgz?=
 =?utf-8?B?UmpwSDY4Ym1URmZNbFd5TjBPRVczNjFoaHIvR1VkQkZGQXVROTd4YnpKYnRM?=
 =?utf-8?B?Q2dTQXcraVoyeWtKd3J0T3M4RWMyc1Zlc3FVeFNwcjhTY281S3dWYkxZNVpw?=
 =?utf-8?B?UzhDeDdoMWFJUGE1UTF0VzZZVlJwVDVQd2hGZ0Z3eS9NdGUrbHFCTEY4QmVJ?=
 =?utf-8?B?emlScFc5RjhaQnBaNERBMWdoSzF4dHJSQk9nRmNiYkJmc3E0ckovenhOVjgz?=
 =?utf-8?B?ZDhJbEZrL2NTL3FnYmllSDEyTSs0eThQUFM2UEZMV0pvUzVDMUdaWGpDbUFW?=
 =?utf-8?B?TFNIemF4cExxUFJNVjZLUGZrVG9iZGVhekVmMVp3Z1ZuZHFReTVzTzhVTzVq?=
 =?utf-8?B?R09US21qU2JSWjdJU0ZlQ0h6TWdCbjZyNkZybFN5SWNmNDUwMjhsS3psMkVi?=
 =?utf-8?B?SGl5dFpWYzlCcjU5RjRKemM0OHgyYndYZGt0WXFMYSs4bDNxWUVTUHlrNnNh?=
 =?utf-8?B?SnlpMGMxS0ZvaDFxSS9Qb2NUblFDakJ5NWZmUGc3ejRNckNaaThpRGJJM2ti?=
 =?utf-8?B?RFFvRWliVitTL0RXY1BTN1B0R2kwa1MzejRPRkZIVFpMSDV3aGd6a2xoL1hD?=
 =?utf-8?B?TUs0SENCenJIWWVxa3l4Y09PVVdkeko1dEc2eENQNzVmTndEOWg2TWN6MGRX?=
 =?utf-8?B?K1dDNHBVWXFLZzRwVjRzSi81NVQxdlNOYWRsWkVmWkljd0EzNEg3ZzFzb0tU?=
 =?utf-8?B?eGJVaUhVL3RuMjU2Qi9EU3g5V09xNmNLOGdwWlc0eG8xR2x2Sk12K1lOUTVr?=
 =?utf-8?B?MXovQ0s0bVM2dXFVWTFBanRjV05NMlg1RnJOcEhnSXRpY2JCOE4rR0JwaFBy?=
 =?utf-8?B?cXVuWWZTaWczVEVTTURUeXVRQnVSTnBwU2VFZ21tVzJCbHFndW1ydW5ZMUd5?=
 =?utf-8?B?K1cyeG5YWk5MYUZ1Qk9MbytOQkJUNVYzbHR2V1pleUdjRkpLdXZSQlg1bkg1?=
 =?utf-8?B?U3ZqR3FmOEFoakpsT2NIbC9TRXQxSUZvTkNQK1REVWtoSEZJTUd0UkE2bGF1?=
 =?utf-8?B?WmxkTmNUc2k1ckJQZEJiWUxlcnpzVmFxbDJLVzQ4ZXU3RDAyNkJnSW1BYlVL?=
 =?utf-8?B?dzBOK2tidWpkcTB4VVQ4Sy81dzdQdm1kVVdYaFl6QnR0bmZSdVR4NG5zYjNk?=
 =?utf-8?B?b1RsRllYSnZwY2tJOWdTYUM1dEtrcDBNUFpiNkhkcnhGNS90bERGZDZMalcx?=
 =?utf-8?B?NVpUbjN5dk84Ukd6MTh2VWpTbUwyamhZN2p4aC9Va0Z1aEZaVGdRSXdTZnJl?=
 =?utf-8?B?TTBUeGxXNTBnRDlLQTNQelFSam8rcURSYXQvdFJuWERaKzgvQUV2UDV6Vm9x?=
 =?utf-8?B?cit2cmI2cDUvVTB3b2lSMmUvdW9wcjNaRFZVS0tyYW5EL0h6aWhPZkMvQXlm?=
 =?utf-8?B?bTlPNW9pekcrL2F6eGlFM0NESGc1SnhEVzQraW1WRU82ckYwczNneUVYR2I4?=
 =?utf-8?B?TWlhZEZtK1JETENMb0NvZDFYMlFXOEd3QmhzUVVYMEF2SkdCWmk0ZC9FNXYw?=
 =?utf-8?B?UnFZejVTelkxRFM4WEZKN1dnbGNqYnY5NGxyS0hxZmFybVRVb2tLM2NlMWpF?=
 =?utf-8?Q?VyrJ9fc8tMm0qp3tvfkI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dktxQUtCUExJMmo2S3VhbHFHK1l4eDhYdXJ4ZVpCTTJsYjNCN0tnclhzeHA5?=
 =?utf-8?B?aENoTzQzMk5SUXdxK3ZRcWx5OEJJSlljcXN6NnEwWDRhRXE0eS96NUtNbkFU?=
 =?utf-8?B?bENGOGdWMHEwWlFkaHB1djE1M3owSWRraVlhVHoxcVdRbnlqUEJjb2crOU9q?=
 =?utf-8?B?R3ZPZDcwS1pWZmpTSWZkUWtXc2R0bUYyK0M5SnpOSHVJckx2QzlXdWxsWlpN?=
 =?utf-8?B?TTJaNFBpbksyZHp4SWk3REsyWW9JMTIwY29wMFJqb1ZoWDRKTHZNeEZob0R2?=
 =?utf-8?B?d3lPZkE3c0llMFdlTE81TUswTUlaN2s0TFkrelF2dy9lUWZmK2V3aTgwTDdS?=
 =?utf-8?B?VWdPZEVmaGZ4UXlHcTVhZzlJSHNrVGlXR2JvckY0TGlXbFhLeklaWlZlZSsz?=
 =?utf-8?B?SmdLa3ZhWEhMM0dGc2RiYitrTU9oVENhNkdvVjkvajEwWGZzOEVFTm02ZWVL?=
 =?utf-8?B?Ti94T0I4dENvQ1pUbHFxQnh5QXk4K2w1bW9wNElEZFVsTWVtSGplUWZnMHBR?=
 =?utf-8?B?cUhVeWJjRTMvaGtRbHlneUJSMDFnODFCQ0F5U3VrUEFVQ2ZjMGtPbmpRSGhZ?=
 =?utf-8?B?R1pnc0hHeXFkUDZKdTZldWZIYTFIbDBISmUveWtnU2ovcERubEVPY3owZm5l?=
 =?utf-8?B?b2ZRd2RYYVZaQlBzWFNZNUV3ZUkreGFZb1RMQ3JoSktrT2M4dGxKTzNsUlJa?=
 =?utf-8?B?UC9DcDBWR1lIdmdLZ09qbVN6SHMrVUUwUzl6T2lyd2VXR0N3M0pkMkNuYW1X?=
 =?utf-8?B?OXIwekN1RTg0dzNxRFcwdFh6NnM0TXowcTJHaWNmV1RQMVZEb0R5T0lzSlF1?=
 =?utf-8?B?aE9BVm5qeWFmRkRyaExhWlNDZ204TlBmZzZ4aUswbXBqZy9NalZmQWttTnpC?=
 =?utf-8?B?RE5QRENINlRhWG81TmEwVDNqZEFUUUhxa3hUeDVlNlFocUZjL013LytpNk9E?=
 =?utf-8?B?a1czM21TMVpvSHN3ZG0rTlY2RWI5Y09zVnUxUHU2R1loRXArOUFHMlYwTHBt?=
 =?utf-8?B?dVB4aGlVLzVWM25mVEJ1bStjZi9yNWJQeitEdFpVRDB1bTRtSzFRSUZTdURD?=
 =?utf-8?B?K05aS3g3ZXkyaTA5VlB2UWhjWW1jR1QrUE9DbjM0VmorNUxZSlN1M1NnM2xV?=
 =?utf-8?B?TTEyZmlqY2FnMmR4Ym0xRHBhOEVrWkhOa1VYZ2RvOWtsZjNCL0c5MGhTdnow?=
 =?utf-8?B?TGJWTW5UK3VJRlQwTTRrT2RVWlFHTzZJdkE5WHNPVit5RU1MWG0yOU9TWTRE?=
 =?utf-8?B?T1FUSWZGalptSy9DdGkwUmJqeFJFakovQkpDQXlwd0NSMFdZREJvS1NTUmJh?=
 =?utf-8?B?ZTJhUkNtK1hnZ1ZFTTl2bGdqTWpaYllnU1ErMjd3MHR1dE5xMWJqL29WaWN3?=
 =?utf-8?B?YTRoUW94WS9TWnZuNjExdHpuYTQvUzA3cVRVbE5TS1JhdWpNZHVQOWw1R282?=
 =?utf-8?B?NzRFQXNNaGtUa2RlT0tVc25yVWNIMTlxeklnTkU1RGR6Z0lkRllYWThGTCtk?=
 =?utf-8?B?Y0YybXluZm52VUd1aTZEVERPWDE3am5qTzU3RFVGTFdlRDdpMmNsbUJneUFU?=
 =?utf-8?B?ZHhUQVVGOW5uZU53eU1tcklZN0FrRFFsMllJTXBJenh6R1JoNnh1MDVpbng4?=
 =?utf-8?B?KzllclJPUW1JS2FXNVBxa3M4RkJDRit0c2Jkd3NxZDU3WUQwWE1ROEV5dzEv?=
 =?utf-8?B?VmcwMlNXRTN3ejBlTmgxVnJxY2JTcW1ZdkM5aS9rZ1B4M09VVnJ6eFFRWVMy?=
 =?utf-8?B?cEpqOFVBajV3RFpHVUNRR1FQYzBhMWwwUjg5ajdIUlc3c21aZDdEUHBzbUJk?=
 =?utf-8?B?UkJ1NndVUUVtMllKNVVZYnFiWDdMOEZzVkY5Y211cU5yU1I3VGc4MWErc0g4?=
 =?utf-8?B?LzJtMmVUbmNmTUpkYzhoTEJ0Z1Bxb2VvTFBmZkdWUjJpOFNEZDZGU29mY2lp?=
 =?utf-8?B?Mmp0d3M1NnY0OUNpR3pITjRlblg1b1FKeC80WDZVb3UxanRPVENINlBqSDhx?=
 =?utf-8?B?cHM4RGF4SWxyWkYrcHEvTEtTUkJhY0luTWx3dW42RjdMWFF3TEtsMzkvNGEv?=
 =?utf-8?B?VUV4emRLOFBCUzJDN3AwcHRycStCK3lEcTZuSWVlMDBsOW1ZWlFwZ2JiRmll?=
 =?utf-8?B?N2ZxMmsrK291R1JhZVZVRnNyenFxSm9NV29QbXMyYmVSZk5GbEt4UkNlNWFl?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abb8c2b2-f731-4ccb-7f4c-08dc95b3be96
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 07:44:01.0886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkkjpNsqe1Y3MO7TaQcE6EoBrMyDyWt0mXomujite4tFp3EyHYtlxbGq6aMoQcmSMnbgc+lOakwNct2k7r+TLGV31KZ5Hf1/u/fgJ/bnMiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6758
X-OriginatorOrg: intel.com

On 6/26/24 03:36, Jakub Kicinski wrote:
> This implements what I was describing in [1]. When writing a test
> author can schedule cleanup / undo actions right after the creation
> completes, eg:
> 
>    cmd("touch /tmp/file")
>    defer(cmd, "rm /tmp/file")
> 
> defer() takes the function name as first argument, and the rest are
> arguments for that function. defer()red functions are called in
> inverse order after test exits. 

I like the defer name more than undo, and that makes immediate
connection to golang's defer.

For reference golang's defer is called at function exit, the choice was
made that way (instead C++'s destructor at the end of the scope) to make
it more performant. It's a language construct, so could not be easily 
translated into python.

I see why you expect discussion to be potentially long here ;), I just
showed it to my python speaking friends and all the alternatives came
up: context manager, yield, pytest "built in" fixtures and so on.
I like your approach more through, it is much nicer at actual-test code
side.


> It's also possible to capture them
> and execute earlier (in which case they get automatically de-queued).

not sure if this is good, either test developer should be able to easily
guard call to defer, or could call it with a lambda capture so actual
execution will be no-op-ish.
OTOH, why not, both .exec() and .cancel() are nice to use

so, I'm fine both ways

> 
>    undo = defer(cmd, "rm /tmp/file")
>    # ... some unsafe code ...
>    undo.exec()
> 
> As a nice safety all exceptions from defer()ed calls are captured,
> printed, and ignored (they do make the test fail, however).
> This addresses the common problem of exceptions in cleanup paths
> often being unhandled, leading to potential leaks.

Nice! Please only make it so that cleanup-failure does not overwrite
happy-test-path-failure (IOW "ret = ret ? ret : cleanup_ret")

> 
> There is a global action queue, flushed by ksft_run(). We could support
> function level defers too, I guess, but there's no immediate need..

That would be a must have for general solution, would it require some
boilerplate code at function level?

> 
> Link: https://lore.kernel.org/all/877cedb2ki.fsf@nvidia.com/ # [1]
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   tools/testing/selftests/net/lib/py/ksft.py  | 49 +++++++++++++++------
>   tools/testing/selftests/net/lib/py/utils.py | 41 +++++++++++++++++
>   2 files changed, 76 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index 45ffe277d94a..4a72b9cbb27d 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -6,6 +6,7 @@ import sys
>   import time
>   import traceback
>   from .consts import KSFT_MAIN_NAME
> +from .utils import global_defer_queue
>   
>   KSFT_RESULT = None
>   KSFT_RESULT_ALL = True
> @@ -108,6 +109,24 @@ KSFT_RESULT_ALL = True
>       print(res)
>   
>   
> +def ksft_flush_defer():
> +    global KSFT_RESULT
> +
> +    while global_defer_queue:
> +        entry = global_defer_queue[-1]
> +        try:
> +            entry.exec()
> +        except Exception:
> +            if global_defer_queue and global_defer_queue[-1] == entry:
> +                global_defer_queue.pop()
> +
> +            ksft_pr("Exception while handling defer / cleanup!")

please print current queue size, if only for convenience of test
developer to be able tell if they are moving forward in 
fix-rerun-observe cycle

> +            tb = traceback.format_exc()
> +            for line in tb.strip().split('\n'):
> +                ksft_pr("Defer Exception|", line)
> +            KSFT_RESULT = False

I have no idea if this could be other error than just False, if so,
don't overwrite

[...]

>   
> +global_defer_queue = []
> +
> +
> +class defer:
> +    def __init__(self, func, *args, **kwargs):
> +        global global_defer_queue
> +        if global_defer_queue is None:
> +            raise Exception("defer environment has not been set up")
> +
> +        if not callable(func):
> +            raise Exception("defer created with un-callable object, did you call the function instead of passing its name?")
> +
> +        self.func = func
> +        self.args = args
> +        self.kwargs = kwargs
> +
> +        self.queued = True
> +        self.executed = False
> +
> +        self._queue =  global_defer_queue
> +        self._queue.append(self)
> +
> +    def __enter__(self):
> +        return self
> +
> +    def __exit__(self, ex_type, ex_value, ex_tb):
> +        return self.exec()

why do you need __enter__ and __exit__ if this is not a context
manager / to-be-used-via-with?

> +
> +    def _exec(self):
> +        self.func(*self.args, **self.kwargs)
> +
> +    def cancel(self):
> +        self._queue.remove(self)
> +        self.queued = False
> +
> +    def exec(self):
> +        self._exec()
> +        self.cancel()
> +        self.executed = True
> +
> +
>   def tool(name, args, json=None, ns=None, host=None):
>       cmd_str = name + ' '
>       if json:


