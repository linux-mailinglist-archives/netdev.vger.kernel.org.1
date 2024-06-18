Return-Path: <netdev+bounces-104542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D2F90D285
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238101F2525D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DEC1AD3F9;
	Tue, 18 Jun 2024 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgk5kZ8z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918CF1AD3F4;
	Tue, 18 Jun 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716788; cv=fail; b=YgvXulJJ9d7fPgAwClcs5T0cd869MFqI1gTybI12+TlestQoQwEmjNb6ZlcMCuWCdQN2gRX9OhG6eqU6ZhoMKsQoR7BJz5R/RaFeT68M5a/CCPyuJxH89BuwBxzMGEZizb1xysfexR2BcFRcelDvsQ0Zh8oNy/0iOCdQgxzd86E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716788; c=relaxed/simple;
	bh=mlytnvxZUIcNVXRUG8PB8CFxoug4Xk/wQgp7aogSuno=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dentNzC7Drjl4cgFT2oC0Lp/CNNQ/Mw79qQyd+V4dtDWlimg0BIrlspR0UfXSJ9TQrjekOUk/be1xzovmMdSnKWj3QjDQO5Joj2+XGBbbM+a2ak8qCOoFiMJot4Nq14tY4W1BlvaoNRBKyLL4T7stM3L/c+omRoJ+D3eow1jomg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgk5kZ8z; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718716787; x=1750252787;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mlytnvxZUIcNVXRUG8PB8CFxoug4Xk/wQgp7aogSuno=;
  b=kgk5kZ8zdy7rqDxFL3rcOQDbRLFrxC8DcHQ3e9hogbrzuMBRQn6Vb/2H
   sZA7HgLJUtuZ/uxNk1KX/feDbF8vY741BaMU6/Hpr/7CQ0m8UZnWE/mH3
   1R7O6y3dcZZXJl0wuaDdI2CZB6eXlB9UdpMMEsptHqZ7engtIcMekXEFD
   h3rpnQsQRBUFhuUmoVrX1TBt/C82iD3fsLVcASJ90fxgbcb16eoyuMPcE
   fTuv0pPLGG5yZESnZ6hUWOx8R2IdZEXPMaSuhVYHalOfS8bUdv42WFqqR
   HB8bHvbMa+k3zg35iTheeZEAPLhYwJ56sBI4XP0Toaf0pM4yJet2I+qRT
   w==;
X-CSE-ConnectionGUID: 9tBiYtlGQQmgy0wnne2Frw==
X-CSE-MsgGUID: FmHeApXKSPK/IPPx33KE0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="41001498"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41001498"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 06:18:55 -0700
X-CSE-ConnectionGUID: J90bLrssSmamzZ/Tq7G2xQ==
X-CSE-MsgGUID: AbDJY6OVRC2IyhSZGWBRfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41500282"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 06:18:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 06:18:54 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 06:18:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 06:18:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 06:18:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqFLg3MWOtMC96StTFyF9GD0O/gBPYZuwVqfMd3w6E/1HRQzlib0N1b4IpUOclL9X77x5u/U5UxEWgV4yg27tD3MWUX6/awAugCVeehclBPKYTdRZYb7oHgQMKUV2NKiL2ClRhzCvvjG483bdEm9yGBbn7UxU56lfgog4RfXehLrJlYWUXh/wMCGK3wTEjJd3LoakqoJqlN3W0UoKy6JwbQfn3TQlRhOdAdT2g+XYubRjMCEo//FZtUBZLeWtQTnFUcnvvt1P+MNF9hVmxCPc7OOG/4QwL+wrnoIupAVJwUpCRiCM004Yiw4fGW9SMNplHxBs+NofcBQrqwadh2ytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALM4LMMWzcq11QGqu7OiSdjiZT8glGCxdWKSmz/J8kk=;
 b=aovRct/KEMIPj7R6rw9n2OAlU0i0RUsqYqV7MGrpEZlmBJxCYNDezd2ADF3q3wr7xHPdUvzHlSgNRxLXZKVAbinQjTjrZNQ9JSicTCOuL/SfZ6al/q0wbhoK57soy3bzgpxmfOyA80ZQyQv/RPm4KLqlLq/2jaR3x8EIuorrN5JJnxm9/aJqRvNkPgvAvdQcG8Ns/i7SWaisC1eQBT7aZ24aWpihKIoi+keBOOdwoLlzkXslaLpN6qWQhRUsSgOfsdQwgsv7yYn9nStCpGO9vA9mi7CJ4wz3NZEg69JluD5qfXqq/awFb7ZlyQhJpdT3IzJns1inTgyIdNneCQWrEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SJ2PR11MB8513.namprd11.prod.outlook.com (2603:10b6:a03:56e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 13:18:47 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 13:18:47 +0000
Message-ID: <a86c1fcd-6d00-4c31-9d15-5a801fd6c7f4@intel.com>
Date: Tue, 18 Jun 2024 15:18:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: dsa: mt7530: add support for bridge
 port isolation
To: Matthias Schiffer <mschiffer@universe-factory.net>,
	=?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, Daniel Golle
	<daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, Sean Wang
	<sean.wang@mediatek.com>
CC: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <15c28e5ed5fa02ca7904c71540e254617d571eb8.1718694181.git.mschiffer@universe-factory.net>
 <499be699382f8b674d19516b6a365b2265de2151.1718694181.git.mschiffer@universe-factory.net>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <499be699382f8b674d19516b6a365b2265de2151.1718694181.git.mschiffer@universe-factory.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0116.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::13) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SJ2PR11MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7ff48c-ae51-404a-8f74-08dc8f992fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGt4amQ5T3hXMk95WlhaZURmS2VZVC9TZnVJVlhXb3JacWxYVUhxL3NIcE1z?=
 =?utf-8?B?WWVUMGhnbVFXRkdieWRKdVVpZ1RBZzRaYlA3M1VPc2R6UjNIeHhqaDZZS3VN?=
 =?utf-8?B?dDdDelBaOFE3N01mWWhGOEpuOFpUM1drVjFvNi9vZVIvN29NN2Y3SU9EUWs5?=
 =?utf-8?B?cjRITk5BUThiVjkzY1B4d2Zuc01qMExseTdobFlTeVFXZVZkM1pldTRmdFda?=
 =?utf-8?B?ZjFnM0E0amFwRlhHdDdSM09LMUtzUHNNMEE2NzA3WS91RFdpOVYzK3FOR2g5?=
 =?utf-8?B?WS9PZEdhTlZZbXBHZ1FHaXdjaFZHZkVvQXRBL3QyV1NIaGZSQTRPSUJkbWxL?=
 =?utf-8?B?QnIrSXZWcEM2VFZjVERCb1hFbXVsY0E2YUZCWitvbEdmNmgvTzFuQ1V5WEJL?=
 =?utf-8?B?RGEvcmt0MkFYcEE3cXdtUlFWUUhlSkErTEh4eFFSMllNd1kvWnlwMlp1M1NV?=
 =?utf-8?B?YS9XSUFBbmhLbFFXNjZqYjBVUTN4TVFrbk9OdUM0RG5abkRBT3B1T3VPTkx3?=
 =?utf-8?B?TmNWeUFocFNDbUtoYVpCV0tlVHNjamJuVUNEOWJLSU1hNHByUU5FUUljVTRj?=
 =?utf-8?B?Q1hlVVlOdVFPL3NHeU1COGkxaXB5NkJURkpBdTRmdHhQWlorMDJodWgxZG0x?=
 =?utf-8?B?eUtIeVk1bkhLQzlJNFNCYnY1L21WR1NoQzlCS3JRUUhoY0Z3TWNaZVh3Rk5n?=
 =?utf-8?B?YnlNU2JQN1JXNzM1Smh2Y2g0dU1WWk1ITG0zN08yZjFRODhOb2wvUk9RSXVX?=
 =?utf-8?B?UE1VelNCeUhDZXY4SFdNWmJFOE4yaHRjeC83Zlh4SlQrdzBYV0QxUzEwV0t5?=
 =?utf-8?B?M1RzSmhuU1RPOUNqcHhkNXFMeEJ6TkJDVXQ5UDZ4bGJ3dDhyZDl2T25jc0sx?=
 =?utf-8?B?aklhRklmOEo3b3FRTDZUSU1FNVNsVnNBTXc5akpObmlvNjJHZkJISitJN3hE?=
 =?utf-8?B?VDdVMzB1elJlMUo3a05lN1JrN3pBZ1pHcE1yb3krTXpKWVRDQTZmV2VqdFFh?=
 =?utf-8?B?S0duSVBNblV1SnpqeEpKN2hFTXVvcTluMVIveExOYyt3d0FvWURkbVZrN1ZZ?=
 =?utf-8?B?ZFBjeEtIcVB2WWZtK2RLQ1J5aytpT1U4YWxJWjBFamdML2YwNCtlWXRxZ3hp?=
 =?utf-8?B?dER2aW5abHZMa2ZEa2plVS8rMC9Rd2xFZjhxZ290UCtRU29maldNSWxkRGpq?=
 =?utf-8?B?Qnd2ZmZiRHpEbllMSkMybzQrcWcyMlZaUlRTZnF0QlVGeno1K1VUVGlsazdL?=
 =?utf-8?B?cUxSZkUzUHhPQ3dISnZHSk1lZjNGaStTSFJYWm56ajU0T0tkZ291djd1VHAr?=
 =?utf-8?B?T3lveDZJRyt0WFRIQS9EVHB6ZVY4MVF0enhIV3YrL0d0SEsrRlRpeVUraGVt?=
 =?utf-8?B?TkIzUVV3S1ZaaVhjcVVrdHRCbGtDNU5XNy9jRHBMNHFPcWJSd3EzcHBpN0Ry?=
 =?utf-8?B?NEMzazlFUmRyUjRUZjh1YW00ZUlGbkR4cWNDbllKR1A0SkpzaTVKRGQ0T1l4?=
 =?utf-8?B?b2Y3RXh1M1h3T3pLTy8yY29aK2dmWCtoMG1wTGJxRkhOWFQzOXB5dkZtR0g0?=
 =?utf-8?B?cmdGTTYzQmRBOUFkaVBQc1ppcTJmbmFpRk1xZHorTE10cGpRbjF2b1c0MWpa?=
 =?utf-8?B?ZE5GcXR2ZTJkbnVpRk1vWCtwL01RYVZ0bkd2R1NYcTVkeW9VSUUyaGhhVFNy?=
 =?utf-8?B?Z0p0bmE0NlFMTEM5VGp4eUt0S2ZVUlZCUklPNzU4RnpGYVJ4eGI1bzVuNXQx?=
 =?utf-8?Q?9N/3A7ywCHeVQFc7IKQmr28EN2TIgEWlE4XD4/b?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V094cjFMK1B6WmFFZWJrNDE4aTl5Qk5BbGZaRkVUcjBTYUJrRWZXNWtINCtE?=
 =?utf-8?B?TmdBeGRVR3BCcWxIL2FGY2w0SjRkRHN0Q1B3RldJbk0wQ0Y4WHgwY0ZkZEcz?=
 =?utf-8?B?OUhhL3BxYVFadktxY2U3NWpLc2t0N05sRzJzQ0k5NE9VRUFZc2E4Nms1TXE2?=
 =?utf-8?B?R2hmam0rTFUvSHdWS1ZBaWl3Q2dzSTIvZm9WREZwM1A1MUV0bm5wMFJMcVNF?=
 =?utf-8?B?aEZQcnpPM2NJdEJPVmNzOU5SK0N1elJMVzR1Y3VmakswZ2ZYaHRtMmU5dlU3?=
 =?utf-8?B?SURnKzRBank3ZTBNL2QzVGRYNDdYeE8yeW9ZOUJub2YyQkEvdkV1M2szT2hE?=
 =?utf-8?B?QktKakgrSzBZbGR6WjYycWxnRXlFU0lWMnlyWjVBcnhYWUp3ZldueUgvbDl6?=
 =?utf-8?B?VWlIODhRbTBOS2F0aFpyU0QwOFFHRjdjeVNYajljeGhORnQxTkxLeGlBQUs5?=
 =?utf-8?B?dGhacWtzSVoxQ0ttSHNiQlVQT01za3h5bzlqQUNETWFUbW0rd1lrdDdxMUZt?=
 =?utf-8?B?S3MzM2tMZGdTY2ozRllFYjBnWEpIQ2pUQ2Erd2V5bHB3ai9kMmJyWVB3N3Vj?=
 =?utf-8?B?YTZ0Y0x6TWlYdVFvdWExaHgvc3ZvTjVnMDArbklVWDJLNjM5YmNtNGZIS1Rp?=
 =?utf-8?B?M2F5Z2hZNXhaVmM2dHc4N1pXYlF0cm5TWHFrR3FYMFR5c003bzhMUWVlMUFq?=
 =?utf-8?B?Skx3a1J5NDFwaWlZbmFVM3lFbHZwN3lkOHYrYXZZRkdrUml0OGJ5VUFRb1k2?=
 =?utf-8?B?Rk9tWWNRTDdDTUlKdW5QdFdaYnkyUlM4RkplWFBCb0VSVFp1N1ZxY0tBczFr?=
 =?utf-8?B?c0hQbEQycWlGd2tsenRBVXNrbmMyN2ExZ0FET3ZiYldKOHFucmtXNTMzT0dB?=
 =?utf-8?B?YjJPU1dvUmpEcDFHaWFpWStXQm1XZGZyVGgrNVFNUkowZ2lYUnpBcG9rSEI4?=
 =?utf-8?B?YTFrYVFzZ0NscnMvanYyd2l1Zk5BWk05bmlRVGpOUStwS2lJMnZhZ0srZnFQ?=
 =?utf-8?B?RHpjSk16VnF4UGV0Rll2blVTY2NNS0dDZjRJMmtqMHVPVkE3ODdqV0FtaStz?=
 =?utf-8?B?NXJMeFNzamw3Um5QSTVSZ1lhWUhBV3RBeW9GbkRMeTBCM0poejBiZ1QvMDNZ?=
 =?utf-8?B?cnJyK0YzYk9HL3lUUU9TbWNYNEhHSDVSMVdkVWllNktwaUdxQ294YUJFaFNM?=
 =?utf-8?B?c0w4MFV1dEp2RGlzb1U3bVgrZ1IzMVJxTVZBWU9TVW8rS3lESmJKRVE2Vnhr?=
 =?utf-8?B?ajdnbU1LKzNLZzJUbWpqVGx6OUVNMTRQZmZDbUtVaWl6M1hsNzhBN053dzlW?=
 =?utf-8?B?dStlbDcyeDFYSTU4ZFIvZzExTlBCYllkQkdhNTdXZ200elhDTG04VkVybDRI?=
 =?utf-8?B?ZEpuOHd4alVyelMyS0Jab3dVMU5mOGJBemZtQlIzQys4ZmdKT2NndUR5SmVy?=
 =?utf-8?B?WW1QTjJxNEMvUlY1RVhtL0NqNmxyNjk4cjBvZVlEVk5oWHF2cXZ1bVRFSkww?=
 =?utf-8?B?STE3alZ1cTl5VmNQVi82OS9UcUZQZmwvd1FBbGFaSmF1TVRTd3QrTTZrMDlt?=
 =?utf-8?B?ZENNRTRRRlhvUkpyelpyeHhsNnp4LzhHa3VvM1c3UzNmR0FiWGd0WWVzN1U2?=
 =?utf-8?B?TzZUUkhtR3ZFZXhXN2QxL0h1T1J5dzExK3RiTzZtLzBzYis1czRxSjZIVUdv?=
 =?utf-8?B?Z0VYeEwvMVZsMFkwVXBOWUhIQTBtdW9wOFk0TmM3MnhXc1ZCSzV3cmZ1d2I3?=
 =?utf-8?B?VENDNmpqZDdZOW45K1NKa0t6RS9wVmwvYUZIM1BZZHNWQnVBdVNTVEh2L2xm?=
 =?utf-8?B?dFRTdzNVYW5hTlN6Wjg5RWpwREUvb3Vld2JuK2VXdnpKaUZybCtqUDJLWjB2?=
 =?utf-8?B?bnAzVjlQd1JTNjFmNjBwQVF3UG90MVdaeVZUUTgyMTFnUmVGMGlaaTdmSU43?=
 =?utf-8?B?NFhzNy9OcEVESHhvT21pSVhOWHlHcHo3NUZ0RjFMUENRcExkT2kyaW1UYU9Y?=
 =?utf-8?B?WUtaUHJ0NDhiZDlpbWVlMSt0R25DR3duNWxxSmRJRThXSXJtelU1d3hVU1ho?=
 =?utf-8?B?eTF0R1N2aHhEN3ZkeHZjamlzbVN6bTN6MkdEdWtCWnlyUWpIQ0FXSXBydktt?=
 =?utf-8?Q?R1XcUCqRo9B+Ph8YupLsk27bC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7ff48c-ae51-404a-8f74-08dc8f992fc3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 13:18:47.6252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHqIjPEeDJCMUfPznZJUldTNgTcbDpP3gvW5TSFoEFx1oK2x4xPslOVDyUd2BbLdo3p6pF4/4kQvbabIhj2f+XWiccc3kOFeFPPIl8TrcZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8513
X-OriginatorOrg: intel.com



On 18.06.2024 09:17, Matthias Schiffer wrote:
> Remove a pair of ports from the port matrix when both ports have the
> isolated flag set.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> 
> v2: removed unintended formatting change
> v3: no changes
> 
>  drivers/net/dsa/mt7530.c | 18 ++++++++++++++++--
>  drivers/net/dsa/mt7530.h |  1 +
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 9ce27ce07d77..ec18e68bf3a8 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -1311,6 +1311,7 @@ static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
>  	struct dsa_port *cpu_dp = dp->cpu_dp;
>  	u32 port_bitmap = BIT(cpu_dp->index);
>  	int other_port;
> +	bool isolated;
>  
>  	dsa_switch_for_each_user_port(other_dp, priv->ds) {
>  		other_port = other_dp->index;
> @@ -1327,7 +1328,9 @@ static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
>  		if (!dsa_port_offloads_bridge_dev(other_dp, bridge_dev))
>  			continue;
>  
> -		if (join) {
> +		isolated = p->isolated && other_p->isolated;
> +
> +		if (join && !isolated) {
>  			other_p->pm |= PCR_MATRIX(BIT(port));
>  			port_bitmap |= BIT(other_port);
>  		} else {
> @@ -1354,7 +1357,7 @@ mt7530_port_pre_bridge_flags(struct dsa_switch *ds, int port,
>  			     struct netlink_ext_ack *extack)
>  {
>  	if (flags.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
> -			   BR_BCAST_FLOOD))
> +			   BR_BCAST_FLOOD | BR_ISOLATED))
>  		return -EINVAL;
>  
>  	return 0;
> @@ -1383,6 +1386,17 @@ mt7530_port_bridge_flags(struct dsa_switch *ds, int port,
>  		mt7530_rmw(priv, MT753X_MFC, BC_FFP(BIT(port)),
>  			   flags.val & BR_BCAST_FLOOD ? BC_FFP(BIT(port)) : 0);
>  
> +	if (flags.mask & BR_ISOLATED) {
> +		struct dsa_port *dp = dsa_to_port(ds, port);
> +		struct net_device *bridge_dev = dsa_port_bridge_dev_get(dp);
> +
> +		priv->ports[port].isolated = !!(flags.val & BR_ISOLATED);
> +
> +		mutex_lock(&priv->reg_mutex);
> +		mt7530_update_port_member(priv, port, bridge_dev, true);
> +		mutex_unlock(&priv->reg_mutex);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index 2ea4e24628c6..28592123070b 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h
> @@ -721,6 +721,7 @@ struct mt7530_fdb {
>   */
>  struct mt7530_port {
>  	bool enable;
> +	bool isolated;
>  	u32 pm;
>  	u16 pvid;
>  	struct phylink_pcs *sgmii_pcs;

