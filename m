Return-Path: <netdev+bounces-229767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1F7BE09E9
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C958F19A683F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C561F12F4;
	Wed, 15 Oct 2025 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KziP6zz8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64C61DD0D4
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559654; cv=fail; b=ADlLBam9tfZyvkdHBDyvWL24vG247XfiMS9PfxWulIa1Iyo+GmitPSYpeURbta6fOiap++zEg8mINXcNVGJ+UYn5e/R2Vd3Mlnoy9pKVesJhB4aQ3pCCTvy7+N8COhM/C++/fW1bAqZ1DeE5pJFzqi3JzW+Vzv/DoxyKDkzW0YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559654; c=relaxed/simple;
	bh=ZW11gw6cqNK24/4x2RhiAhhhhp4xnMqe/zHKTkI46Mk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rz1leqXRHF2ArjE8ojWNwSIKai57Sk95Z5NS7ckJJbj7ZRDEJLpIvSIYaAJKs3tzDk2Ro2AvD5g3SC3W0OXf/Jq+gB/oTpucDWzJyqUUEhZzLg1mOk6VSsbZmg60GyNkbYRtZl/ynV2c5MmB6AZrJ9YVYI6vP+zDNdQNJnY3fqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KziP6zz8; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760559653; x=1792095653;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=ZW11gw6cqNK24/4x2RhiAhhhhp4xnMqe/zHKTkI46Mk=;
  b=KziP6zz8i4RidQGLVbwwaBR745p3zzGidV+Bj+S7/QJzNjtSFhsWlNge
   SdcRcrAFF4ALlRFe4j1KtHTaekV15nIKZyiXxq9CVgpl5iXTepa1J+COP
   +4bOsOvYvN9wurwrEMXNFbTdH/oID+ku36YQsAgE4LrvegK+jt0YijPGO
   icvWszFkFtir1CB6p8PxbvaHfjPgiFrvTWKxuj/SYSrYRmtuz3hk+rdis
   jcaWZyP3laC2eCZPa4mrGIbUb88Pw1kHfOaQhk9NaTB7gclBEuoVTY1pU
   KuxPPe7RwHijy35h86MtELADJFBmPhohgCpjqemYeJ8y1RYBD4A1+J+V4
   g==;
X-CSE-ConnectionGUID: LA1pwMgZSeiaFEI1JdWtqg==
X-CSE-MsgGUID: 8eP5BMyZTeO+dkLfMSpRRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62675002"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="62675002"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:20:51 -0700
X-CSE-ConnectionGUID: pUGZGVmHQL646LKtSHEfew==
X-CSE-MsgGUID: wVJ+oVSoTiq2vS1kT8DSeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="asc'?scan'208";a="181403172"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:20:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 13:20:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 13:20:50 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 13:20:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdNKQEbF6bM1k1wBdEUQEVQlRBbjZbzvY+K4PnpmGLu6xJ4yUWf0sUqWNGo3VpTyXYFnO88OHJPV+LHx3dDHosPQvL2mqeGUIUnfNnCXkQ5nkJeDfZbUb7XLyOnYt54HaTj9u8wXNCEAEptFRYKERtGcE9kXWYWF1EOhfWgEju4AV536n/n0/nkiRbscuN/r1PyETtm0VQ/1XDE/4ppMpTjtedvqHOypL+6p+RnNIs+51tlZyHR2YPx9qB9eG+1zfWAp9Ww36t4bRcReJL5r1BWw3M6nptWGg2obqbS26df6evt2S7vNkduCEFENyG96gOsnMVFycHgFlKITkRlyuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZW11gw6cqNK24/4x2RhiAhhhhp4xnMqe/zHKTkI46Mk=;
 b=oSqVDWjrqJMlcAj4+YuDFcf4YgGS6j+SE7NlERiRaAFlnPtg6pS6Y4rD36J8gN07u2iA+PENNw7UosVNMPVR0ZL0TezR11kaxu4CBbDMrEcpsepPLTu71rkF4b6iMW1MI2y/W+o6+wo8vZIJIzikCtU6cZWvtjF35irXxVrX+6XRn2bft7cmnmSMzXx16gutyoZuK0nr0CHLjNQ7wOyWJOtHHwe+m1TNuBXtcoCI8U7A8lIvqFLE59Wol9uY4DF8MB2xndkSQ4Bxg4sJle74mMMSyQRuT5i7lg4TVJrme8anMQYGI66O323C7+3r/9NyVlF3gU7+n2Ad2s3RnFlQ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH2PR11MB8836.namprd11.prod.outlook.com (2603:10b6:610:283::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 20:20:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 20:20:47 +0000
Message-ID: <842aa900-7478-4ba2-8fbd-6b96660b084a@intel.com>
Date: Wed, 15 Oct 2025 13:20:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/7] funeth: convert to ndo_hwtstamp API
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Shyam Sundar S K
	<Shyam-sundar.S-k@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Egor Pomozov
	<epomozov@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, "Dimitris
 Michailidis" <dmichail@fungible.com>, MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Simon
 Horman" <horms@kernel.org>, <netdev@vger.kernel.org>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-8-vadim.fedorenko@linux.dev>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251014224216.8163-8-vadim.fedorenko@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------cj6lYF0vTSHIAX0dmYgeDtcf"
X-ClientProxiedBy: MW4PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:303:6a::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH2PR11MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 385fbf14-d2fd-4879-d5c8-08de0c2853a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFIzRDlLK29PdDFWcktaWWl0TTBpVC9mTmxONUF3dU5oYXlCMWVDVHlIemdH?=
 =?utf-8?B?RGo3WkNvUFkvVmQybGRubVRFdENhYUdWQmlqeU0vUVJHeE9MNFBFd3VJanFo?=
 =?utf-8?B?OHlTZUpZT0pZaVpITzA5dXlMVitZemZBNmt0TitxWVBuN205bnpHNG9qaFoy?=
 =?utf-8?B?U1FrVlN6dkdUSm5GY3F3bWtOOEZqcVdrWEdxVlBWUWNBSWJLamE4TzNoY1Br?=
 =?utf-8?B?ckZoUG1ON2JNUnd2WUdqa1kxV3RuNDFRUWJ2c0VabnByN0JsNFdmZGhLREZX?=
 =?utf-8?B?ekI2WG1kWkMwVkRRejZUZVVHcDJYT28wSUN0U2dMcG9PM3owcGVSTUxuNEJ0?=
 =?utf-8?B?bXR6eWo4d2VqNVc4ZDJmTXU5bExIYnFwdFdDSytiZldCbHUyeGpuRlpvUGwy?=
 =?utf-8?B?MW5UTmsrRUg2emlXcnl4ZURzZGxDTml6Q1M0MmE2Y2Q0V0FxQ0RzT2YwRWhX?=
 =?utf-8?B?QUwzU2FoaTd3WlFFUDF0cTlhUnNZazBnaVd0MzcwbStqaEcrUlFFeENMM2RK?=
 =?utf-8?B?aHRsQVREb0Q5UEhMY05SaTlLRjRCTEMxLzNFNjJDWUhQTCtLODRuWURCQkZv?=
 =?utf-8?B?SnlNVEx6V1ozZVNQbm1pUjhsWEpyZzkvYjNtR2xTQ1BXNFJIQUhqcnBsR2tt?=
 =?utf-8?B?RkJZZ21WK1JDSnpROUtISzNQSDB5a2R5b1ZiNFZlR3F4OG1kRzRaekF1NVE1?=
 =?utf-8?B?aXllSzFFNjNpV3JMRHpFd3EzNC81dHRyQzJMQVp0b2c1Qyt1cXpQbDFqMzho?=
 =?utf-8?B?Tmc3LzZ6b3d6NE5mU0E1WkZhTk5DOXNsVFhOZENuR3RTa2NVWWo1QlJOK01L?=
 =?utf-8?B?M3NXQmgzV09lZStaRS9EM0ZmQUt0c0NvVXRnR1ErQ2t6WlRSRllYMFZ0aFI3?=
 =?utf-8?B?cVJla0VBcDNsQ3lFSFJ6SlFTUGhtNUQycDRJNlZHUDhSZmRualhZb0wvSlRr?=
 =?utf-8?B?ZGFVU2s2aUVBS1lKUWxWTzBpcUVJaEc2VTdnR1ZsSkQ0RGJJT2tqOFRyeGhv?=
 =?utf-8?B?N3Rkc0w4S3hreG5ZSTBFYnFJNGNmTUUvWmx3cmMrYW1ZZEtVdHB3SCtjNGM3?=
 =?utf-8?B?OHBSQnpXZEtlR3ZnbVA0bXdQR29rdU5rbWY5SnM2TmpNQW1KaFpzOXZ1amtC?=
 =?utf-8?B?WC9md3ErSDFZc212WlZBbzhpTVJMMzIzSURJL0tzdm9laHgzR3JIUWo5c1Bx?=
 =?utf-8?B?bUpGUTVPWFViZ0FhNWQrRURmbEJyNytZQ21XdGpmeE4wM1hROUt2NmhRT2V4?=
 =?utf-8?B?NnRDM1ViQ2JFdDg3RmpoS0IrNkhOUXk4dVFLblZjb3I0cXRSZE9nOE5DZ1cz?=
 =?utf-8?B?U2ZVSTBPVW5wV0RHbVh5OU1QVk9nOWMrenhBSDFXYlFBTVVDb1ZwVWJKSHRt?=
 =?utf-8?B?SGw0Q3BpcjJ5M1RkSHNzeDFua0lJSmhmb2Vza2RsN2J2R1BPK2pjSGN2eDVp?=
 =?utf-8?B?VjJ6ZFFxcHB5cWtSL2UvdkhSd1A5K1NnQ1ROcWRzVUxJNmpzSnpvSXBvTGg3?=
 =?utf-8?B?L1lIZGg4U1pGbWRhSDFmTGhHVCttTHVLc2hhMDl5akpaeVI5UVdpbWZXbDdP?=
 =?utf-8?B?TnZNQlJ3UW14UDVrQkhhU096YXU5Nkg0eml1Njh5cDVKblJFZUUwRUVCNThp?=
 =?utf-8?B?WEZBeVJlYXEyREZhNzlQdHAyb2RkSFVYeDF1em95NG1CUTZjWk5CY0JPU2o3?=
 =?utf-8?B?UTJxNnBqNWZObUdNMmtaOEp5bjlZYUpXWFh0ZXcvZklTZlBNRVRWQ2xJNkZZ?=
 =?utf-8?B?NktGT1pDZmlHWWt6L0VObHUrdndXWVVrR1BqZUlMRkQxeC9EMTNWb1l6dWNx?=
 =?utf-8?B?ZS9kMVJjYkxxdlRIbXQwYXdJY3puTHNWOHBpNWdSTEtRZVVWSmY2UkFHY1Fu?=
 =?utf-8?B?bU9aS2NFUzcrRnBLd2VzTSt3blE2MXI2dmJFK0cwOEhscTEvU0dRSWFjMjF2?=
 =?utf-8?B?S2dpV1VxQ2xVM1NMS1FISDJENWl1bEpUR3B5SVVGSjB1ckN6eFBGSUlXL3pq?=
 =?utf-8?Q?lUYOcHb+pz6/0rJzdHDG2cu574L3Vs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0lROXZoV2Z2cTN0NVBOaGRwMU5NQ2xDY0lRbis5OXpoQ2Z5Z3R0clZZd3FU?=
 =?utf-8?B?YUYzelpQWm56by9NSjJNdnpmTGYrRkdudGZSbFB4N2p3clliTjhaR3dvbjB1?=
 =?utf-8?B?a0IwaUlZNW1EbmlYaHdsT040anBoUEkwOTdVQUhGVGhDeFk2WVhUOWtVZkgx?=
 =?utf-8?B?TUNmN2ZPZ2luamUxQ09ETmovZEt4WHR3VXRsb0VNUmlZZHBTVldPMmhpRHEv?=
 =?utf-8?B?aEdVR1pFZENGQVBtSElVcEZ2TE96TWdZejZJa0lyOTY4Q3hGaDdlWWNMRW91?=
 =?utf-8?B?ZGVxdUxGNlNKU3Rmem1kbGxwRWIrQWN4K0RCajM3bTVmUElhTklCWnVvcXRE?=
 =?utf-8?B?SVZxdmxBY1ZSYmQ1N1kvTkhINStPdkZWSDdFeDdhTTBpeWJNSjFKdDVpTVNI?=
 =?utf-8?B?TWMxSkVjOFZpVkRzZklYbk8wakxJdWdOdlZKazVIQ2FBY2E0TUNLbTY4aDZN?=
 =?utf-8?B?OWtqYmIxR2lqZ1BscTNpR0w0cm9wRnFzc1NmdnZUMG9MdVlvcXNPdzVCOW5S?=
 =?utf-8?B?VHFDYWVHdXNpYWVRdFkyR0xCb3VJL3NxNVVMazNhUW15bFdCSGpoK3dINnYw?=
 =?utf-8?B?d3V3TW84eENWMVVmOU50Q09mdDdKNHRlUHhncFNQMzNqRWpBVWNDeENjYlor?=
 =?utf-8?B?MjZVcktSd01BSEJHVTZqNGV5SWM3NVBzeXB2V3dQazlHSlJHZ0VIWlZhb0tR?=
 =?utf-8?B?UGJaZVFSNUt5elV1cFJlOTBPVWpXbFllRTV5amFUTm50TGFsUWpyd1FWaE81?=
 =?utf-8?B?bytOWVdVVUFGVU5lNmIxWEUyNjMvM3dsMWxNTXh2bHdVdmdmZ0xLUXVoWFFK?=
 =?utf-8?B?ZDZxTTFFTXcvd280VGV4NnpORHhpR2RvNG96dnFiZE5jTXd1SjhlQ1ZnT2c2?=
 =?utf-8?B?djZvY0hselVDaVlLZWxHeHZWUFl6WkU3VE1GYUR4NHRYZEVkSW01Z1dSSG9G?=
 =?utf-8?B?aXh1L3JhMklNcUdTQVhsUStPWnN0R2l5ZHBmMVpTa0ZnMGN1aHlsT2R3OWJi?=
 =?utf-8?B?Yy9NTE1ITkZnVVNWbXdoL3BINHh1YVQwTnpoQThPQnFkRDBVNEFhOXVFNmhh?=
 =?utf-8?B?bUM0dEIwbUxhaFo2QUwxTmxJc05RUjNDQjhTRGRxSkV0MVlhOFpqclVaTVNI?=
 =?utf-8?B?ODYwdEcxbm04aFhSSmp6alM3ZG9HQ1ViRmR4ZFl5cnNaV0d4UnBQZDdCdHJ4?=
 =?utf-8?B?aCtwQ00wRkJncmVXRTRpcElOdzhQV0NpeStGYjRLMFZiL2UzZnB4MXc5WHZ4?=
 =?utf-8?B?dXRkNjhoTG5DRy9XelhBTGVHMWgveklNY09TcWM1V3JGK2FZdEVmQWNoazRt?=
 =?utf-8?B?VzFySThBcjk3NmJtZjZlalRLcHprdG5FOXkwa0JWMURQSjFRNGdwd1oyYnAr?=
 =?utf-8?B?bEdlOE81SGZPNGxwWUh0WHZVajFjTVV1Z0VKV0NIQlI5cDRUSDZzcTBDOHFJ?=
 =?utf-8?B?WlRDaEFIT3lNcVNrQUxlU0tFUDcxL09YNW80WE5nLzhHa25JeCtWNXVzTWha?=
 =?utf-8?B?bCtqbkpLQlBObktSb2l6UEJmWDlpdEpVZzZJeWd5VVZXT1Bidlp2dkpPekNF?=
 =?utf-8?B?N0NaekpYRStZbnhZUW0yckIzci9XS2xtRVFZM1AvWUp2OGNTaEk3RUd2NUEx?=
 =?utf-8?B?RUJPTWNiQnd0cWVaVUJMWU1kbjVFaWdqL1h5L3N5QkN2MHZueENXYnpiVTlu?=
 =?utf-8?B?RnVIVXZ1Z1A0VkxmWXB2V0dXd2c5QlQrNk1adCtJQVhXRVZkc1BaL1pmMlpr?=
 =?utf-8?B?SzFna1VNYmZjRmZGSmx1R2YwYThDdzNzdzM5VVBWVjNVdS94OU9pZG1CaGlV?=
 =?utf-8?B?YzVnK1p2cEt2d3FYTGR3YmloYVI5NmFUWEMzUTU5bU41YklCMjJNVG0zVnBw?=
 =?utf-8?B?RjBXYzlIRUZROXhkYlNGN3ZSZ2tjT0xGREdlUnJibzRqa3gzckNvb0lDeE5n?=
 =?utf-8?B?ZGE0bWo4bk9HYVZPMDE2RVJXVnU4dnhYMCtzcFdoN3plR3ovZ2daUlA3U3Vj?=
 =?utf-8?B?Tmkrbmp0ZDRtYjB3RS85YlNsVVF5MlhWa2lmNXZ5N1RDeW1oaDZud0xmR3FQ?=
 =?utf-8?B?bDBjcmZwaGlDUmZhTVh5bWplellkeTFkMWtwRG43bXkyOGVxV0orZ3RRdWdQ?=
 =?utf-8?B?eEFOcFhvTVlPL3VIMXN0cG9taDJvdWVnOW1LT21vZ09Oa3Y4N1hYdkIwUU52?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 385fbf14-d2fd-4879-d5c8-08de0c2853a3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 20:20:47.6303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POsvMKUG4gjJQWMBgYScEdEk1hcVFRNpojEGfJ2g4pq2amIS9LBzPr83OJWb8TQoRwh2EkqJI4cxkzOqoOCs3kd/6mTSpS/+jt3OHS52MlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8836
X-OriginatorOrg: intel.com

--------------cj6lYF0vTSHIAX0dmYgeDtcf
Content-Type: multipart/mixed; boundary="------------rUsx9ifENXz7QseIpGEzZyS7";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Egor Pomozov <epomozov@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Dimitris Michailidis <dmichail@fungible.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Message-ID: <842aa900-7478-4ba2-8fbd-6b96660b084a@intel.com>
Subject: Re: [PATCH net-next v2 7/7] funeth: convert to ndo_hwtstamp API
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-8-vadim.fedorenko@linux.dev>
In-Reply-To: <20251014224216.8163-8-vadim.fedorenko@linux.dev>

--------------rUsx9ifENXz7QseIpGEzZyS7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/14/2025 3:42 PM, Vadim Fedorenko wrote:
> Convert driver to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks=
=2E
> .ndo_eth_ioctl() implementation becomes empty, remove it.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------rUsx9ifENXz7QseIpGEzZyS7--

--------------cj6lYF0vTSHIAX0dmYgeDtcf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPACHgUDAAAAAAAKCRBqll0+bw8o6H8q
AP9ta5xjuDym4/KoMnePi3SZGyshfx7b0a8tiZAQENsU1AEAsQ3ZjUba96lFIZ3InBHx52utNw8l
yz9Vg56+6KAviws=
=kvU5
-----END PGP SIGNATURE-----

--------------cj6lYF0vTSHIAX0dmYgeDtcf--

