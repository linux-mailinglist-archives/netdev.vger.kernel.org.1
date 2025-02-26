Return-Path: <netdev+bounces-169871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D048CA46144
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429A11898E23
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B14220688;
	Wed, 26 Feb 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVvkA14/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A3121A457
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577764; cv=fail; b=slBN1CIr24QlESK1XIYwEzZKZUmkVC9EtX+RPhqTKdpVQVXzkEr9hZkpfqG3uzQ6gzuRlDFuC4grpsRIcHa5sc0qx92XeF4liroyaG+9EEAdtF1HJNluS+Tzl4ltbNF9eacHL1Wy/tjLvxRxEJRmgJ3X2OFrUS6c5L+3Cea7wX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577764; c=relaxed/simple;
	bh=cZlaPr37Nz3SqQ29C8n5C9Ql3yAazLZnPCf2xyXtXNc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dSDjhI+3uJ3QFaZOU7AwA3HtwXKWfUGiCrR5aaUqb2F9QCozmvjxHSPDjNS/PPWbNmTFmHTVLKY9C/NymmwOxeexp+nWOOrEZ+hP7upb/RoVPSWayGw5RO4SeXjbqoGV0+EsEIHhGH5nN132FYSyhzAhaBma0Xjp5GDon0D+/KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVvkA14/; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740577763; x=1772113763;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cZlaPr37Nz3SqQ29C8n5C9Ql3yAazLZnPCf2xyXtXNc=;
  b=GVvkA14/EquG9KN7r9872Df+pQNiVaedlepLCvfYppQPzlDytoX+NJwP
   du+8iYsWQEkP4jfbbJ0It7FB6mlqKEM/TBoltMN1oT/a+mP+ulT9/AQ+m
   N0TJvlSYkmcwgAVIOvUmfCMCb71HhFr/Y9l++/1Z/ock78VTNZZR7EvsK
   lG0RXuX8YrhW2o/18wI/0MAvVnq7UeJ5jIpB77DNa0M3zIM5jeWhwfpSn
   Wj6Hnwokwyw0nd9LvS4VySOSTuk47SF4r/hco4V2lJUtxKOXbj8xAYh9Y
   Oc0VxtyZw9wVkr2cwn/k9pIchVA3kANpMGT2VnduBtKH1PwzRdwj6HDK6
   Q==;
X-CSE-ConnectionGUID: +0d2LaMbQ4W0Axq0eBRjOQ==
X-CSE-MsgGUID: GaqEwlYUT++YlmbuFf3zzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52812455"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="52812455"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:49:22 -0800
X-CSE-ConnectionGUID: 7YNQlMwqTkCjZtyoJq/hQw==
X-CSE-MsgGUID: 7IHLG0FWTmWg0YPxRmcvLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116491964"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:49:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 05:49:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 05:49:21 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 05:49:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6PtriqiCe9Aq72jojddpZEdTbWodKBAefJX6hoLV4D/ainJi4bVD2BZe4BRnrqHTj5kd3LS0mHUkqjAw07+78y6BVLtE7KEps1yiq8TE1poi/Uc9q4nZPsx2lDDs5JFibqAyimTaKHlD1z72ZapqwNOVXEPbBJorHGuOjlorT6ggf0xhIWJKIFa9JRAILDHm+d2md+tFBVCJ9zd4Fz9PsRiclUstLFBcYADDaW/l1BjScJe7Ou8q58vxgLW9Rk8ADT6g+MkuvRP4ms1igEzu45fIDRFJPfPwhL6KlJTLgQvdfggaMsG5nspEk99imELxspHJT6baq1CzGzhPx++Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXjKXBUtksIr6lSClY0YYWzlj3R724npklhP14Jt+yg=;
 b=ce6UIKH/zE+SE198W5GxjopQl7tl7KhU/OzYecYOlCJLDMFoySTCiHk5z/TDWr3zwthrmkiUsV2r38AMZTtCAmOSwQpEp1NSS8jXzoahy9SSSUn0V/0QpeIjnsCJa1siqdSUxAy6W5MokDmo/owPWoLjb/0ZTpxyMnVRJTVH3ALEKvQdpnM+OtbN061/hJKRigD/ELStg05Fc9NE1HjYyfkoK4CIMjdkNsQVPTcuj8ulAId6NwPM+smklWl+Iz09tSZRyhwImKrcHCePAoWGEPvcLpOdy4GQisra+PJCTi5luda/Mq8pF3Ecmcy/GmkSY0wp+gtXDwyglEXqRXiz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB7767.namprd11.prod.outlook.com (2603:10b6:8:138::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 13:49:00 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 13:49:00 +0000
Message-ID: <20879a01-348e-4bec-a880-41e8a6904e60@intel.com>
Date: Wed, 26 Feb 2025 14:48:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] ice: dpll: Remove newline at the end of a
 netlink error message
To: Gal Pressman <gal@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, "Martin
 Habets" <habetsm.xilinx@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
	"Cong Wang" <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Simon
 Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
References: <20250226093904.6632-1-gal@nvidia.com>
 <20250226093904.6632-6-gal@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250226093904.6632-6-gal@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0093.eurprd04.prod.outlook.com
 (2603:10a6:803:64::28) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: f57c997a-1fea-468f-9834-08dd566c52ee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHUzMUJURFBMa3FZSWM4TkdLbmJWU0p4OS91TUZSWkliS0R1UW5jVnZONXpT?=
 =?utf-8?B?a3hyQjdmRzBZR3I3RCt5Z1lMYzU1Q3p6VjhMNytVRElYb0lMZzF0bHBNZ0VD?=
 =?utf-8?B?NFdvZ0sydjM1UDFaaTJxRlRoeVRtd2dXaTd3U25yY09kS2NwaFNnZFh0Wkdh?=
 =?utf-8?B?clBPd1ZTTHZ1QndVbmdHMUhEMW5jMlk4UUF6MitIc0doczlNZDNyUWVOWUJI?=
 =?utf-8?B?R09hRmx6NkZaNG1uM005WFlnSkZWYkpLVjBueVk3Yzd0NXRkSi9qb2VNZTFE?=
 =?utf-8?B?cldvWHVPbTVVWFNiNkFkN1FWVnhzVndWWnRIWTh4anl1NXZZWmlCaEZjYzIv?=
 =?utf-8?B?cUIzVG53eGtsdVZGblppa2Z2ejBIWTF5WlIrSm0wQmdoMjhBbFRoRnFpOHR4?=
 =?utf-8?B?MGl0NHorTEpiditiOHRmOXVyc1BpY3Z3elNqREFLbGlKckVHS1FDd285SlZY?=
 =?utf-8?B?Q1Fqc3krQTN3TzZqaDUyYWp0QUZiaWRIZkRMMGdjTjFhS3haWlo2Z1RRcjh3?=
 =?utf-8?B?TS81OHd4ZTBubkIwTlZiZ3lTNHJNSHo3bkoyR3Jiamx3M3JiejlyS1ZQM3B2?=
 =?utf-8?B?eVp6Zi9lekVxNk9uOWo2SDVneVd1ekIzdGRqeHRSbC9nZXFZa21iN1dzL2o1?=
 =?utf-8?B?QjI5MU9kN2ZickxYcGZNMUZWSlBLV1ZHK1MyZFBRV25WQXJOT0EvdThXb083?=
 =?utf-8?B?MnRuZC9vdFlwc1BZWmhraFdYZCtBL0w2VHhocEphcGZQQ0JjMlZ4cVdWVnc4?=
 =?utf-8?B?YldGSVJibEF1N3F4c1UxS1ppSHpQQThDQk1zYm91THczbG1DSG9wSHNwZ0p5?=
 =?utf-8?B?NXZmQzRXVlIxTVBGVGlDa3VoOWZ3cW85MUI2cGg2T01VZlIrZVVIeUJjWWIx?=
 =?utf-8?B?eE53K2JLVkVvN3ppUTdFTUlEdHFnd2c4eUhSM0RDeVVZakNPSW8yUUJWUXZ0?=
 =?utf-8?B?VjVzTk1LYkhNL2VUamhOTTVtQ1ROYi8xVVQ0clZyQlRPbmIvVWhCaitxZ05Q?=
 =?utf-8?B?dmEzZXRiK2QwaVNtcFVjWVlqcEd4dG83Ky9GdXNLK1pKSzdtM2FlQkF6MTgz?=
 =?utf-8?B?SjZmWmxMTFRGTWFycWdaSFA3a0Z1N2swYStBYUNhdEhmR3RiQ1pteWdzSHIw?=
 =?utf-8?B?bDdZY3JEUlkwbE5UNkdBOXJJZmRkSGllamVaWlU3YVMvTmQ1WUEwZDJUSmEw?=
 =?utf-8?B?bU5HT2FRaG9aN3pRTHVJUWNkUHRrSUJXSFdFWFdVeDhDTmwvTUVpdk1lVVhj?=
 =?utf-8?B?cTNtMld5Z3V1dnJtbE0rRTBpMU82TC9qUXFQNVg4eFlhQSthbHl1NkJuTG02?=
 =?utf-8?B?ZTBaSE12VGFWQXJadUtCSlRSUFIvT1pIemxlL0ptbldUOXM0MThGOCsra3F3?=
 =?utf-8?B?eWdDT3dkQ0VwbjN4amlMcjVnWGtaTmo1eGpVc0J6dVkzcU4rSnlWOS95UDdp?=
 =?utf-8?B?K0dCNWxtaEpzc3pyekl3aSt5bmdiRk9xa09FQ0ZXN1psaENnL3JaSzgxdFZ3?=
 =?utf-8?B?RHVQekYyYnlhZ3ZKMURlcUpSRW42Y1VVMVk0WHFkT2s3UmNVWmIxdk5TUEdR?=
 =?utf-8?B?SGtWWUJmcWxNRlVvU1lEOHJHRzdiREM4dkJ2YlkxV3hucldZZW5yM0d4bXBi?=
 =?utf-8?B?SzdSTi9HOHQyRldoZ0hFdmZ3aVI3aWNEVU5Ma0tBVHFITC9RWUpDN1dDSXB2?=
 =?utf-8?B?eVdQZzZIa0lqTmZ6V01hY3JjV3VOeHUxR0MvZDgzdG40eGlBUnFQVmk3MHVF?=
 =?utf-8?B?MGMyMG5KTnp1emQxWUVpZjdtQmFCYWtURlNpOGs4eER2TkRTbk84Qzh4Nkph?=
 =?utf-8?B?L1NRaVNEQlRrMFUvdWpudnhOUEh4b3h0UGtrcE83dlhHaFJaMkxXWFlISzZP?=
 =?utf-8?Q?xO+dSJ8Qf7wpj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGFYQXdBWjN2THE1K0RSTks5WXdrY1VNRGZsL21TVHRvdGNlMzgvZ1NQVHZj?=
 =?utf-8?B?eFlKVjB2OTdZMDE0a0poK29VaGU3MzRXWWxuOWlRdWJybEh3MExuZU9peEh3?=
 =?utf-8?B?Nlhtb3ZVMTZVYnRJeGVQdFovWXhqMUUwSVJKSy9idDZUeWtjbEw4Q3BsUkZj?=
 =?utf-8?B?bGtoZk03cjIyQ29JaS9yVmZzdnNVb0JNZlFiK0JxZEtURjZ4Y2VPWjlMMG9w?=
 =?utf-8?B?blNOeko4enBPejA1OXFnYlVCZi9lbllBbTFqT1pqczZZU2xIUFR4c1owRXZD?=
 =?utf-8?B?ZUV4TmR3a1llc3Vld3FYOVFWaGFMbEZ4SmdEbDlIS2l4Uk9EVEcxbnJBK3ZN?=
 =?utf-8?B?Mzh3TXdqcXNZMlBXWlh2V0Y0RkUyWUk4aFBlNlNFTDNVaEU2TU83SWRkbmk5?=
 =?utf-8?B?c09UVTRQSkNpczZocVgvYzlFMU1YZGF3MFVRZi9oZWJGeDU0clFVQUhySkNE?=
 =?utf-8?B?NzVlclJ0SDgvNkRBV3JXU1F2MlJmMTJ2R1VEZzFlMWxPaGRjMWRIOWgralpM?=
 =?utf-8?B?TVhiMDdZRnh2Tm1OMldOR3JZa3g4d1k3bzYzUUlKaUFIL05yeXZMQmFkbTI0?=
 =?utf-8?B?a2pwcS90Q2k2UmhvYWo3aml6WjJGcms2WVI3Qi9ERXNCWGIwVmlqemVjbStz?=
 =?utf-8?B?N3R5cU1ORjRwRGgxMkFUU29YZmpKa1ExSlMvTEhJRVJmL1VReHdqOUVhUXFX?=
 =?utf-8?B?NHV2WW9sMWtadGdoR0F1ZmhPcHN6Vzk1QW1kZVVZU2M3N0gvT3phUGkvbkF5?=
 =?utf-8?B?VVJkVFN5SEJscEFpYXpyTzlpQ2RKTDd3U3FQUGYvWXVYdlh6SU1nQW5jVk82?=
 =?utf-8?B?cVlDRDUxNWpwZmNBZzBnWDZYSE9hZUFHeWhsaDhOcVJOVnhOdGN5aURKR2E4?=
 =?utf-8?B?TGtPZzNFWDRzUWhSSk9YZTZDaGttNUh3Q1hDUGdzc2pkR1UzSlpzRDU3MUZG?=
 =?utf-8?B?YkNsaWczNUx0TE5ubGN6OElQMHVNemlUZ0lMbzJvbWZzOVcvMEhsTjdHZnh1?=
 =?utf-8?B?cFdnQk9aWGwvOUlWMkhUdUtXV2ViTnp1RFVLeU93Vjdya05sbDgrVDBGT0pU?=
 =?utf-8?B?elRIeXdyUW5OdHRCZFprajcrWkVJekZvbWtIRkVjSlR3UjU2cWRPOUZoNGJ4?=
 =?utf-8?B?a3NrTllHcHA3Ykw2MlRtM0VRVGt4cjBTc0NBSjEvOVYzaEpwYlNzNzl2RGh0?=
 =?utf-8?B?VFltTlhNbzNaZmRmc2hGcWRSTDJvM0dPbjBOR0RKTk0wUVFZTXN6eUhndEJY?=
 =?utf-8?B?WkcwdUVkcjE1c1JpTHcySXdSelhsSk1haFZibnBhRXlUUHVoZTJyL0tQNmpq?=
 =?utf-8?B?UWMvQnl5Y2tVblhRRHNCOTl2Wk1wZXRzdVg2QU1DNm42bGM0bVI5eGV0eVFt?=
 =?utf-8?B?TTB6alhjaDAxK3BtYk91dWFMcUtLMGhsQ0h0L0s2V3B0cXFZOFJyM3p3Q1M1?=
 =?utf-8?B?bVg2MlN2NFJpdGZ0OGZrK3R5c1JabFF2bWw5NmoySkkvS28vZThOcXd2azZF?=
 =?utf-8?B?WWFjTXhYajZmTXk5c2xUeUNLdFJaMXJJYmhna0toOFpCUXhKRm93VE45SmpC?=
 =?utf-8?B?ZncyeDVqc25na2pqeDRTSFZHK29IRUFjRGlsRDlpL1llNFNMZTk3cnBiN2tL?=
 =?utf-8?B?eTdydFMrRzFMSllkODlRMVB0dUpZbFFnUDBIV29LcXQ2YzEyUDh5S2psWUlD?=
 =?utf-8?B?SWNmcmNDV2Vzb3duWndPY0cyMFN3KzR2TnhJV1gzTnUvcVpWbjNaUVpSdTF5?=
 =?utf-8?B?UjM3K1ZYYjMrSTJKamtKeVFoV3F5MHRCc3p0bS9mU01tRDNKSDhVTzBQcW1P?=
 =?utf-8?B?RkZhMlVqMmJTbHkvRkszTTE0V0duZ0JQazBiREltU2J4MWVzbGtRTjdNTGZt?=
 =?utf-8?B?ZHhOd0NUdWlXb3pIL0RYSWxLTTZYaWIraU12dDZQbXFkMjBaRDhIUWErT0lk?=
 =?utf-8?B?eWRxc3BmLzBmUUh5bGswVzZLNnYwM1ZBZnFaUzNyUlN2TWw2c3JlNUNiUi9x?=
 =?utf-8?B?ZnRGOWd3U0hxMVBMNXhabDQ2OWVuZ2ZvazZ5M1h2bVdkblVNNElFWHZmSWJE?=
 =?utf-8?B?L3Z0MmUyazJwL1BIZk9QZDFyZTMyUVdwOHk5NWNaaXBQK2ZHOWxkR1hoV2xs?=
 =?utf-8?B?OHRSeDU2NFNvL2VITXJVcTBOU0VxVnFsbE42RXBUNGk5S045MTYyQzlYNEpZ?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f57c997a-1fea-468f-9834-08dd566c52ee
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 13:49:00.6463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1QQAs6ftrolRgkB0jpHoWHEjTlN8KsEAwdEkLkWmOG85WtsBbcks6nNRogIEXoQGEB32FXBN/sHFsD5Lsqcn/SuhNVlrLTAELbNnk1ihoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7767
X-OriginatorOrg: intel.com

On 2/26/25 10:39, Gal Pressman wrote:
> Netlink error messages should not have a newline at the end of the
> string.
> 
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 8d806d8ad761..bce3ad6ca2a6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -95,7 +95,7 @@ ice_dpll_pin_freq_set(struct ice_pf *pf, struct ice_dpll_pin *pin,
>   	}
>   	if (ret) {
>   		NL_SET_ERR_MSG_FMT(extack,
> -				   "err:%d %s failed to set pin freq:%u on pin:%u\n",
> +				   "err:%d %s failed to set pin freq:%u on pin:%u",
[...]

