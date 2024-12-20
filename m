Return-Path: <netdev+bounces-153717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C139F9517
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 16:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D361882D62
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D78021883F;
	Fri, 20 Dec 2024 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmnPt98u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB1A31
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707474; cv=fail; b=WsfKyQ+4WGJ3KFkKTg2o/+sJHWaAgmwkvlWQ70I3GsFF0oYZws1Sz+pF++DhtYUKoMDJrJtc6OHNOFz6VPpogoCC5UVGSUPzauGhLrMrcX3DHlrvlFnEOLxHaYh+Dg88I6/X0SmCCBA7/zYAh+AiGg4yTcYQ84xkgsFixIA4K3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707474; c=relaxed/simple;
	bh=kcvZzy9kheum+f+eIt/rrpAAQCXHYT0tCqfP/Gi2BHM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s2KHJUIlhavLqH+3Scu2JuI+iNGZZzNTzrfl36wlT6wt2ifrAShPEXCKXVNo39nBRUoF7lcpLyM19BSDAbFTzsFwyZ74S2fUYQ/7SoDEeFSM/R0bhkHJV59cF/KVLFrYCzZDrcss+OiPIbiY1tXQtyRG/2cZXII/85bRHDpYbKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SmnPt98u; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734707473; x=1766243473;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kcvZzy9kheum+f+eIt/rrpAAQCXHYT0tCqfP/Gi2BHM=;
  b=SmnPt98uZcP+Xd4EjpWdzSpwBQjuE60EAuFsveT0tnA3PYq0+j+ppTyA
   6aEW+9QZ9/mjhM3Em8SmI76LEmG6/w6/wwtyG9ERBwG/pkdeQEtZ6lsOh
   vAv7+veok33Dqe2tsvT8FXo1wY4etMpfnWd9Y3QM0XTY1efLLnVd0JzjP
   fym/dCCY2MdqWhvFQKI9+OBrt8VU+KfBCN6XC4b2FTminaWcMnp2hbIx2
   ANsDFgpj1PfRevRxgEXpS+UlP5F0KyeSCnihsgLjQnQF3bQs1orSM3MMp
   oMHWj0ThdWCmVfydMLIEjMixpxXJUMLdKTn1eBmtHg6TNsmOP4jCabSgq
   A==;
X-CSE-ConnectionGUID: AeqV52LjRtyBB17zl3GV1w==
X-CSE-MsgGUID: q89eCHMERTSGWPNab22sxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="34540394"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="34540394"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 07:11:12 -0800
X-CSE-ConnectionGUID: K+dIToppRuWG3OsConOaHg==
X-CSE-MsgGUID: fByga2hRQHqCn63OhXlsEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="98596149"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 07:11:13 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 07:11:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 07:11:12 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 07:11:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEpEM770ETG8yncxMtpAIsufIBzkF3QChUcaqQMMM3SwLuXjiqP7VR3skHKq9KzjR3wFKOBW3gBjwGsXtqKcvXBXDzkrWN9vL1Ehce3ZU6sR6p8oblHyk/v/MosVCFdrGf4ady6uhD4C6Yv/BChhX8tfNZI/68ET6DEElm36cYgPw4B29z7ChoaiNenaES9S7sx5r7KnmJviOYRpmuaxjuGC4s2m0hcYGteTIS5ea80zlCv+MSEJE/BeiTPa1Iv0yHKwc6k2JiuKliba3uD+kOWlRMmljvvlLdCRryjMrL8RXsoj/g1AAaTOZC3E0DNh0Gzza9963ggxUXKnAz+66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvYWuZmkN0oamNeAgqo89Sm6c78ko5h5/ryndMtXEnE=;
 b=NbMtXUlfx0TOEb6z2X0CJaxa+HgdumeogcoGT5JGWpLlCAg/ZyRZ6akJwVe2Lv1d7CEvn3cPstcrHEDgfPKMty/koKGOqV1Fu3Fp6pX/dymJgD0czHAyq01EAdUsdHFtpzeFVphDoCqDxqA2F3WZElT2jspsB0vqvebFv695ecjDOx+kFefVD9jRmX/irB3C/4dH1FEb98UNiTIzb8FLXHfS0gFPrTCFNi9ukV59tk9mVzKO+Noztstw4DsYkz7gfL2QelEGmXB03rucOjsFYv4jv2ohEsnluJCg6x/x3NeT9tb8gZUMv4VRepd1lWb96VJPcoaKeWsobXG9aHfJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW4PR11MB8292.namprd11.prod.outlook.com (2603:10b6:303:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 15:11:00 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 15:11:00 +0000
Message-ID: <65ef1684-b2d5-40f6-b20a-71ccb9ee302d@intel.com>
Date: Fri, 20 Dec 2024 16:10:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] net/mlx5e: Keep netdev when leave switchdev for
 devlink set legacy only
To: Jakub Kicinski <kuba@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, ITP Upstream
	<nxne.cnse.osdt.itp.upstreaming@intel.com>
References: <20241220081505.1286093-1-tariqt@nvidia.com>
 <20241220081505.1286093-5-tariqt@nvidia.com>
 <ec95c546-114d-402f-b7b9-b3e54b33dbf0@intel.com>
 <20241220064634.10b127f9@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241220064634.10b127f9@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW4PR11MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: f11d9cdd-7283-4655-8496-08dd2108836d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3lZSTd4Z2ExUVBOYXBPZ3p3amVHK0Z0Q0hjZ2pmbmdBdkkwam1MSk9qKy9F?=
 =?utf-8?B?QlFmM21rc25Wd1c4dTRObkZKVlB2TitscjB4eHM1OGJVNjBhWmpvd2QrNGxi?=
 =?utf-8?B?TEZZVEN1dDY5M1lrVStpdFV4N0xGdlVCcFpDNFB6VlhZRGI2U1lJd0doVDdo?=
 =?utf-8?B?WG5BLzdFdUpqSkgvSEpqZ01rQllTZ3VIUXZkUDFKRHJaL091MklzU1ZiSHNK?=
 =?utf-8?B?MDFTUUdXTmhROFQvWEd2N1h0M3hqRlpoTTJYRW81eXZHYlNISmhmMm5ERUJi?=
 =?utf-8?B?eFVtMVJGNDZ2UXBlTU92ZGs5MlRtZTRBUkw1VE1zRVdad2ovVnFlK2JmY2Y4?=
 =?utf-8?B?L09NNzQxQ3gyWVJRNGlBY3Nqc3MyNkN0cUcrY2ZLVzJIWGJiVk80SEhqeWVl?=
 =?utf-8?B?QUN6RkxjcTRSM2gya0FJenkrTzVPTVhFVGh3MlRWcnNvaGFRcUVMNjR4aGg0?=
 =?utf-8?B?V3FQbWN3aGNielpEK2lwb091OTE0emoyTXJlSGZONmhYR0Z1YXVjQzBicjNh?=
 =?utf-8?B?SHo5OXh4MllBUE9YWWphdUZKSVRuRURaUW9STEFFeWk1UlI3L2N1c3dHbGdL?=
 =?utf-8?B?a3RuSXJCQWNJakZnSWdqWG9hdXU3bEI2RnNHckdrbllab09VZXNxWVZQMkdn?=
 =?utf-8?B?VVBCaEFQb29mM1ExdXFWRUd6eEpoaDlDWUd5Qm5FMTFYcUZlcitUR3l6TVpJ?=
 =?utf-8?B?K2lKNDJsQWtOL1BQaGtUQ1RlVndlamF1NTFmZ2NPbTNHVUd3eXJKVFdqMklp?=
 =?utf-8?B?anhRd1AwaXBwNjdvZ1h1ZWQ5ZHg1MXZjL2hTQkxoR1VEWEhyYS91ZnpveW9u?=
 =?utf-8?B?NEQ4cTlxTjkzZUh4dzIzSHZMVzd5aWVlQUF5a1czYmxRTEs1eVdWNWtpU2VT?=
 =?utf-8?B?Qkl3UWlmRmRuTDdGRWR0Q016bklKSGlaYUM2V2lTaHJWeWFMUUNsSkl4ZUlF?=
 =?utf-8?B?RDBETHZJVHJyTTJoZSs5WVRMdGJPd2xsZWdsSEZXK0ZtaHpLbm0rSmpDdlZy?=
 =?utf-8?B?Q0FkRjN0L284bjNmWjdoZDZwQzNWSUFSZTZ0cEZhaWJibk8xMm40RkRxd1ps?=
 =?utf-8?B?Qm1vSUhiTkxJakJRZThRWkU2L1VVSFc2QnRHSjBrUFg1Yll5QTZSaURVNjlZ?=
 =?utf-8?B?TnBSZGJVYXlQVHNza0hkOG41SDRUbnJvclNrL3cwMGtoOXpnRlBUUUZENEQw?=
 =?utf-8?B?cUVCVk5OeFNmaUdsWklDQlFwYytsY1BEQUpNeTlUdlpTUjZ2ZVdMV1l4WTFJ?=
 =?utf-8?B?S0VVdFFjU0g0eUhORDhlcmtNRjBZcGFzM0t1cUUwNThldVI0ZEM1Rlh2U0ND?=
 =?utf-8?B?WFlxeGxlb0ttVHU5VzhLUnUzc2s2Y2c5dnVaeHpyNXNKZXJPTVY0ZTFhUTJF?=
 =?utf-8?B?bGovYllWL05rUldkS0tKcitaTjB1ZCtXblB6ZzZZTTdXUW1IZ2o5ZjVFUWtY?=
 =?utf-8?B?WlI5TDUveUY5OUZOK1JpSVhwVXN3Z1JFMS9NS1RZR1ZWR3huQktxeFA4cXFj?=
 =?utf-8?B?Z3QxeHgwbWZwelUrUTNuOFB4K3NOaWNmYXNDbWtUcmdCMmQ5bXpaWE9RbjNP?=
 =?utf-8?B?Skh0ZXdSWE9RV1J2YnJ0UXo0NlA0c1JqQmtQMEtpMXpTL3FrWHVzY3U1YjBH?=
 =?utf-8?B?ZlM0aDFKYzl4UWVBYW82SVJISllpRnBXTnI3VktRdWFjdDJJcG5lYnZoWGJ2?=
 =?utf-8?B?dmVxMXNCR3MvaklzSnlsRjlzVnZEN3hTNmg5MmEvUmlobW0zWUZOZzJ0N1NB?=
 =?utf-8?B?T09paFY4RzNNT2hPRjFyUjFHRDFKWlBrVjFaMkVkQzNpbUVBTHRDY2pmdCtk?=
 =?utf-8?B?bmczclJVYk4ySTZXRkZlWFRGZkE1ZEw2R29LNXNCdmQ5THRmWlZ1YTVIeE1k?=
 =?utf-8?Q?LtPIurdqFtnO7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzhlZDg0TGd6c29xRWQycW83aFd1K1J3dk5NOXRzby9jYTM5TmpEZnl3Wmht?=
 =?utf-8?B?NnNOTHVHY0l0M0dZcEF3MWVtNVJVSGFKeW15dkM0SzY4cHlMemE5WGk3NVAx?=
 =?utf-8?B?bXAxRXVDZEltL3VpcmUvM2xhOUk5eExwbFVmQzBzNFNsT1FUYURXT3Z3Q1N1?=
 =?utf-8?B?THd3MWtESDJwdnNmRW1QYUVTemF3TWJpayt2eFcwQTF6UWVxWXlYRk93Q3RE?=
 =?utf-8?B?dTF4QXkyWVkwYi9lYW5BSVQ1R3NNNWVkS3N4L0pwQ2luQ1lKZXZyWDFVaWJa?=
 =?utf-8?B?RmNkTzhsZDF4VGMveDBqbStsdml4aWtnNktNK0xJanBYM1RWekY2R09UN2k2?=
 =?utf-8?B?SVZ2WTNZZTA3Z08rcU96Y0xod0gwUVZaSjRrN25tR1lBNGdROE1hejk5eStr?=
 =?utf-8?B?Y21aMTMwdUtubEFsTzgvZXhWVTNjZDZEbFdVTDIrK0tQMU9pSWs2THF6dHRx?=
 =?utf-8?B?bEVGREk5YkhocWM0MU9BT1RtazdWTmNKUDdIdnNaeGsycXBxeVc2NzVuVlVL?=
 =?utf-8?B?V29WQjlUak9WSTRHck92ZGRkRE5ZZ00yRThqRXBnOG50WmdDN2dkRXk0dlNI?=
 =?utf-8?B?dlg0NnJlZ0RJbFVIMGRQMHRDK0doQkxCeFMvaVhqVGpUYWRpZzliSFY3YVBJ?=
 =?utf-8?B?Q0F4REVZTTFjcHB1MUNXa2xIUXBLL1JxcDlNTDZ5Snd5ZEhLd0RYYU5jQmx2?=
 =?utf-8?B?SnNvWXNiQzhFRTlRSnFGT1luWjhSREYyTDVjMEVxVGdZM2hLT2hQT3hlWTha?=
 =?utf-8?B?NkkzSkFtZHhzWGdteTYzeFNrUitxekNzT3ZtbnJtY3pHQmNBa2g5R3FTdzBv?=
 =?utf-8?B?R2lmWkJLVFJOQVRuV0hJZ2lOU2RHb1NLSjRXVDZaaWpiSTBYZVpBTmQ2YXNM?=
 =?utf-8?B?M3U3Yyt6Y2tXcFpNSVFJdDVGVXBFNWRUUzY1THFGRVJLekExM1ZSUy9IY2tO?=
 =?utf-8?B?STIrRVM5dWkweC9uUHFPTzFhR1BqRHFrcmpSWVFBQWhjeTRwcW02bVJBQXBC?=
 =?utf-8?B?cndFSVVnR1ZoSEd5VVNsUjU0WDhTbTBobjFjZ0NVNEJQR0pGU0RiWlVqOFB5?=
 =?utf-8?B?L05xZjNFWUFCanh0MWFlSS85ampxc2VSdkI1cEk1WVByODhYOFo3VkZBMzVq?=
 =?utf-8?B?eXRZU1daNDV1Y1NwOEVKbUZnck5JMjRSclV2NlZqeHM3L0NGdWV0VXkzb3E4?=
 =?utf-8?B?M3lkN0tGYWdUV0tQc1RxVUdCTWtsL29ta1RKMzlJSW5HMkJURzFnQ2JXWk9o?=
 =?utf-8?B?SS81SlRMOTJjcnA4Skk1RThTRyszcEZSRlZpbDA1TWJCSk11a2lEbE12WWVW?=
 =?utf-8?B?SFk1TmtzY1MxRW8zOWdndHN4aFFhK0pvOGpkZHdNd2RFVTBicUZyRUdlYjNn?=
 =?utf-8?B?SjZZTzh1TDRkM0ZUZUVwcmdGRmo1R1hncWRSNXlPSHFFNUszUVN5azJHYVly?=
 =?utf-8?B?TUxEYWxGNG9ldkpkOEFSSUprZjJLRkt6QlRvYndrdjY2OHVwOVlPSmRvOUxB?=
 =?utf-8?B?UXA1eUo4d0hHT096d1drL0h4MHJFeVZIQkhvS0I5VXZITGU2S1RmckxmaEk4?=
 =?utf-8?B?K1NKRE9tWVgyUnVBaEVaZVdQMXE5anVCRDJ2MlZtS2VGdXM2dGVoYkxleGJw?=
 =?utf-8?B?Q1BZaUpiRUFYSElnSHBqVWoxSVNuNVA0NzJib0tLU3JyeTNNUEN2Z2JrNllR?=
 =?utf-8?B?bm9vU2toOEhUUm00Tm1Nc3JKYkxFcEs1enBSZUVycHBYRUJwTTM1SHZuSXNa?=
 =?utf-8?B?cEhIdU9YaU1Ockx1b2drRjlBY1h5SzBNbWRWY0Mvb05haEJvYUIzVm05R1pz?=
 =?utf-8?B?TW44eUFBcTZUNVZhVGpESWMxbjNOaVBnZlV4bC9iU2NxZzNFT0FtRWI4akZP?=
 =?utf-8?B?c1BqekdMQk9Ka21ucU1tL29janYrdVB1UzBjVE5aY2VqbWVnZ0UxMnFvQ1ZZ?=
 =?utf-8?B?ckkwNFZuQXRTYTdxdTdML2RMSWthYm40Mlg1aXlBaW1BakZ1UENFbTV5OHBy?=
 =?utf-8?B?cWp1SUNtemV5REwraHRLNzVnYXZDdjF6a2JOZjhOSVBuV0NwbFFFODNXZ0VY?=
 =?utf-8?B?QjZMT0phK0lkTVp1ME92UkxraVZQMUE5L3p4Skp5Z2NSeVRrbVZqc3dwOUNW?=
 =?utf-8?B?RjJHOGQ0OXgxWjEyVnV3Tld5QkVlWklwaVBpcGl3eURZazRaNDVhbnBGcWRU?=
 =?utf-8?Q?GbOkwxicyAr2+mG32uVtQgI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f11d9cdd-7283-4655-8496-08dd2108836d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:11:00.6035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jArSmskqru7wXieSXahzvlxi9OmNq4/0AU+PxGwxs3bnWXnZrV/rF08dD4LLxiyutFYbOx8t/cj0f8IXtSANpMTi4XbG9jBIcaTqshFyII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8292
X-OriginatorOrg: intel.com

On 12/20/24 15:46, Jakub Kicinski wrote:
> On Fri, 20 Dec 2024 09:48:11 +0100 Przemek Kitszel wrote:
>>>    	mlx5_core_uplink_netdev_set(mdev, NULL);
>>>    	mlx5e_dcbnl_delete_app(priv);
>>> -	unregister_netdev(priv->netdev);
>>> -	_mlx5e_suspend(adev, false);
>>> +	/* When unload driver, the netdev is in registered state
>>
>> /*
>>    * Netdev dropped the special comment allowance rule,
>>    * now you have to put one line almost blank at the front.
>>    */
> 
> Incorrect, we still prefer the old comment style, we just give a pass
> now to people who have a strong preference the opposite way.

good to know, I will pass it down to my folks

> 
>>> +	 * if it's from legacy mode. If from switchdev mode, it
>>> +	 * is already unregistered before changing to NIC profile.
>>> +	 */
>>> +	if (priv->netdev->reg_state == NETREG_REGISTERED) {
>>> +		unregister_netdev(priv->netdev);
>>> +		_mlx5e_suspend(adev, false);
>>> +	} else {
>>> +		struct mlx5_core_dev *pos;
>>> +		int i;
>>> +
>>> +		if (test_bit(MLX5E_STATE_DESTROYING, &priv->state))
>>
>> you have more than one statement/expression inside the if,
>> so you must wrap with braces
> 
> I'm not aware of that as a hard rule either.

[1] says
"Also, use braces when a loop contains more than a single simple statement:"

And I see that here we have and if() instead of a loop, but I believe
that the intent of "the rule" (not sure how hard) was to pet the brace
in such cases.
To be clear, I don't want to stop an otherwise good PR just for this!

[1] 
https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces


