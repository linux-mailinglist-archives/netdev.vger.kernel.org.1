Return-Path: <netdev+bounces-133225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C00995594
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA5B1C24B78
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333A31FA240;
	Tue,  8 Oct 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzhVHFnA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C271E1A08;
	Tue,  8 Oct 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408292; cv=fail; b=jGsPMMN5sM2ANB7GJA/GvbR3/VWqAS1GJPl5oPi1byqqtjrFaSE7KIryuST3PAUXre3DS0o5BrgmGv7zJQBHG+wIPq4oF5cPKmywxVsARB6GlS5fvNy23Kw08SvFmdO6EDgY+v2onq4BtiIRPIsAj1c6NbAePKFKtpgtet+wsuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408292; c=relaxed/simple;
	bh=EXU3kFKZZKhDH24ymQc6x0oNGw8nlXEGnqsOnIDOK0c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LJ4D0oPeouBaIply2ass5huncoTj6E3UyiZBRoE5jb68ha5ZILr6/ELwbkwggr7WZHDkXMd1y2kPfEa62F8JJsm0nBGaoxUekHIK1qmEXlDLtUXoelsK9itd9oz6izgrpHlP+V6jHBkxGgKe5r+xhAFBDuRTHpBVtGTPnyZvLgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzhVHFnA; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728408290; x=1759944290;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EXU3kFKZZKhDH24ymQc6x0oNGw8nlXEGnqsOnIDOK0c=;
  b=ZzhVHFnAoiBploW507VyjWtrbYNgKMpLbqxwdXPsepjshBM1mJ27QoH/
   TgOpXRTF+YsdnHxSJoorx53ajLwyyVlej7R7+o/5ZcT3d0LpeVtJedpCf
   gvtO8xSkqsYx79v20MbBCokk/n0rexs/HWMwAvEu2XAIgI9umynivFD5l
   P5fMjx+qhfHuipr91YdVfoC3xUjWg/0U1yEYATOo8XGMgNxWsBTtVyxG6
   gqZJQPtbKUiXEauIAXHvsucQ4QMOc0LCxVf+C/Aq0yEqhL/Q1a151ibIH
   sEn8YO7ESjKrHqZCt8Y/OhLi3ES8H0XCPO1UrWe4b8qLhgcWn0L3TK3IE
   w==;
X-CSE-ConnectionGUID: QDgaYJtyTo6QwGBkv+amMg==
X-CSE-MsgGUID: auDdd0JrS7KtNi66Iz5E7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27085718"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27085718"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 10:24:50 -0700
X-CSE-ConnectionGUID: XltWh6GWTSK6Aqmmvj7v+g==
X-CSE-MsgGUID: VuMbFRkLQxSym3rqEo1m2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="79890366"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 10:24:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 10:24:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 10:24:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 10:24:48 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 10:24:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGL0YN33wD7D6Ly0NHT+WxecEZdmGJ7KfI4Lqzi7NrSX4x3StTLQ52JBrz7a4Z95qXAEqQoi3uwHOWHgQP6czTM4HkfMvLUfIpVvYB3c+0KTLSnYjXoR7ATOULuUx3WM6N7IrGmQ/ZGgTtApnQvmbaUXQWwfy2XS+At0PBxRczsQqsq3RSTgxaOaACJXBpGxJwqk6YNlUysA2V5Zfh4xtNpCT0KSGCulQ9+bVeg0jWYa4gAG2nKCcRCfmTy+E/j4jkhXr2bVo+6ivnBLcsQN5bYvEafNqJYtlIM8NtvyLqIQrCq6z1USlTHzjLYSXcq1BFxLMtNfh02jAEhi3BD6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZUmG7ZysvTP/oSQaN6d/h7fno+i+J8i8nmHuyA9cfE=;
 b=pvqjCcHojMGR5WJG8gOKk1yMSBG46+lsXFZLUjyb0xW4e+6pRAS80waUgm68JlhkgZqmKiYsjVs5bsM4PG1UF9zpRqgxT3pePM6C3815ikW3alsRmui8cZgvHfuWFJuT7xXq6mOlswefwxdxhIfuikdg7GIzDL2HnO0gI6Y9E5Jka5uaUBLHe0tSCwmlNtQdHDZfb+lo/MjbrxOEiHTWEN86MxK/CoO5V+3ba3qx2bjS2iGLjrpgjF/x0l6+haBCPBQx/NMjyK6E+EUyUTcJWZoTlCCPfiBMpq8VtuyZHYrNPm/izfWuim9CPnD8qYtOR2gq0UQcOHgfg9qqrMRpPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CY5PR11MB6235.namprd11.prod.outlook.com (2603:10b6:930:24::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 17:24:45 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%7]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 17:24:45 +0000
Message-ID: <3c1719a9-ec85-b1ae-81bd-33b93fd50131@intel.com>
Date: Tue, 8 Oct 2024 10:24:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Intel-wired-lan] [net-next v3] idpf: Don't hard code napi_struct
 size
To: Paolo Abeni <pabeni@redhat.com>
CC: <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>, open list
	<linux-kernel@vger.kernel.org>, <aleksander.lobakin@intel.com>, Eric Dumazet
	<edumazet@google.com>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <kuba@kernel.org>, "David S. Miller"
	<davem@davemloft.net>
References: <20241004105407.73585-1-jdamato@fastly.com>
 <6db0670f-6a39-4a23-94d2-5b944fea8dff@redhat.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <6db0670f-6a39-4a23-94d2-5b944fea8dff@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::10) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CY5PR11MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 5677dbfc-e42e-40bf-bb06-08dce7be1a95
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFVNQ3pkTEZHSFpRVm1rNXNaYXZjQUdmYzFYRS8vZWwzYWliT0w5K3EraitP?=
 =?utf-8?B?Q1M2NzR0MlBXWWNVNFF3NzJBNVJ1Q2hQcno2TjNaNmxyUjROVmdxaXJLWUg5?=
 =?utf-8?B?SVlTSlNJUklldHFwZVlTejFvdTNYVDV1cmVscnZ4cDRBVVJzZytXNFJuUXp1?=
 =?utf-8?B?Z1RMUUFaa3Z4VTU3RU9aZXFkdmFPeDM1UVc1YjZMZG5aRHUyUXZheFJnN1hY?=
 =?utf-8?B?L2dVU2phS2JSNWptcFB3YWorbGR5bzZjRVFOdmRTbGNyVmlGdklwclA2U3J2?=
 =?utf-8?B?dTZ3eDRSZHRoTVlQKzFGS3h0dENVbitmNGpDZ2ZNS2U3b2hrTGJzSm96d1J2?=
 =?utf-8?B?b2p4N2hGMDlzWUhNVXArOTlwV1R0TGJ6Sm5GaGZLTHl2T1B0N09wUlE4NkF0?=
 =?utf-8?B?Q2U1RngyQm1TRDZGSWxucmdSWld5RFlLODNKNkRjdWljVTlHOGduOTh5VUh1?=
 =?utf-8?B?a1h0VGE2QnJsdmRSeUdYMEZ3MFBGaVRmdHFIVVFLZmlabTZPMTgzZ05BZHZs?=
 =?utf-8?B?N2s0b2FGWk5TTENCWVZlYS9BcjVpUTcrL3ZEV3JDakNBUU5xeHY3c2x4d3Fu?=
 =?utf-8?B?Z1hDT29IL2xFaDVhZ3pubjRFVW1WdllRRDNqMHJ1dnNYUDczRDNNSXBYKzZr?=
 =?utf-8?B?a0p6Yk55NzBBK3d4NnE4dUNKZEFvVmIxcENrdnZLa3Z4bW5QREp5aWI2NnJu?=
 =?utf-8?B?cHZlRWJMSU42SzlxSVpXbG1pSkp5YlhrS1FUaTJvejVTbitvUE1sdlZKa0N5?=
 =?utf-8?B?cnlrbnFQQ01sMUpOcVkxQ09aTEZvM3ZHcmZJMDVDVXpmUFF1ZWFSTVJkdy9x?=
 =?utf-8?B?UHNUWGVXODNzTXRBRWVJU3BFOVEwNnNxZ0tCaWkvSGpPQjdhbVBKZWN0a1V6?=
 =?utf-8?B?UkljRG0xaFlUTzVHTW41QUZSSVBDckRKWmdtd1o1L0VYQ1dhTWJIbkxFeld5?=
 =?utf-8?B?ckpTbjdUNE02eGVETUNwTDFpVFBMUEFSOEwwTnlxY1FXTE8vMU9oR04xN3c0?=
 =?utf-8?B?bTZQTzBVK20zUnFibWw0YWg5L2xWSEV2dFdPOXFoNHJ3RlUxNlJwdUYvWEQv?=
 =?utf-8?B?VkZVbURrNWZ4Vk80WEx1R3FuMVhuQklmYkNXM21SWE04Tm8ydW8rR1BoMnNs?=
 =?utf-8?B?VHAra0pSS0I1UkpicDMrWHo4SG5lRDBhbFp6cndUT0dtSGtHVUgxSmdBUk9F?=
 =?utf-8?B?dnp3NDUyV0V0czh2Y0MzanE3Zm5DcDZ1TGpoRllQRHA5YndCKzJlSmEyaU90?=
 =?utf-8?B?QzhHWFBMUjczbTFwZU85SnpHYndibklHdFRpZStwNGwweUNVelZzNFV1Q3Yz?=
 =?utf-8?B?VVg1QnFnRHdMbWthaUwrRDh1Rjc5RTVLVjM5dU5ER3ZKLy94VlBkVEUvSHhT?=
 =?utf-8?B?UXRhUjdQY3hHckRHdTY5S1pjUysyVktxZHQvaS82dXVRQ2VuVU8wOEt5c0dm?=
 =?utf-8?B?Tmt1TkZkcWJVbTZFNDNUaVhTNFNsTHVsQ2RxdG5ydEs0Nkl4M0NJUVNMZC84?=
 =?utf-8?B?MjhDNmVweTc4YXJYU1hrT0VoK0daK1o2YXdlekVSNjZ4ZnVTQ3NjZEthb3JK?=
 =?utf-8?B?c25heXQ5QzZnL3BDU0FSK0xlRmZRRDhzOVVTRzdpbTh6L2NEVjFTaytwRExj?=
 =?utf-8?B?ODM5U1ZZQ28zeE9FaDJhL3FsYTVVSUs2VmtoNUdFR0RKSWlFUU43ZFR1NHRN?=
 =?utf-8?B?T0V2QWcyd0l0bnN5bDU1SHJHbUVjU0paa292WndsQ3dSTkY0REovR0hnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHczK2gxVnJNc00ycm1HUDIvMkFzaTUvdDNiMC91MjNoQUZoZlFBNjVjNTk2?=
 =?utf-8?B?eXRna2dDQjM1djhSRTFQZkhlZHRwNWUyNmVjc3pzWVhCcEwyR0VJMnZlMlZ0?=
 =?utf-8?B?L3RRcHdvVW91U28xUTFQNVV5ZXpjNkpVUzNTTzVJb3k4aDZpN1l0UXA0cUln?=
 =?utf-8?B?eHRCeWs3R2VrTStwMEJYWDVkYWIwQXJNZTh0QXBVd1VIQ1JuZWtYV2Iwcm1Y?=
 =?utf-8?B?MHI4bFJkVlN1VUplcEVGRDNmRi9ZV1FUOG52N2hLam1nbysrOGZycm0xYnNS?=
 =?utf-8?B?dnJwVDhvQ0dXV0FSWFJBRUhzWDhHQUZVajJaNE1MQkpJZU5yQ2tJSStuMGNw?=
 =?utf-8?B?THdjcGUzS1JFK0ZlT3hCeVZZRE9rcm9oQVA2ckV2V2ZwT3h3SWowRUdTRVBi?=
 =?utf-8?B?MWxrT0NPN3l2TlFXb1pYQzZubXpYYXJmNE1FSVlUUEs5UGttaWJxb2tsNWdi?=
 =?utf-8?B?UjBPS3g1TG5aREpiZFlrcWd1QTlLbFJTZjBvNnhPbXdsRnQ0ZXBSZmtyZ1dx?=
 =?utf-8?B?dHVKN0gwR3RQT1hFRCtmWmdVNnE2WW5EWnBHcFRSNzFNSmtQNVQyNGlYVDZk?=
 =?utf-8?B?dWd5bkM1dVpXTGFzaVFiYWxxNzJPUjdHeU1rRHltdEhLL1VLdG9uNjlocm1i?=
 =?utf-8?B?Ynk3Skk3NUJQS2VYM0x3UXFTSWpVRW1mL2lWRk5wTkxhaG9TTjNmZTgvenA3?=
 =?utf-8?B?NFA4YkhweW5HdlBYemhjcFNjZXZpOHVCMWNZWnFMbk90enEzNVpDeU16d1A2?=
 =?utf-8?B?bEtsd0hNZnNtQUtSRUxEVkxZbmNVUUp0R2dQdnBEaVRXbUQvNmZERy84T29E?=
 =?utf-8?B?djl6OXh2TkRLbVRzcmdEMHJPOTVuemVIUkhQT25PSkZCVlVZS0Q1VE8xcVNl?=
 =?utf-8?B?WElHRGxDYWxyU09FZkk0N0xEUzNFUnZ2M2xLQ2RFZkFpWjJVR3JTK3VQSGtz?=
 =?utf-8?B?bmY1VEt5VWtTeHhUSkQ5QS9aVzg1RHpzL1o4L1p5V2JzWkptVHdtNFFLc3cv?=
 =?utf-8?B?VmZnd25zWHNVY2NwWFg5MHNMNldmc1AyT3NnSEliQ1lSRFNySnEwVEJEOTlG?=
 =?utf-8?B?OXVhL05zR1QvdldzMm8rS2Zuek5tMXVWZkhKUFRGbWh0K0Nib0w2QzBNV253?=
 =?utf-8?B?bTZGNmJxQUVIWWZYT3dpWk5paE1jU3JNV05pWGNaRFl0ZDVJaU9kM2N2bmdV?=
 =?utf-8?B?SXh3dDVGcUxOSytMOCthdWNYZ2lpZEVIQmpFc1dXRWlMQTRpT0t1NVNWUEho?=
 =?utf-8?B?b1F5WlVISndwUk1EQTJ5MmNYNTNOSWk5MTYxbTlaREdDMEJXWXRJU2x1cU9I?=
 =?utf-8?B?VWxsaldvb3hkZmJ5REUwY3puOER2dHpaUldDd3d2QS9KUkgyQWJ6Uis2NXZk?=
 =?utf-8?B?TXlpd21Bc3BBMEVwMy9Bb01yM201WjNBTjNGekVrTzVSTW1CQTNlYk5zeXZE?=
 =?utf-8?B?MStCbFNGQXNwbnpQTTJrUXlXajhLV202Q3RxMlBCVDZ0alYyRHZHUEMrVWl5?=
 =?utf-8?B?c1htbjZKQ3pPcUprWDRXYzVMYVBVTkZ6R3ZrbnhJVzRacENCOVBqYkVGbCtD?=
 =?utf-8?B?Tng4bVVzWGhRQ3lFTFN3NFo2ejV4T2JqdE9MaW10dnRyZUVtMWZJYTZrOXR1?=
 =?utf-8?B?bDROdHhMVENYV3V0dXc0bmlnYUF2RTJKakdETm9DN3I1bzQyM2N0Qm5RdGUy?=
 =?utf-8?B?UkFTRkIzS2wzUEF0ME1QbUIxc3o4U1VHQ2dZVGxEZG9idzYrTkV1SDlxS0Qr?=
 =?utf-8?B?Sm1WdHFKeW1PRkVqSkdlSzJjbkFpQURkUEhDVmJ3N3JuTW5OV0lHRnB1U2dq?=
 =?utf-8?B?d1F1OE14dnVKSWYxYTNqVys4bVFFbi9ub2ZURG5zdTNvN3R1bnNaT1lpMDJr?=
 =?utf-8?B?cUYveE1xS24xWjUrak90L3FvUy9QUFRZV3M2aXRFdXJNTUZyOXJQZXFtTmh2?=
 =?utf-8?B?emgxUTZLdmJWQ2w4eHlhWTNtSnY4TzNjQnl4dEpiUGxQZVpOWllXVFB1YkFt?=
 =?utf-8?B?R0RSSWF6QWpML3BnT0dGcHZGTmx2eWR4WFBWMUNqTTFzOWRzcktZTXZsTnFJ?=
 =?utf-8?B?djhIV2ljZE4vNU85VklxWVhXNmFqb21URUVNWDhUMDdtS0Q3WG9qQzhCbWQr?=
 =?utf-8?B?dTFtQkpDK3JVUlVTTWJFVmpVNDhEQ0ZBbVNXUmd5eExlTDBLcTQ1YmJKS1lj?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5677dbfc-e42e-40bf-bb06-08dce7be1a95
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 17:24:45.7875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCchZmoeLj5nqPMvwgCHUCi7Usa/YyfUJ6/0VXw0d5V/s4IblijVdG/BPgYX/+hrpDYe6ikyxFx+JYT0cojXvoSEMwCVTskVnndb+5kU+fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6235
X-OriginatorOrg: intel.com



On 10/8/2024 2:14 AM, Paolo Abeni wrote:
> On 10/4/24 12:54, Joe Damato wrote:
>> The sizeof(struct napi_struct) can change. Don't hardcode the size to
>> 400 bytes and instead use "sizeof(struct napi_struct)".
>>
>> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>> ---
>>   drivers/net/ethernet/intel/idpf/idpf_txrx.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h 
>> b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
>> index f0537826f840..9c1fe84108ed 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
>> @@ -438,7 +438,8 @@ struct idpf_q_vector {
>>       __cacheline_group_end_aligned(cold);
>>   };
>>   libeth_cacheline_set_assert(struct idpf_q_vector, 112,
>> -                424 + 2 * sizeof(struct dim),
>> +                24 + sizeof(struct napi_struct) +
>> +                2 * sizeof(struct dim),
>>                   8 + sizeof(cpumask_var_t));
>>   struct idpf_rx_queue_stats {
> 
> @Tony: I'm assuming you want this one to go via your tree first, please 
> LMK otherwise.

Hi Paolo,

This seems straightforward and we'd see the issues compile-time so I 
think it's ok for you to take directly.

Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Thanks,
Tony

