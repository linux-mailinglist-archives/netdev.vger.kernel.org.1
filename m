Return-Path: <netdev+bounces-137667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4849A9397
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 00:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB50282186
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 22:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AE11FF039;
	Mon, 21 Oct 2024 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iy/7loE9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2291FF02F;
	Mon, 21 Oct 2024 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551451; cv=fail; b=MfPskMgwnrZ8wdUSmCPto34Q8xdXuH6cBXviTBdagN0WAEJluUPo/qnJPWyyG0w68ecieeg1jVUFGBXzunbEDiC5Huhd7qFdRPB1Iivz528f+KozxLvSrNOm//TiFxMIwHT51NBu8Ks5vX/Spdg2pPc++DXN7l2zlT1BSkU9Q0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551451; c=relaxed/simple;
	bh=0OO8z3xknJInqCm3dkO8703RKGNJXA6gN26FuQK2d8w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YHdcZ9i2V3K+HR4JFXWXdyuoliXI6xCp8z7x99Y/GxywVVoreKbAnzrLF5+IKa6QhnA7iA4JkubK5eTYHsrgkoF42+kYx6gbj9FbayOHIpc0r7upf4cGIphhNmiFRfda7an3r3r2ARV6fDrvyuYKZDVNZ7tiUrE/vnnYZtr6D6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iy/7loE9; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729551449; x=1761087449;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0OO8z3xknJInqCm3dkO8703RKGNJXA6gN26FuQK2d8w=;
  b=Iy/7loE9nAni8VV1mGzC4qA8SxEvEOPWaChpo3K68fyS3AHwCN7y2a4P
   YI7RIkKEVzPKvAOq3rnDtwcY83rmdUgd57OZEyNrOc5UNKDROnuabTjXr
   LqsILIxtMRKarISjAomteZmvouigmy3yk4NmXGfS0b+A5IbXqkNA+8EKz
   cLR/sTG6GjefQjCXcgJ0q0nE4nmeCT6fWfDWcmjocmQqvNX5V+wUkOcpC
   OmKE5A2aSSFCghvdCb/9kwEjR9plVNR9XwHWMoJmp/VbOvfxDgVeDGw8Q
   O9bT3nM99LMmzEbqPWF5g8yWUiBJD+zlvrSJiErj+96XHnkDhc9o9XKu2
   A==;
X-CSE-ConnectionGUID: 1Cay3HgwSVeAsc8PaxniUw==
X-CSE-MsgGUID: CTmqoiHHSVqzYqrvL/Unuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29264317"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="29264317"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 15:57:28 -0700
X-CSE-ConnectionGUID: 6Md3o8bDRp6mFfqJPSaJIw==
X-CSE-MsgGUID: rXx+u78JQgKk8KaMPOa6mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="84277213"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 15:57:27 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 15:57:27 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 15:57:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 15:57:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 15:57:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTQfyZMNxMiO9z2X72gfVzocTxgAzwejf8LGxUW3xCJCXna1BxuiROzR04I0Ev7hGhqWSIaBDlgLJ+q/CQqaE4vGLZiQmIlbtcsO2ShVHHYbnRzDNm2fzWxDO4G0LrnxUMVvEOu3kJRPkcx2rZG40GaNabJUbjBAURIdGrmfuR0Z7m0Jw5v53OV89Y5wo+uQRIwsxs4pFzakNBrsCJyI7FNf95VUANOM4jNHm9TfS00QVm2pmIxJMM/SdRgYdl5rF/Rksy7utdGlfLnCjOAhLql9hDnDlXBqw5GmbSCZ2IikNpkoOp0IY19dsXG016FMMEa/N9KVgYpljbML7fWb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFlJK/ZHXTNLox+gcg5d9vmGxACZtU8fZJNOegLrL3k=;
 b=p1/I6S39Hgxd/DHOoYMcNIpWloJDQwRU1R1xPrAJJ9OMp7As5ajvrQTpm8y1XsEIaOrRjgtsEZaYsiTo4StHs8PLSfUYztZXKh0QFaplqqqPMs8ryRAjb7TjyYQZAUKhJYJ0ALfMpMoO9X3zbObWXOn1/vCY5hAQW9rGRlb5Ghhr8cv1pM0Ib1gFqAWAqT3lMmzc/xHxsAHw5FVlPdS4nLhP31FyxVRQPkzpRNNJ3otwmU/OoPykmO5Lw+UmV43KVwml9IVaJw2c5ETAjdDhDhxVRXKfGdfxRAEXLMVAP6Th1MG5th4IsgSsfkph/qr3ZfWUxU2jRohSr4gF242dyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB6844.namprd11.prod.outlook.com (2603:10b6:930:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 22:57:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 22:57:24 +0000
Message-ID: <e3bc08eb-a292-4b5d-bbb8-cb8787710d52@intel.com>
Date: Mon, 21 Oct 2024 15:57:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 2/2] igbvf: remove unused spinlock
To: Wander Lairson Costa <wander@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240920185918.616302-1-wander@redhat.com>
 <20240920185918.616302-3-wander@redhat.com>
 <7e2c75bf-3ec5-4202-8b69-04fce763e948@molgen.mpg.de>
 <02076f9d-1158-4f3e-85cc-83ee4d41091e@intel.com>
 <CAAq0SUkeVkiit383065nhfCibn-CG701uvaM6UHpWu9RaZE83g@mail.gmail.com>
 <8702d2c1-faf0-44bb-93e9-e905f077b6c0@intel.com>
 <CAAq0SU=n0Qym5EmpimHb=6ayEeURYpHgoYxX8ZxuFbXziKHprw@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAAq0SU=n0Qym5EmpimHb=6ayEeURYpHgoYxX8ZxuFbXziKHprw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6fa446-446a-4a95-a3b6-08dcf223ba15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHFXS3JPbTdGM05aZjJHbE1sbERiNVVYQ2Ixb0cxT084emQ2Z2hwQW9kZHgx?=
 =?utf-8?B?SDkvaUZJa2dTMWV1QzBIMGhMSU04U0pLdVhMRFlZUUF6ekROYVdrS0l3Qkpj?=
 =?utf-8?B?eGNMMVdDWDlkODhGQ1RBRHRnMkw2cTB4NUhYbGR3VnlnOWZQZnltTGlJWGYw?=
 =?utf-8?B?Ny85RmpBWVI2bGozMXQ4VGVueXVyMHpteVYxWTl1U1lELzZnQjNsSFd1bXB4?=
 =?utf-8?B?OVBUM3k0ZXUvdWduVVJwRW56Yk5WYTVQUWxZbjJTclF0R3BvcjBUb3pTOXll?=
 =?utf-8?B?WDY5VDRBZ3BsMXkwcTFycFd0VHQyc3Bxb0Q0dUh4QTlUSHNibDVGZFJlTER3?=
 =?utf-8?B?UENiV2JmT2hvVHdGYmhxM2FUUnVBbE1lVE9OKzNPd0RkVkZPMG5TUjlCTTcz?=
 =?utf-8?B?dE96M1VJeFJkeEc4VkRiSFdYVWJBRVpMK2IvOFU5cXBsc3E4NFBHOHljU2Yr?=
 =?utf-8?B?eWJBU0JWTnJoRjVMZDBZdXBoTDc1OFlIMDhJSGE5QTNPSDBkRmtWZEFvb1h4?=
 =?utf-8?B?ekp3UDN2Z1dpQWtFanc4dGg3N2tEOS9hVmIyYS9qNlFZVUR0RjFTRzM4Y2dV?=
 =?utf-8?B?U25zMXVTNzZ2K2tiM3VIMkxEc2VKZmJ3NWNEVEpvVWhuVmtnTkI3S2t2c2U3?=
 =?utf-8?B?ajFvbFJaWVJyTTJwcGdwY3Nzc3JPM2U2ZE5kd0o1S0szdURlUWU2QmM1KzdL?=
 =?utf-8?B?U1QwU2RaVlYwRDdUTCt0SU5Hb1RwQkIzdHBvV0dzbkcxMDMwSjdoWlJjTGk4?=
 =?utf-8?B?MnFWT0VDNERhNTBBK3RJdXJBZSs1MG5rS3I4ZzJXVnlxZ1dFclEyNUZYR252?=
 =?utf-8?B?VHZOSU84THJZUVV4L1pSWlJSWkRvdXFCeUlSSFNrVWdLeHFQM3lzalpWYjRH?=
 =?utf-8?B?Rk1NU2djRzdodTRFQzlWUTdsU0VNNEVWRHlKZDNtMk9SKzhZblE3NmtGYnVQ?=
 =?utf-8?B?dUo1SUo1c1hLNUs1R0NWSmIvUVZ0alpSVVhvR3JrWE5rTWVRbGtxZ3I4Rmho?=
 =?utf-8?B?dTM5ZUJIMmRvWG1GdzBlRHVBaUN4M2k5eGFRRnhGVFlMWkpJMjdUZjVMVXdk?=
 =?utf-8?B?WXdCZDY0SSswaTZjbnc5VVZUMjBGUzZPMjNwY1lyUEQrUnpQbjdpZUp4NWNs?=
 =?utf-8?B?akozSXp6S05pSlBDMlF1VDhyQ2tsZVFPUE9CUnRvSVVpK2tpK2VZN1N6T0dr?=
 =?utf-8?B?YnhnZnoyYjl6NWZlK2lRZ25NSXpERWlRbkUzTDBqMlA0dXFmWS9DNW5GaEpy?=
 =?utf-8?B?c3lMZzFPRFJVN1RxK3gvcUNTc2dIdklWTEdXaGJ6VHdRUUd0YVBjTnhwMHRY?=
 =?utf-8?B?OE1yYzVaUGYvdEM3VGZUcU91YllRdDJuWXRybGw1OEhxZWlGenRiRGgxclJU?=
 =?utf-8?B?Y0VhMWN4aWwyVy9SRFV6aCt2ZitwU0tDRTQ4WnVIN0JnUjdGdXdzOFhOeVNQ?=
 =?utf-8?B?UENZc1NmKzBsdEg1eGE0b3Q3NE5OTmhMY2U1dDlMcWkycmsybG90LzZzMHYy?=
 =?utf-8?B?VStPbGsxNTVlb2djMXUxK2xScVE1WnExa2FsRmp4eVliOGhRRW1KanFYMG52?=
 =?utf-8?B?Q0tZbUx1d1hiUU5aWTM0Z0Y5d0xKMUh5M29VdlBJNFZDc1RMb0Y1YjB4czlW?=
 =?utf-8?B?V1h4NXhMWHk3OTFBNHp0dTVXM0IvVEw4Skc4d2hxOEp4THlxRTFFZlZoZitX?=
 =?utf-8?B?VnpTS3hyQmRPZHFoZHhOVnpwMVpFejlWQTV5WTR2aXN3cHh3akplS053Nk5q?=
 =?utf-8?Q?RUUl0akW4MzCeqWuvWCwYIj5yX+/VAQkJqx9CH6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDJOaHJvUHRsVGZxZlNubEpjSnR6ZDFkRlJTYmtoaUNjOWowVHZ1eGowWFRJ?=
 =?utf-8?B?WUk0Uk9qOTR3QlhOc0Ztck1KTmVTdm5tbHQ0ZkJLWXZKK3l3TVRLV3RleDNY?=
 =?utf-8?B?WWRic3JoTUJUS3dlNUs1aVlpZTdlTmlRU1hjUUZwQzBCbDBSV21vdXExQkVn?=
 =?utf-8?B?djh0aE9ZQ2JIRFFPK3BoMlVFaEFlNWdaM1NxdmtYT3hrU01GSmYydjNWYmZw?=
 =?utf-8?B?WUVUcy9sT21FcGZTNHh4SFFrdnZHVFdSQXJCZHhmV1g0VE0zd0tEQmRWVVNs?=
 =?utf-8?B?UXhtci84MzgvRzFBbGJTbUc4eDZoelNKdUVrZEN4SUVwb3RobE9pQlhNMmpP?=
 =?utf-8?B?NGVuL0RNUXR5MFlvcjVmWnBmNnN2ZThpTURSYS8xdHVrUmJVSHVxWE9jMmlp?=
 =?utf-8?B?K0FFNnRuU3pqZGNUNkVCSUtwd1JHM1NpU05sRENxdzNHRy92MmNIRndtamVX?=
 =?utf-8?B?Sk80cXp5V1o4Vkg2LytpWGp0OGNjL2Z1NjdETDMzN1R3U1ZpZERtakZ3NWRi?=
 =?utf-8?B?Y0JRcDU0bXpkN2tUNFZER20xeGVJNmJYOGU0UHJOSVBHckRodnNrMnVhWlA2?=
 =?utf-8?B?aXJTUnRMbDJId0VKNWo2c2NxdUtLSHZxNUNhQUZJekhBMTM3NXR1bVhJMStM?=
 =?utf-8?B?djVzSTZ5WGk4V0hmSkQ5ZWxpb0lyUmxTTGZVc3UzYWZQTEtmUFVWUUpFQmMr?=
 =?utf-8?B?dVF2SE93bzJPdXBhUnRNTUZ6MlhJenFaTG45bUFJRitWVjZlTXdySzhLNXBv?=
 =?utf-8?B?dTZjV3BSdDlJbGh1cXA0MkVyWVk0eUNNNmUyQjMrV0ZmSWZvUytKdWF0TUZV?=
 =?utf-8?B?ZGlDWTlvVWkvcXlWc0dNSitraGowZkRVTE5WZlBKOWpGazUxLytVcVlSSzBW?=
 =?utf-8?B?d2E0b2RZTU02ZWQvU1VDZzFRNFRsYTZhYlJKMlMxSnNid2lkbDhPV2hqRUEr?=
 =?utf-8?B?Qy9Va0dKUElOTGhSc2lkcWtBam1UT3lJRlpBRVUwSm5oUTcxNG8rY0pTb29v?=
 =?utf-8?B?QzloVEJjS3IwcUtGS3RKdmtLTS9mbVdTRk03MVc0V292eTdWbE9HM00zZVdM?=
 =?utf-8?B?NHlnTjN1UlNKYm9VR2pHQUJ4SDNLU0tqVVhRT0UrVjUyWVN2eCs4QXV2WXBH?=
 =?utf-8?B?N2oyNS8zVU9rbm1PVmlDNnRxUkdXMWdZdE5MNWJDenRoVHV6bEw4S0NESTlv?=
 =?utf-8?B?bXY2VDRmK09nWFJGK2VDMUFIYThoVUZGbHhVRnhZUVJod096cTd1Wi9oUnNM?=
 =?utf-8?B?NXAvSXZ0ZklpdHFJSU1CUzRuV01IbHN0OUdQSnVVYzNrQ3dIZ0tCRUNaUlNz?=
 =?utf-8?B?alB4bEpJU2ZuZ0Q5a1Nna3VCME5sV3E5QXN0bU55WHpjSWdDanQ2OUpucUw3?=
 =?utf-8?B?U3lKRE1TNUlTVy9WRGs4VlpTT2tyaGdYOVpRTjNIMEgyeWVReDRRR1Zlb2VY?=
 =?utf-8?B?bmtiMGlPL3J1MFk4MWZYOHlrSWZkWkNRNy9HRHB0bkJZb3FTMEdsQnd3eHFD?=
 =?utf-8?B?WGJSSUxUS2QzdTNoNDNPVHhvYUtJRWQyTkFoaWdMc25pRElVRmRTMUJGSXM3?=
 =?utf-8?B?eGlIOTViaUpDZ0RTdys5Q2tBSjlQQm8yM21qQVhKRGV2K1dNOGFrS0xwbElq?=
 =?utf-8?B?SUVpMFBWTFRvWklwRjAxeHZ3Z21KSTYxcEptdVpIcTN1YldhYUJZQlF2R1A0?=
 =?utf-8?B?WWFOVHByNjZnQ1FWVjVhRGRNRDU2eDB6WjdSUG5uUHJ3ZXVaTjIydjNIS0Nt?=
 =?utf-8?B?cGVKbG11Y3Q4aWQ3bHZHQVZRVXY4VlYvRHBIckh5dTZVZDN2WFpQaUdIRkNs?=
 =?utf-8?B?em9PMjFETENHVzByMWErS3YwTmVQeTA3eHVydEdsQWxwY2JzKzdyWkxxRS96?=
 =?utf-8?B?Y0F3SEU0RnBKd0ZKMlphRjNHNG53Q1hub1FONXhTa0psdmFCeWpnMmxqNnI1?=
 =?utf-8?B?OHR2QzhNaDVoOHJZUTZ4S0xVQWxoYXJMZmExaWs0cnpyS3diY1d1NjgxNjFy?=
 =?utf-8?B?OXpoTll1Z2ZCQzlnMi9IZGJQbFNXZWdvUUNWWGtnWlN5SWhHV0VOL1BOc0Vp?=
 =?utf-8?B?aHBpSGhyNlN5NUJKQVA3MnRmVXZIRjN3QlN2U1QxSld5empIQjZTeCttSHpI?=
 =?utf-8?B?N0pHTDZSQTMyakZkTWYrOCtVSExGU3dhQlBiMnpRRzRlOERYa3hUdVhxRDhp?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6fa446-446a-4a95-a3b6-08dcf223ba15
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 22:57:24.3424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNruHm+1lZXfhxu4mmefrd2hjsNxRyZoIRjhoYdN63nOH81SK08VYD9QM2oRDl1lGPrd5TJYxnpKFuM30cmSJMKzi/B7aoYy8kRpIKF9p4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6844
X-OriginatorOrg: intel.com



On 9/24/2024 4:21 AM, Wander Lairson Costa wrote:
> On Mon, Sep 23, 2024 at 3:44 PM Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
>>
>>
>>
>> On 9/23/2024 9:46 AM, Wander Lairson Costa wrote:
>>> On Mon, Sep 23, 2024 at 6:04 AM Przemek Kitszel
>>> <przemyslaw.kitszel@intel.com> wrote:
>>>>
>>>> On 9/21/24 14:52, Paul Menzel wrote:
>>>>> Dear Wander,
>>>>>
>>>>>
>>>>> Thank you for your patch.
>>>>>
>>>>> Am 20.09.24 um 20:59 schrieb Wander Lairson Costa:
>>>>>> tx_queue_lock and stats_lock are declared and initialized, but never
>>>>>> used. Remove them.
>>>>>>
>>>>>> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>>>>>
>>>>> It’d be great if you added a Fixes: tag.
>>>>
>>>> Alternatively you could split this series into two, and send this patch
>>>> to iwl-next tree, without the fixes tag. For me this patch is just
>>>> a cleanup, not a fix.
>>>>
>>>>>
>>>>
>>>
>>> Should I send a new version of the patches separately?
>>
>> The patches apply to the respective trees when split out so I can take
>> these without a re-send. Patch 1 will need a Fixes: for it though...
>>
>> I'm seeing it as: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet
>> driver")?
>>
> 
> Can you add the tag when you apply the patch or should I add it?
> 

I will add the fixes tag when I said it.

Thanks,
Jake

