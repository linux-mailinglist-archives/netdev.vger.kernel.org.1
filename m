Return-Path: <netdev+bounces-105360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3FF910B47
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8155C288588
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519F01B14E6;
	Thu, 20 Jun 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PpAXIaJE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A381174ED4
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899676; cv=fail; b=hVkF+Ad0QYKhi/Q6pmHL9GvpHNt1TzE9ZM1msb/zquAx17UB6nRFjr/K5DQ/oKbZDL2iuvBGalCneqExgPSyc068z3ni/MmJg8InvwEdUswFeKh5b4Bud5SuImxViZNY99V8iJirud/eyYGlnAXpM56YQhUgOH0xlJb5aHfIb2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899676; c=relaxed/simple;
	bh=QQG28QZfGmUMKHSzGpNajqrheHRTmERRYAb23vAvNtA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OBiWnzuEeOfmY9X37Gk+rwcJtiuvt/cf3T3beSNwh+FawNmeETVw0ZjR6C+AXzOswZkDIH5MB2Wibb7hBLrbydyi57VT62GhP7gPjF6Eg1hMVNl7UN05AEyikUmOVyIpBw7CyiP4S2o/Gs2pcVCl6NEiXtMcSV/ZJjSf67juoVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PpAXIaJE; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718899675; x=1750435675;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QQG28QZfGmUMKHSzGpNajqrheHRTmERRYAb23vAvNtA=;
  b=PpAXIaJEi6XDyP3tFEZnRHce58ej3gD8twST7nVW5qoHbJegX4WDyBh5
   wGwsOEAKlOiVT/POtyaDkxtwQhH24Y4/bkmaF3ase6QubUt68DKTVUB90
   dfVVVlhhCmmjSE6T8KlgGDKtzbZOldHrEX4tvmpDcyVS2uTHcRPkHFoDU
   jIzuhANUqUvHgZE2LDCJR3boZdlPXhxE1r1w6cUGPUOnzsdIOBBF/siqE
   gf4VDHBM2OiVt9l6mlVOHOWypz/l050jCcX1AzNeSOgZYUkjSdGaKZY4Z
   gZ2MVfbqByD6KkBSJh9qb4rmlFezN5ktV2DrCAz5Utxr91Q09Phnxes3I
   g==;
X-CSE-ConnectionGUID: Nj8RPF8JS/2UHkEspMMUew==
X-CSE-MsgGUID: MIfjS4F8QIKf9iC1jxXgcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15725981"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15725981"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 09:07:54 -0700
X-CSE-ConnectionGUID: MRdjMVirTXigQiLLnL+U5g==
X-CSE-MsgGUID: 6+bgIMfRTPuqwBGDIkWHAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42750121"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 09:07:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 09:07:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 09:07:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 09:07:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN71CfMb0KQdobK6hwt/O7ECt0YOnv3qnKiQ1pQ546q7zIV2FrkOaz9XsiMy6pqWyXIdPdBCOs+lHMyqO+A0K7VETvSfxO+4jge2r6kYnSoB/UI7/fPhe+kcptsCpmVf9FgwBN7mStzi7AFYufjSf4kwU0Y8jo1yRl5WmFkhV/y62j5tAQPKQdIBp/0mm8E33yUtcunNPSB3TiG3b+m0gHNP3Bur1utIKeg6ZmxI2D6XMzKKr2GnoN/i5o3A6Xb19BuNyXypASjuJc+0rVk891lQjNBXCPJIRcBbNLmB67g9DLNi6RVTh3j9xRGkIVvIO9d5B+12nZIDlceGU7A5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PK4eM985J/vh8hQW/tvALolR1vex57qj3H3aq7KBhCA=;
 b=aaJHLiQMyOhQJnsBG7Wo1WyWndDuXb2M04rKcO2CVE+HrgsWjeEgXaeDSDujVBnlw9SYgrQ3R7XD/LZ+6OuGrAiyNOhubKLkM8LS4vjfGIzmxI8FQCz9J+Samc/iJrr4ieB+1NlAWJ36YJwJowifPkzxKS2x9Xbld3NByMDInLDqKi1uVdUp3FC8eGBzGsvrdLjVTn8i0+Wzw7B2gzMoF8DEpnC/HvCAeJiTTJg+qsqNvk2FBmSPfFddoz/7OFwnSfWsc2d2iH8ZVgNNd7dPhbDlybyucbWaej0gU3Lts6I7wCeWlB56ZyB9EMrUsA+D8UyevJs52NU+Ho62R0gYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DM6PR11MB4738.namprd11.prod.outlook.com (2603:10b6:5:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 16:07:47 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%3]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 16:07:47 +0000
Message-ID: <9eedb260-3bb0-4f06-1243-02cd5dd337e4@intel.com>
Date: Thu, 20 Jun 2024 09:07:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-next] igc: Get rid of spurious interrupts
To: Kurt Kanzenbach <kurt@linutronix.de>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
References: <20240611-igc_irq-v1-1-49763284cb57@linutronix.de>
 <87r0cry974.fsf@kurt.kurt.home>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <87r0cry974.fsf@kurt.kurt.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::27) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DM6PR11MB4738:EE_
X-MS-Office365-Filtering-Correlation-Id: 475f4b68-aafa-443c-4cd4-08dc91432052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TE9YSU82QThtMTVCMWRFeE9EbzBiMk8vRTg2YnhhV2IxbHRwRkJ5YjlOSFgr?=
 =?utf-8?B?bGNXMHROWnB5RVo1S29rVEdtODNpVjBiV0xQQ3dSSkNwT3d1K0lndkVXdUZq?=
 =?utf-8?B?VnZjcmljTzlmNnR1ZURSWGQxam1uWmhEQ29YVXp5SU5TTFZpc1N3cFpoUjBH?=
 =?utf-8?B?enRGbkNjMmgzY01GU3dIWGZPNFJWWjBCdWZlbHp0ZHVMN1pTODBUWnpTcmIy?=
 =?utf-8?B?bnliRStNaTJORENrN1hlT0dyeS9HQVZaMlRMQy9yYTNSeVlDdHBSa09IZ1NU?=
 =?utf-8?B?ZWRhd3RUemoxR3FNQXduMENNdnorNFVDZWpsZWVqQVhNK2tOS1hWSWZRMnFR?=
 =?utf-8?B?bW81ZklYSW0yNUdRK3o3NGN3RlUyUitRZm12NmpEUHVGUjMzaFQ0RDBYditz?=
 =?utf-8?B?MU5GNFpEYlB0VjhXcm9hYXRTRmVXMS90RGx4amtKZ3lyMWtSZDQyV2xQT095?=
 =?utf-8?B?V0duSHBSUG9SNW5yRSs1QUZFaEplNFhOaHZuUW1adU5lWVFnL1BXWWJNVmhm?=
 =?utf-8?B?eXZVbXRkZkxvMUEvTks3VTVDZCtndmdrTW5aMDl2dHJCU0d3Vkg3OEsxQ0Fx?=
 =?utf-8?B?V0xkLzhUNlg1RG9KRUZkUm8wMXY5Q25xb0Q5bUFSNkdHaDFsRngzcmRJRHFP?=
 =?utf-8?B?SGYvME5QOWRHTCsvUmY5c3RneHZ3dG1SQk9qVFlkV0V4S0hkOVR1NGg0M1Mx?=
 =?utf-8?B?bEZqUEYyb1JzZTBGMDRvQjIzR2xwK2JPR3cvTXFraWp2Q0U1NE1zU2Y1Q3d6?=
 =?utf-8?B?SGNQVHd5aVo0aUlqanM1UVdDci9tL3FQbmVaV1lMQTZ4VjFUbGhvcWJwQ09Y?=
 =?utf-8?B?MENSbGlKdzQrcXlNQXRpNnZzbUp5VHc3SlNJWjJjNms4K1JvUGs2dWgzVEdw?=
 =?utf-8?B?dHFNUXZBTHZRZ2JzQURsUC93eTNxcG9BQllrSFpLWDY0UE5vd254WkpjcFBT?=
 =?utf-8?B?MHZWNkhyclc5MTRQUEdtQmtLajIvckplWStsQVg3YkxvSXZxUTVxOTBvVk8w?=
 =?utf-8?B?QmczZnVhV3pBZno4UXZ4RGJHakNoMnFPZzJYbXBOR0ZVTStyRVdZN0RMaTFk?=
 =?utf-8?B?Z0dLdFB0dzlOV1RBb0dWUURUbFVDdFpaZUwwbUc0cEIvVnhWdFQrN2sybkhJ?=
 =?utf-8?B?bVlLNXkydWxOSFZOZm9ucm1hWmdMYXdxZG5lZlhpVjhudkJIR0E4M1dPcG9Z?=
 =?utf-8?B?WEdHdHB5RWJBWjZZcG1CSG5GMURMd041N3dDUllCdXpmWk9Rck93UHE4d0lh?=
 =?utf-8?B?TUJrN3hEQnJvWTlIcmJWdUJldmxlNjFWNlB5UytsNjEvYWZ3d0Q4enNrSkZR?=
 =?utf-8?B?TjFpZW1QRUZTSHl5QnNFSWs1NThXZHY3RWZzNDhEVksvQThvUzcwVlhsY2tY?=
 =?utf-8?B?dzVtQjZwdFV2UFJISUZuWEgxUHRHMVNsN1lkZFdwUkFCWE82b3ExaWZBa2R6?=
 =?utf-8?B?UmhoaU5obitGTE5Zb1I5U3FCOUdMUUM4czMydVZvMkMrQ1BWV1JXb28vbGFo?=
 =?utf-8?B?Vnh1Zm1HT3YrV0I0OFlUNkN6NDYvQ0VITTd5TGhyKzZUM2NoMUxUMldGeUhK?=
 =?utf-8?B?WHd6TG5YcjU0cVI0RWhOc0UwVy85elJ0dHQ0anpLeEVmYzJtT09uNHhiemhI?=
 =?utf-8?B?RGRIZ0IrQzhWSElMZ3JpQWU3UWdxV1JTdWZiSUpYc3pHVWN2S0FaV2lManVR?=
 =?utf-8?B?cjIxb1JiOXhtUVV0NDVlM0JoSklmRHJnb0w3SUlwTzNhL0Z5WG0xTGlaVkpF?=
 =?utf-8?Q?RntGLsZKjvy2OuJJRuEr3SW6a/0NtnJx7Mhw0dv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0tBVVJaM2hreHUwbWN5VXRFbklQMFRETUZ2bmJPeTJCRk53cjdRSUd1QTFs?=
 =?utf-8?B?WWMvRW9TcFA5NTUzRWFhc2gwWkJYMWFkRVRNdk5tSEh2ZXhJVUE3QzNJWUVs?=
 =?utf-8?B?cmw1MFFPeWlONWpBZ0xROVpNaGdVYllwdVdQTk95M3QySmhTck9DT09mVHEv?=
 =?utf-8?B?REQrVXNObmxyN29Eak5IeWxGbzlTUngxQ0VIS0YrY0k4OXllTFB1cEF2TVk5?=
 =?utf-8?B?T2JnSUYxdnBQNzBpQ1pWOWtOWU5DS2ZKd01Rck9pRzhKZDBMeDAxR2Y1b2Ew?=
 =?utf-8?B?a2xaSmVKWFh1NWp6eTA1bUdjWENrcTcrdDVCdldYS1hoNUYzVmZxVlJ2Smsx?=
 =?utf-8?B?WjJjblBmZ0VjZ2IyZ0ExZFdBT29PaFJNb0tObHZmVm55YVB2OVFVZXhJSmJL?=
 =?utf-8?B?UmpNaktDemxZcHVlc2xUbjFiaFl6dDQ1ZzlyaG1oQjdOWU1XeHkyY2RuZFdk?=
 =?utf-8?B?RkNNNDFVdmhpS1JVbitWSURmUVFkLy9SNWxtTEpKRllQM056TjN2ZFd0S1pn?=
 =?utf-8?B?WjIwSnhlK0tNaUhIQTJBdWtrTitscFZkZXE3M0FObGh6Uzg1MTkxZHdlL25s?=
 =?utf-8?B?N1hPQTdvOHJ3d3JvTlpaVGE2cnY5WlhnUFpjTXF5bDFscVVjbGJPNzV4dWoz?=
 =?utf-8?B?SXpFQzcya3NDc1U4LzlWbjhURlMxb05DejBmMFdoZ1ZCWU5QVEpvL2hsVy9v?=
 =?utf-8?B?aHZ2eUIvZkJhQzN4SUthTThlcy9UMy9hbHBobEdsNHZURm5ZZHlVWHVtd2ZK?=
 =?utf-8?B?RnVmc1BsU0JWVzg5WlY4ZkJDclh0bjRTaEJHOGtraS9iOUxyWXRnV2d5Wkpu?=
 =?utf-8?B?Mm5hZmxoY3lCN0hrQThNRnBoaG1oV0hSZEs0dUkxbEtVMW9SNzBqZXAxcmhI?=
 =?utf-8?B?NUhLdXdZYmE0TjU4VzIxcUdGWUpSSmZ6a3ZEZ0ZVZW9xbXdxUjkwTDhrTG13?=
 =?utf-8?B?Sm9XRGgyYm4xNXZNdm95MVFoQlZyYU90QlFzQ0EvbFdUcU01cGx5bUpYVnI0?=
 =?utf-8?B?ZDR1T2J5Rm9SQkVycEJtMVJJaitPTTZzQXkzcW5iQVQvQUhpU1Fjd0kxV0JK?=
 =?utf-8?B?aW5yMVNZQTNGVEx0NnlERlpPcFRUanNVS2U5SXB3Nll6RzhPU1RiWm5TUHd5?=
 =?utf-8?B?VDlhdEdzRnBNMU91SUZzTVhoTmprSStQYU9qYzUxZmVDa2dyNTlTRnk2ZHJS?=
 =?utf-8?B?UCt0OVYzZzR3SnY2bnlsZi84cldYcnNuaUhtQm96V3l2aEFjT1lnMkJZbXdZ?=
 =?utf-8?B?clE5Q3lBZkNPY21nVmRJdFBiVTI5S2lLS0pudWZ5YXpWMnNtbUszaHdMdzdO?=
 =?utf-8?B?RzkwVTc3dlU0czVhcXlLL0lvVFBjUHZQRG9xMlVnd0V4RXZSelN5QXY2eGFz?=
 =?utf-8?B?eVh6eUI2RmwraTllNCs0VEFKN0FOZGxtWGcyMDI4cmVTbW4wWXZ0a1kxekZq?=
 =?utf-8?B?bFVMZ2lDVzNlODkwV3ZrREpLZzg5WEUza2trZ2xOekc5VVd0U0JnS21mTncv?=
 =?utf-8?B?NEwvMStLbWpwa1c0dlBnYmpBdHA3NnFiSW9WVG1yOXpNVWJ4eGdqODBZbnp5?=
 =?utf-8?B?RHYxWnF3SlM2Z2FsN214ZTExbldQMXRrak9JZnNtOGZ2a2dYS3I2ZEN3UkVH?=
 =?utf-8?B?bGM4eVhqMzJkSnBhKy82ZlF6MklKbS9nSjg2NG5KOSt1amdMbStQNmlFcFJo?=
 =?utf-8?B?allKNXorZ3BNMlhlYnJjeUR6WFdIUVVlWGM5b2lMeEFxaUhldklJVXdsS1Vv?=
 =?utf-8?B?THZibmM4Y3RrVjREcFpzODAzeWR1VnlxdmJScDFGNEs2NG5MRDJLN1pLR2NM?=
 =?utf-8?B?NEpXRjdBcUw0SzBqWWN3b2hobEp3UlpHT0J3TWVmcEVBT0ZKL1F1T01nZk1F?=
 =?utf-8?B?MDgvMjlVWmtZU3dMekV0VzI2SXdydWJOUzlQcUFacXBVYWZOalE5UVY5ZWFw?=
 =?utf-8?B?V0pXbjAyZzI3bTI2UTdxcTAwZmYyeTZQY3ZrMFZTNThTcE5SWHNPUFZ4Qklk?=
 =?utf-8?B?UlRPekd3Q3lJL2NRZ0Z0L0s5UEtIb0dIK1dUQmJRUnZCV1RESjBlRGkyTFpI?=
 =?utf-8?B?NEtZZEhnU0NSV3NSbWxqcG9TN0pLMWxhWmdJbXJVWTRyZW9VeEpBSUZxMHpP?=
 =?utf-8?B?aVQ3c0lUa3hNa01LRmtBTURMSUUxSWR1ZkZobk14THZMRDJOa1o1djB4SFZY?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 475f4b68-aafa-443c-4cd4-08dc91432052
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:07:47.2626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiuMZBZKe5Vf5AdBeldejH1fA3R+OSH8lpgKs/L6akUQJEyZSauICHYjsKDPqlrL7JdaPAkmRrMi8Pi0I/7yXecTzKPrs6eSKMK2kwMz9VY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4738
X-OriginatorOrg: intel.com



On 6/20/2024 7:34 AM, Kurt Kanzenbach wrote:
> 
> Can you drop this patch from your queue, please? I've found one issue
> with this if the number of queues is reconfigured e.g., with 'ethtool -L
> combined 1'. The number of vectors is not necessarily the number of rx
> rings. I'll update this patch and sent v2.

Sure thing. Patch dropped.

Thanks,
Tony

