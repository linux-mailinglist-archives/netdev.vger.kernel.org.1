Return-Path: <netdev+bounces-108945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 711CC9264B4
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DAA72813FB
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ECD17DA20;
	Wed,  3 Jul 2024 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnwrUEnQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E501DA319;
	Wed,  3 Jul 2024 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019936; cv=fail; b=YoDmEf8CkpRPVvt3BnJ/V/gksrn5V+UCRbofzfW52ThqH/wMP3IaZZc1a4DYCMtNShgQRWZtYrpGgBVDlzOd11phdQpOvqNyl6lFYRQKfDIv2MTY9lFoltIrFXD4NYshd65EiwBbnrFBTgphXN0Hw2nbFgE2RImzAdCSCtKKQ5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019936; c=relaxed/simple;
	bh=HKZa9+x0GbbpO+K2b2Hr+1ssuABgTMsrtWv3iDN8b60=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t1+plFZLvz/MfBwQO8yjjKdqkdXd4Cko6IJbOW4mcnMpPfcw8eX/OwrMnjm6tAA6omXj2hlLtX189N5OZX2/8kshiJN8O10c7CKJkp3HcCLoJlrjBgg+IvqRVilxWQPxUcSrHYihbJ9IOdpcs5M+RhCAxZeUlR0xDtKj+onw/r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnwrUEnQ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720019936; x=1751555936;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HKZa9+x0GbbpO+K2b2Hr+1ssuABgTMsrtWv3iDN8b60=;
  b=hnwrUEnQaR0kASB4dnPxBz9l2jcAGcnmiFlVFxhudxwXsy9rFyt/yuaX
   pahLu/8RNPcPYiF8wYspg4fhvAAFNTCb3irLniNAbcQ7esW9Usicft5qg
   c1jqd+TDVUKsloWQTQ+6fS/SbuAuF0k/X1IcVQgT219Y1M1sG4HD8IAy0
   hIKWpk7hmxWxeVGPa0ZXvl4A1NsdJQTXRQZ4bsP4J8rC/f4OTbo3mU19w
   XYJCIwnuwdzT+GoiNJtzJhio8hUniAlT+6p1fZirAfKS94Dpno88n68AM
   nudICg8tCnhPzOs3cyQ8doteJQ3jMcJSaUSXbF3KUs1R+8PCLBgGYivMn
   w==;
X-CSE-ConnectionGUID: 6Ky8Kkg9RKmITs/MVsZYhA==
X-CSE-MsgGUID: QQqOqg4NQAe+iViOpb027g==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17082585"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17082585"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 08:18:55 -0700
X-CSE-ConnectionGUID: takW0O8US4m1r62AaN9k+g==
X-CSE-MsgGUID: xu/RGGmrTCm03GKdeOx3AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="77021225"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 08:18:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 08:18:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 08:18:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 08:18:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIcUiLwZ4Pc3wqsFKgdO49f/Dts5YnXiQkKuV3T443JcgPIb9ul67WK5D193rfuEYxXnA494mvIvv7g284eS11o0o8yoxElDgp0Nsi/HEpxeK5XwUlwaTrgIUK35ndKjJkpoEQDR32rp+ilriBSiVOPjbtNhNSKJiLKiGezKNTZU1VGe2Dsb48D+ZB+MkLO7SRDOpeCrJnZoiCQHIH5pC0rkCDCEnKMUGczzWLa/onyznREp12jBA+T7LbMwb1wbszBJI0CoYO39REEN5wbIniuktYbfLWZYsLgCeKUCg+qWrqGNEUtTLt/uG4jHpkh1kcivITGAaN29acgbiSFK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhS431v7eb2mHYXSaHCJlEaWT+bYl45ZIxcs861VyNI=;
 b=hCccc0f5pk/vOFOWynTetbw2dgHUoiKa2gHX7EpJtRrdQmWhOqT5HRE4Uw5JLBpQ/E1A/D8W+Qy/kXwzpD9kTPaCyWHE1duPQ5+P2Nnly29EZg4Vkk1/5nqKut0pSTf6OmsUHnYH5jyeM+UpwXiM8ZCvG9C8HVKoOxebXiycJRe23OC21K5mVK/NiIxjjudXYTRLNibiPabu7wA38rnKE6sNpwg6QJcIXo+ocesdIcpqSsZHjVcAa+mEDvfb2PiLUOOvlHMqIBXYqBsytGdAl3frLcWwMmVOdo0MpZ2Ek2WDpl6vDqpclhxNFpBEQBZdHO3UZ6RHjQCQ3GcJtGM1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by IA1PR11MB6394.namprd11.prod.outlook.com (2603:10b6:208:3ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Wed, 3 Jul
 2024 15:18:50 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Wed, 3 Jul 2024
 15:18:50 +0000
Date: Wed, 3 Jul 2024 17:18:36 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jeongjun Park <aha310510@gmail.com>
CC: <jiri@resnulli.us>,
	<syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH net] team: Fix ABBA deadlock caused by race in
 team_del_slave
Message-ID: <ZoVrzGBouwEQU3Bu@localhost.localdomain>
References: <000000000000ffc5d80616fea23d@google.com>
 <20240703145159.80128-1-aha310510@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240703145159.80128-1-aha310510@gmail.com>
X-ClientProxiedBy: MI1P293CA0001.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::8)
 To PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|IA1PR11MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d362b8-d051-4a9a-0781-08dc9b737165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2e9zHGNx6bkLQkutCWYYoempGOKbHID27tLoBLeQBiAVbrJFc/nIvQx89DYd?=
 =?us-ascii?Q?kEby7QuJLO6zoZiZHqWqKmbW/2al6HpUqO4nQEuj8dHPW3n2tabuMZbCP0El?=
 =?us-ascii?Q?gABOSgV8yvLtvvMwOrJps+rAfnAOMFcnU9LoDtkPqShDsQ5rTIusqkPLXeem?=
 =?us-ascii?Q?5LG1O4QwUAGk/JLIxSFmWzaIQ7jIrcC3lQt719r8EbgxNBV6N/neD/ZNeVwD?=
 =?us-ascii?Q?ougpluTTm+R/xWPFWlBC68h2ntG0JI4ldbnNVu6MxGT8eztr3cn8+U1FOVGr?=
 =?us-ascii?Q?KLMbyZR+AiHWNYukeByp1qif7B96oOlK2AQtb+K8asGRk5E9+Yi17HE/3HjT?=
 =?us-ascii?Q?iZ3VAphGMOGrs/cIkOlVi5xn5iS3BQXkaLvxfe0SZdzECBeIPyg8qLYhtBTF?=
 =?us-ascii?Q?1ui5kVU4qnjPMdNhnIjap3J3oPZxjKGHRQ7DO7t215aKrjOEW3Zknqvf/NNb?=
 =?us-ascii?Q?1De/U3v0OcwALQdeqEsw9QSVs+0tbpl3y4OfxvAbPTPgHkR5cHMjY3CkjFox?=
 =?us-ascii?Q?AK59GRSuRdegW2su67WoLwIjsG6yNW25AtKYf5maUTd2H34M16LvlPZIjReO?=
 =?us-ascii?Q?lQ8SOS6Rm71xgKMjWtyi6mDnjtiC4FtDxEi6mjRZnbGoa3lvQ1CyV6lxVKAd?=
 =?us-ascii?Q?DI+C1u7ULhGccSzQ7wJTsCs3+ODo+dD0l95iynT2aAUY8Aq9MR4FHfj+7X5b?=
 =?us-ascii?Q?Y81xkYoDwao7D7pgss5NnubQrbcLxZbU9r7PP5H33gn/04EBPqBYFD7qRZ0L?=
 =?us-ascii?Q?wFgFJWc+QpkNF4/bBrjQyl0sTVut1DCulF7Rw9hwoOnTfgYR+P5OZfGhOVGo?=
 =?us-ascii?Q?5OocmIdtVPOAc7FpWYXEdTEgiUNgFvvirKurVFTZfFL4q8jIzwDiPpdez+jj?=
 =?us-ascii?Q?D11Ub1cc84+oanB/ZqBlVAzooQt2LwmPBHcTTXAN2OFCfHDrG6YWmfEY8KP6?=
 =?us-ascii?Q?9up62ssjI3ep2jk5RsN1b7F7p8baE49+UEUQOLuC5Z7NfQ/AZFAQf/HpNssq?=
 =?us-ascii?Q?qNL+FI/rIjAa2G+2e2Sp19xQIIjpPiYOC+GF65oayYhTyr8kEBToqZrzFqs1?=
 =?us-ascii?Q?8OCzONjWBI5CrKAOD9YqycSMqKQKHmZqlOFcixrzMPJVAoHQ8MMTjtV3vbSg?=
 =?us-ascii?Q?ZY32T/1w+eema/kq+FxrkyLjv9RERvv3Q4FSujtin4BbfI9Fx1x1th5bHjhr?=
 =?us-ascii?Q?U56MampUZIHzq3Vf1Jmny3gaDQUgjkxKftUSV7v9/zLzd/lz9J8sn0XefNkF?=
 =?us-ascii?Q?vsmwymyregF8A4OpT+3yiYxp729VNfDWUfzWRcGEn9yP4XHt0uGAOIpJ91FV?=
 =?us-ascii?Q?fQoczddKixDGqKFx8xeKa3g+xSsdCe4ncpETgKhe8T5QmA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NLfIiTMZiHOixNCM4N8PJq+1O0i3R3prBCMtVkA7s5tlMYls2UMh6i0YvSUc?=
 =?us-ascii?Q?AdU+HPL1iXfNlQJZqZNhdDk2mVkfomkOoOAhPPvFa8JzUfX+HMKnUosaTH9+?=
 =?us-ascii?Q?KXhzYm5LvVxoKLOP2SBLC406jHVypZ9WZUOfqsL9gBxylSdI+cZpI86Gj6nL?=
 =?us-ascii?Q?rrD/gN9hARClBd6ul3l4DOLbgli0p7ns4LL1nM+LAQEt8oAlc6V+JTCXxbur?=
 =?us-ascii?Q?sIX8XGV1sdB3pyT7SVRRp5rIwbU0UQv18/Ht3kTVTdSKalDb06YvdjfX8A9B?=
 =?us-ascii?Q?WqVeP/tnHzwuPQK+sM2MRKTWTTAUMmFmwYl2CSOHROKBlMWGc6EzrqSUcVzL?=
 =?us-ascii?Q?1zNdZDPkr8RTq+T58bfcM8bEtVvszdEOiIAokvluwJUULN8JXLQT1tuIrr9y?=
 =?us-ascii?Q?vr3G7tCHx7aMAVb1X0OZwVYRXgfOQjfqRyJOLElsj1pjOmSiHikXCn1GqQ/m?=
 =?us-ascii?Q?blhUudqnTKCv4Nrm8NUrY46OxO0UoU3O6DQM2TC0UD6Kd/gw40Dk6198MFBJ?=
 =?us-ascii?Q?19zbB3HLMzBG2OO2ngxb3pyQD8I5xbuA1dpkEYkoevfT/z1RxXIRh4+3eoRF?=
 =?us-ascii?Q?liI/qWn5oX91It33mKbyHLTb8HybXMp/A5KPTpZ6NAG69VA9o91Pp8QsoggK?=
 =?us-ascii?Q?/TnTwLQAyA7CMAde302QpCViY4L9InUhoKmOFXwfZc+bSdhek2WaY87ap7yf?=
 =?us-ascii?Q?tEjmWBxd1mGRVJufw7ECD69cANJYykqShzAsdz6Ojx5T+xFIWVN3wdEXE4UB?=
 =?us-ascii?Q?FMn+wfCOr8iMUyFrV9kESVcEi9A423xFwjgWY5S+RTt3dWsE1h2V4hAFsGqf?=
 =?us-ascii?Q?bQeuZ1I961vonykLjHyrzS8Zl+3P5b1iBODet80NWi+ySoWjhe91gbc2Rrde?=
 =?us-ascii?Q?E3liyzHRkUTcbb+jgyfdEqD1nCHSznaa/Ic3p7ktMm2sDb2rT5K4NxuP6G6X?=
 =?us-ascii?Q?X1nkqgx7YhOJhp91m3Gf5LySBPPMZ2LlkJTQ6ijueUZPIc9jmCw3Yx40oxwv?=
 =?us-ascii?Q?q4vm3az3ViXak/UANMU7M/nGMMUw9oNmjwEDU65+w8a1NqUaAjtClFpMKS2Y?=
 =?us-ascii?Q?+ZD5qy7wjBvNB5zZT+ibp2gmXETHPNCXLLoua+CQYncq9zoh0Lsns/rv3wL8?=
 =?us-ascii?Q?Oakrl22uZJisZVk+ygLHqTXSuM6g+BhQk3yg4nb1bJJ0F+tvKhzdCbSU0Hgl?=
 =?us-ascii?Q?8BoVY/TL3wz9oQ/gcR2QAK5Db445n3qzqsdtPhqoKRU4PFUjPByao3Z4YW8X?=
 =?us-ascii?Q?+bT0E8oqoUEH3cBFLDIyIQ9YisYtm3ZgmwZv6zw8yT/1EqLGP56lbwtvvfud?=
 =?us-ascii?Q?2PkP+u9xHkyA+Hwd+4N2X94ZyXZ70qB7jaUDO9le7Bnzgo7LSvpIC4DPCY2B?=
 =?us-ascii?Q?KbI628b5L4dyCvs7mdMPXyyLsPX8KCIujx4ILuAQ+XA4RobnzaoDFIv5EvWa?=
 =?us-ascii?Q?WdbQT9prCIn73BriwIsrdQYjZO23oPkToq8rMQrVookJMzsg1+X3nxFw4gea?=
 =?us-ascii?Q?IZ7tncVK/ZhShK9qYdIY2odJBJMN9tU440rK8R29yE76hrjOdFl36FPycchV?=
 =?us-ascii?Q?u8EyqEZaoGGnN6iwF/2Ev51A+DsPj66GisOduviO+h0BeRU8bfkKP+IDqtBV?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d362b8-d051-4a9a-0781-08dc9b737165
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 15:18:50.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iL9QwkoPqEInDYu52mgarfeDQGoNJjskcE0YMGkuxiWZpKIiJbCzsR5FkyQvggNTWSh56aGcOfavHLYxW2AoLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6394
X-OriginatorOrg: intel.com

On Wed, Jul 03, 2024 at 11:51:59PM +0900, Jeongjun Park wrote:
>        CPU0                    CPU1
>        ----                    ----
>   lock(&rdev->wiphy.mtx);
>                                lock(team->team_lock_key#4);
>                                lock(&rdev->wiphy.mtx);
>   lock(team->team_lock_key#4);
> 
> Deadlock occurs due to the above scenario. Therefore,
> modify the code as shown in the patch below to prevent deadlock.
> 
> Regards,
> Jeongjun Park.

The commit message should contain the patch description only (without
salutations, etc.).

> 
> Reported-and-tested-by: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
> Fixes: 61dc3461b954 ("team: convert overall spinlock to mutex")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  drivers/net/team/team_core.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index ab1935a4aa2c..3ac82df876b0 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -1970,11 +1970,12 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
>                           struct netlink_ext_ack *extack)
>  {
>         struct team *team = netdev_priv(dev);
> -       int err;
> +       int err, locked;
>  
> -       mutex_lock(&team->lock);
> +       locked = mutex_trylock(&team->lock);
>         err = team_port_add(team, port_dev, extack);
> -       mutex_unlock(&team->lock);
> +       if (locked)
> +               mutex_unlock(&team->lock);

This is not correct usage of 'mutex_trylock()' API. In such a case you
could as well remove the lock completely from that part of code.
If "mutex_trylock()" returns false it means the mutex cannot be taken
(because it was already taken by other thread), so you should not modify
the resources that were expected to be protected by the mutex.
In other words, there is a risk of modifying resources using
"team_port_add()" by several threads at a time.

>  
>         if (!err)
>                 netdev_change_features(dev);
> @@ -1985,11 +1986,12 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
>  static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
>  {
>         struct team *team = netdev_priv(dev);
> -       int err;
> +       int err, locked;
>  
> -       mutex_lock(&team->lock);
> +       locked = mutex_trylock(&team->lock);
>         err = team_port_del(team, port_dev);
> -       mutex_unlock(&team->lock);
> +       if (locked)
> +               mutex_unlock(&team->lock);

The same story as in case of "team_add_slave()".

>  
>         if (err)
>                 return err;
> --
> 

The patch does not seem to be a correct solution to remove a deadlock.
Most probably a synchronization design needs an inspection.
If you really want to use "mutex_trylock()" API, please consider several
attempts of taking the mutex, but never modify the protected resources when
the mutex is not taken successfully.

Thanks,
Michal



