Return-Path: <netdev+bounces-108422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3572D923C2D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A90B22E25
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B8515B0EE;
	Tue,  2 Jul 2024 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DRK3E9RZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4E6FC3;
	Tue,  2 Jul 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918857; cv=fail; b=GA34Avm91s4QVFVF9rFB1vgGZEuZqXgjttl3PWy1suBmVBNCujdNjrnyRIe/Cp5EE+zbDfz8KqZSySRoMX86He/5pa4G1UVwsGbMRQT8RZwAxdcXXKUMuhYz30sqN4tk7NaI/f0+Os3v+7yXHDc92NBHN/XpVtha6pFUqBUQCGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918857; c=relaxed/simple;
	bh=De0ybiDo+ddbGMnWVj3jG/kMZ2hwAtctYoGChpstHJc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZxAHk8XHt+FE+gOWaFemrOXygrMS6Co5DPStmVKesNTlKBSmz2DC0y691NPQPnPx9FJZdB/XTuMie3KE00poxEWI+dmWZ2Qgl4SVp25O6glFp513kxLh7twdPaoCrmqxrlERvdVoAQRpgT1XhJ+z+rlGWt3BjvYQlQMYLmabOO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DRK3E9RZ; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719918855; x=1751454855;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=De0ybiDo+ddbGMnWVj3jG/kMZ2hwAtctYoGChpstHJc=;
  b=DRK3E9RZEFw4lQlNASjN5AHQFO5pR3koCZfvK2NrDHchA5lne0JMFOo/
   TwAf+EMClhFrpkiYN8616XjjSpDNgFmZqxTkzPIoZi18QbYGTtjWw5OuE
   R6EkxRZzAlTZIwCSfJPiEgPNW4TGTgFlfX20Jqnhugk9FsGJZJoDg/Lgn
   YK5ZKJobPJ8Jr7AIUP9Rp+4xO5W7V0TaXyVxONmv9G4EntB19x4pvDtx/
   pnq3jE1kZMepw7L3v2zZJDaeRRaqCAX6MkdxIqhoOVixgatBX+GQaAdLE
   7fCJeTJRlYPK7Mdhw4gbB0gvibAUvodSghrvPBkogF6+Amz3ywWGUrhln
   Q==;
X-CSE-ConnectionGUID: r7lbLcrZTRSSqemdAwxpPQ==
X-CSE-MsgGUID: Omdeb3F2RTW3dK9TLWyWow==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20899953"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20899953"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 04:14:15 -0700
X-CSE-ConnectionGUID: elpKrCvhQDuJd3jHpsGIzQ==
X-CSE-MsgGUID: Sx+f/Fx0SA2MdizKWkJwpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="46287511"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 04:14:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 04:14:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 04:14:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 04:14:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 04:14:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN0VN/Lt1YE9qO6/DovnPm1bGnRdyiEMoMkUaixGs278HX2deQBZGlR0+wMcKO9bnvmbwPMGdMp0XPat8HoOiV5iceWG6/XpgGgu0MO4YBMs6amxHYfV30d1DcibGT7fUfFzuieeK/qhMwlb1rK0YSlfCNVBkCkqT79Lgb4gd1Y/0p5f7Z2ofKiOKcDauRD+6EByCFKwjmfuo7yZSsN/uOEx/VZIHVoeeU0fLO5P6pnqKu1qbSOrAzCHPwi8B+tjvFSWVHLl5IQ5TJmEp6QqC++jjeRM5c8QHN5VCCt1bV3OJChS1uHwmUMq+oNOxxS3Ksmq6sO+LYy/TlVd2U2e2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMbr6mzK9bxuTR/4Ey/GJoXed6ZgP/ErYAjZT+maTHw=;
 b=GsTPJuUoLg9IGS/rxw+DNcdWspWySMYJTDPoShgwKCyA9piFUmSpJ+7uqALz9Yl9Qydy3mEQlpJRdCWKr9Z/q/lDW3GwIj1mGD2HN0EfurC/rxvDf5anfsbCliYcnWHneWM838QA4VZOl7O9rLfJbiI1aZfY9u+AYj7Ua98ZFLztYCWB+jjuO5I20IFTCAPgxPc+G1UWpRhl6A6zjfeGhnv4Spv6njm/2+HQFfOM9Ff+q0yQeuufsq7aRCUz6b2rvtYsAMJ5scnCafwz8eMrCejxGT2ecfLdGlssLbzQe8YmZBO4SEocSWU2N35Pj2grdDSa/SeYJINWAkxV6ZT5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by IA1PR11MB6490.namprd11.prod.outlook.com (2603:10b6:208:3a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 11:14:08 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Tue, 2 Jul 2024
 11:14:08 +0000
Date: Tue, 2 Jul 2024 13:14:01 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Adrian Moreno <amorenoz@redhat.com>
CC: <netdev@vger.kernel.org>, <aconole@redhat.com>, <echaudro@redhat.com>,
	<horms@kernel.org>, <i.maximets@ovn.org>, <dev@openvswitch.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
	<donald.hunter@gmail.com>, Pravin B Shelar <pshelar@ovn.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v8 05/10] net: openvswitch: add psample action
Message-ID: <ZoPg+fR2GQuK3Sir@localhost.localdomain>
References: <20240702095336.596506-1-amorenoz@redhat.com>
 <20240702095336.596506-6-amorenoz@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240702095336.596506-6-amorenoz@redhat.com>
X-ClientProxiedBy: DUZPR01CA0127.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::13) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|IA1PR11MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 80bd925a-71fc-46a2-2e3e-08dc9a8817e7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nj0ytPFdndepCcpwdtcadZhIs2LacdEk9shiFtP75VhZVmg36bmnTEDc5ND4?=
 =?us-ascii?Q?qTmmK0p7A1FHc1Qjsd3LUrb3OU21JQlQuJ9lLUfW9d6DSc1B26BLO7QeMP8Y?=
 =?us-ascii?Q?GmcVa2gGzwGr51H6GMpzbT8fNDobwopbsFKdchKPK9IGgfq62RlDTMrjdqc8?=
 =?us-ascii?Q?RMZ76o2QRZ5ZOO2zfYCN0XY/M3Hv3YqJAT6be1KpcpmRQoFazlG4DgEWJ7+K?=
 =?us-ascii?Q?R02t0PjBCh2KXICdXwGwcVzo5krhicLYk0AMgTFG2MUHwkif79ZaQMuid8bJ?=
 =?us-ascii?Q?ymYDzQVEfgaGh4SiT9Rmss9QbfBiUe+8Q4b5sp5YOmB1Fa0oCluG2Jd51v8D?=
 =?us-ascii?Q?V3xHNgFPdRp8lYS8+IiczK9aRoPlvBaQjD2WtPddJrlC7Ew6e3VvoXXBC/99?=
 =?us-ascii?Q?sDWqFb2nagCV0N/fgOb8O84nM806cabzcjfp7tkrDowCuUN+mvTg1fBNBaPH?=
 =?us-ascii?Q?IPN1BC4mIjS8Alhf3m0OYSnEjDnbCBQ6U9N1TBqDjGqP3O0qrP+3l9ukP4Pa?=
 =?us-ascii?Q?agXt1a+JQthSAdRRSIBGN9DtLAPjOSzbklCXExF0dfI36B/0Te+Pb6ndo2wZ?=
 =?us-ascii?Q?RmEvXqFPei7F2ijGOE9Jgwr5KLOxjHWWnGrbjzg8kCAm5w0nynlhYQet3ZLZ?=
 =?us-ascii?Q?KLXuYFb1WPf6fNTxChV53l1MtBBzJa2VOFgMvWvXNvXB+181O09MR4K8OhM6?=
 =?us-ascii?Q?lRbHHaIJSvy9ToHc+b4pbicuKBRJS7LbdtdB+7ntR9AWTsQ/lUDqY7IN/h8D?=
 =?us-ascii?Q?pFSkfl/E8HkM8Gmy2S1UKWc+6gDrr3eMSrsoYaHkz5R4NhrM62FkZ2iH8uO4?=
 =?us-ascii?Q?gqgwWhbU+HZdRIj1H5nyNFh33JB/0j27kGLvtLvUn6bg+1SPc5FrwQ2Z+HAM?=
 =?us-ascii?Q?DUfrkDUMbFHDz76CosryqYQDtOpptb+0Pi+LVjE+lYv0C5tASIsqOs4IMx4C?=
 =?us-ascii?Q?pKp1NWZ5ngqO2sgSiQ9x9HjaWGimR/99FUVMZLSh+ElPf3RU0wYoqP38ePA6?=
 =?us-ascii?Q?raYBauOWDfesXPQ5XGul/l9pxG+7YbkgXSGCITfHMQPn9R1Vo/accfGn9754?=
 =?us-ascii?Q?PzepeJwy57Vf/qNwhVGQWMJTVx70zI8OtUvx6CAXwm4z9WZMmlWIN7V6fEty?=
 =?us-ascii?Q?XYCfcAovbYQxNES4lpyhUHLrAxzOEd2EAjaAvGY/S/heTeshYwR7DMoebpLP?=
 =?us-ascii?Q?y9MrquhsWbVHJLtj+56thahoKZfS6c6tweDfaVMJk314dCPwnj5pxTvQp+xG?=
 =?us-ascii?Q?N+N+ENjJtVZdTIav/22e6L8T6ZeX8v4Nu60xTZIz0nFOlPJkSBVADzOpccHS?=
 =?us-ascii?Q?HJEyK0tRlc6LCEuAgONGHt3B9U1Ia6w7mAx24/RuuycPIA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2XFTKbkMA091J481nuKIGm1+dMgvLl5vXRh44MzOGEG+A39gZ2KWND/YZ2R9?=
 =?us-ascii?Q?6i7A1skcprsubYGMN2dz5CVjjha6o6Ju/TvRLM3q4lQsvcjZ3AO1HC+Z5jXz?=
 =?us-ascii?Q?zU9iecjz6I0Lxidm7fu70bUvBnpZhuq/7+odCDkBEC8WfPA3SamAUSzmk3s0?=
 =?us-ascii?Q?iyZsppRZzElaak+pLctDF2Hr455tt57/JBRfmiKD4vksCelS/4y1jRnFSzGP?=
 =?us-ascii?Q?8EeDsywpB5DIE+8MjwDosg9tev2v5QOBypqBoBJHo5EBWxF8aK8FmYfkBC1f?=
 =?us-ascii?Q?ZRcuZteveCMtNWzH6sdx9wWaedCh0XP3FywIgRMFXOLAgCIi++tnuE9h3twc?=
 =?us-ascii?Q?ZY1111SqoDwhuiDfvr37AL0hSf+7/qmz3j1Z9E1oL0kyabN7zO8raRSt4lSj?=
 =?us-ascii?Q?c3Eu9XE6tuYsmtPXtOfr+J8usLazsMmPfsmhYoJ/MpRDHYC2YeZ64U+6cci9?=
 =?us-ascii?Q?FvaSCyjfkStEDHoFMSs3zI3wqmvBF63kGagwzU61x9Js5j1l3Q2gTzCkhFIS?=
 =?us-ascii?Q?R5y0d9FgYALaRK0qQvTBqCN/WN+AtJQWf4A3uka0PiuWs8UwPW0Ht3AwkNLn?=
 =?us-ascii?Q?iF3BVxETx9IRssJe1i33QJn8oOkW/vvwAZ+KUu89OHKBFTsaoNC9LAlaHAPD?=
 =?us-ascii?Q?zQOAMdStXtcpFr20tLXy7Mk68LoUhyR4S3gROF0xcLDvCJg+OP9PlpSyg2tb?=
 =?us-ascii?Q?+SUasZ9rzajSdyPCU9UzntBrVLktnjMk9SFtltPDZHxIp0YCV9AsroIhRFnr?=
 =?us-ascii?Q?mL4Mb8L179DQB4QRVUGwRggFH0lIN5AfwPsAO3wVo70Cigntx5cYoSn8PQ9J?=
 =?us-ascii?Q?AbwcWaxHSWJcUNo926/rJfimy4Bsj4dzRtAGY4wP9qE4snRqoR/9DElXV5zr?=
 =?us-ascii?Q?QRiNAgGk93zDNbK5FNbUAQ5c+BUBPcWD80dn++FxEMdRZkQFYnh4kHBvM+Pn?=
 =?us-ascii?Q?kxeIKSepDTsPnTYgfRx8LdN4/2h+Si4E8gBiznfVynziOiFKfdTDJhOs+i04?=
 =?us-ascii?Q?XFw9dL41WeN9TPJAFS01A2wmRt5uelvCL7ofhPqECybbnIOmDwJXHLfSZoWF?=
 =?us-ascii?Q?YRbhvTgYy+qZEFJ/DGvdTgLkfsrNvQ5jQMusBBKLU5xPuuyWi7nuW/ZJLJnB?=
 =?us-ascii?Q?T0duYyMvWdNTFP3Mfi9N89JIVIxMczSZeKIdkC+IfHKrT7IvhRVV0QKSHFgO?=
 =?us-ascii?Q?9qbI7Bzpn4dVcyh6fPVVx27hcGnjVABH6TERNnl/LIJbRO4uggC1KTbq17yy?=
 =?us-ascii?Q?oRVgEC7ITxLxTlk7XtyvQ1e7A8LF4/Glj5YH0WSBfqAr8Tu2voN7t94rftun?=
 =?us-ascii?Q?MdWspHovzIJl1KZkXPITqrReDNP8YZoBDysLcj3e6AMPlKo7fFXsdLRpSVpl?=
 =?us-ascii?Q?ZEO9Rd5eum/7gRvy67LO791CM62o8ClSQMpHx8uNOvo9IUPzHfOs6+VW2w0J?=
 =?us-ascii?Q?zt0cl3Fn/unZIdU6YT++uz5TPQFCu9voYQDra3x7V6BvUCntWue/cRGFDm+F?=
 =?us-ascii?Q?0DFWggoTVBmGo/bqFgRuoCqCaoInvsBpbH/1kVPzVNAkOhtNysjVju2Dm2Wi?=
 =?us-ascii?Q?CLVSjJcNZUIz4WLb9ll1BrhMxF45a5gVkyNIIDNazJvJd9DBy4FqOFGWtNn2?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bd925a-71fc-46a2-2e3e-08dc9a8817e7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 11:14:08.8211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMMtQvPxxaSuQ4aj/zvV/1WQ7O353+jYIip9loIjVnrR4MAolOsrt328bv8s37Ww59w2x0UNSoP7sIsf3PZUUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6490
X-OriginatorOrg: intel.com

On Tue, Jul 02, 2024 at 11:53:22AM +0200, Adrian Moreno wrote:
> Add support for a new action: psample.
> 
> This action accepts a u32 group id and a variable-length cookie and uses
> the psample multicast group to make the packet available for
> observability.
> 
> The maximum length of the user-defined cookie is set to 16, same as
> tc_cookie, to discourage using cookies that will not be offloadable.
> 
> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

