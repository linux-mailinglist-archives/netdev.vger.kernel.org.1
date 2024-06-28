Return-Path: <netdev+bounces-107678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6499091BE61
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8218A1C2350F
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB76158869;
	Fri, 28 Jun 2024 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjOLN3XG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53917158862
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577209; cv=fail; b=HwqhGnNUS8KlcbACLfENi4AnISTiwQIkuSZLZ0Vm43QnEzFa8rSCx+9NM56fPjzt/WTbzgLhJeg7p4bW0NkCRnbTxPQ4FzuVijn41YMDCS4W80lB3ex1cbP4EPSYNOivc/ywGo+ovRIDCdyW1sR8br3R7CPfGzTb8BX3VA9cgv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577209; c=relaxed/simple;
	bh=5b0ZjbVyWXcAmzwmNNmFYf5BP7p3/kjPpWZrtQtS9G4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qitSJZVftqNW7tRUZCZjq1bVrNpHAOx0SQ9ksSHyb6S2rtGCsMlesAoWHpljCW0Rv+w3gWUrI2HsAqPIik9SgWrORLfeRWjSrJfpiTn2mmL2+YVCAYuM2g6jlpv2uXFgkJ2Y3GqiS4XjhmPjmrr4W+iGIPP/R0skHRTyr8R38d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjOLN3XG; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719577207; x=1751113207;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5b0ZjbVyWXcAmzwmNNmFYf5BP7p3/kjPpWZrtQtS9G4=;
  b=SjOLN3XGDBLKlUeXNWZl6i2Y3SEklkxmM5dCpvoste3OCXBaRqQ/PkcR
   KOiFq3S7wyJbDH4CgaPkoBmEVys5SRZqQCvtCe+eH5FUrT9rWSnTPeWrs
   IywhAw8x7FQDmnLfqDYiSmaSmGBxsQz1Dt3sh5dMeo6Q8MsFCx5m6CL+l
   AZXIIfd6N6fRGorMhTF1u5sLW8L5Pl09YldlmXm6Mfv8LKcqr5K7rx1Ld
   KwPMnf1yKe1qJYfuTG9tYsdvSUYy5TawthDYCLlqb4eFBo+0mlmLnfDW2
   IZqhoMWH6gnJN+ElF0705yPs3fxk4TnB1cPFSFz6yXtMmPFxlDgIqzgLh
   A==;
X-CSE-ConnectionGUID: H7t3GstfQzSz9h2jS8EpZA==
X-CSE-MsgGUID: a8FP/oLsSeWHP764QaVQ0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="19658461"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="19658461"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 05:20:06 -0700
X-CSE-ConnectionGUID: QPqyUqSOR5On0L4WarLKrg==
X-CSE-MsgGUID: J+qsM5VQTe+16Xvtmw52pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="49065996"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 05:20:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 05:20:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 05:20:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 05:20:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 05:20:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7Fu3eYCPyjvTSuaiJH7udQrAxIeSgOjesi0FOtc+eoLIpeWKq6cOQnZElir9kSyQO43OCkMEM9xh6gOB/Ptty/LiLYORExVRICuWo0YrrmjEAlsmtIof9XS6WlsuZI/BOnUTtYNGEgDA8IO+1b2mW6VBSCdt712Vy53/rr5qlCkSUUFi6+5i1KPqyYY592PPz1xS99XHEq3DRW6RmvWgQpC/ml1XwMYkoFiIe3EBqFOYowiwwO+hQzcOsm/+HK1o6hhoQgvxBTpHZvYjE65qI6Hgl6CBu++aRClep7JGFGYCnUAQedA9iY79A1musOZXDqJ+dvjITEXVK2RMwzIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mx9SiJrI2U9z1/k1m8sMbmMoaHkpuj50FaMH/p//l3g=;
 b=TfsZWmqy+OAhzdvQqPS+LNuU3wU/Xhpw1rTurDEj6vzUo8hoJfIh0/uLdW1uKL8ZJJodz+8Aqlc+GnivzLI3cYanbDNyclNcIYalIX/QUT2sqxM7rk7CmFrwR3Ng1jz2UL5S+bt3vb1fxlNKt0/bzDfwsCrerQCJtJuyBEbANsOEbCdtsnUyuRF/DIPPXCpvTRN8cwUqNwr+BCkeiXn7CCK3ixRQz4MvWyFgmQGOAle17jn3FdyPCo1XJNLk0fWVRMfFmyT0pFKPh5kPoE4/yv6K4CRwvRHLJzFoaLZ4Dtqn/AqM7Blog6xOXcSkC4J9dIqIyH85MoB1D7+XXuDK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW4PR11MB5912.namprd11.prod.outlook.com (2603:10b6:303:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 12:20:02 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 12:20:02 +0000
Message-ID: <47994542-5bff-485b-b68c-23883f355880@intel.com>
Date: Fri, 28 Jun 2024 14:19:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 0/9] ethtool: track custom RSS contexts in the
 core
To: <edward.cree@amd.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <linux-net-drivers@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <habetsm.xilinx@gmail.com>,
	<sudheer.mogilappagari@intel.com>, <jdamato@fastly.com>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <jacob.e.keller@intel.com>, <andrew@lunn.ch>,
	<ahmed.zaki@intel.com>, <horms@kernel.org>
References: <cover.1719502239.git.ecree.xilinx@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1719502239.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0070.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::21) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW4PR11MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: e02b2c45-5771-48db-90a6-08dc976ca2e7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlRaaEN5MjZTN0hYNTJWelQ1Q2dpM3pBRUJJKzR4NC9YbnBKTWNsMGlrOHln?=
 =?utf-8?B?NStpUnJ6QjlxZGZjV09GMGRYc3pmdTdadG1pWHJQSjJtNy8vUnRRSnRGWlY5?=
 =?utf-8?B?d09wQzRJUkdWTHpkbS9qdWo4K3R4Z1B2bGRIUDZmRDV6dElEczUyMEVHRHhB?=
 =?utf-8?B?S3VKVXY4c0lzcnNzVGhtc1oydnRidFgxckdQYUVPeENJZm4rNnhsbkRqd2xU?=
 =?utf-8?B?R1R3UkIwRS9oU05LL1k4Mm9NMWFKR3ZETGpJWXpMVk9ESVRQeEhOanprQjFz?=
 =?utf-8?B?S3Q2ZTlPOHQrOHdQaEVKOUM5bEFEQm5pWmdWMjZUZ2lrWTlCWUw2MzlNRnhG?=
 =?utf-8?B?WkkyS2x2WloxaEZDYlFTOG96NjYwcmpLNWdhVDl2VW1KUjUzM1VTektiYW5m?=
 =?utf-8?B?ajlLMG00WEF3cXRiVWJLeUxyZlc4RXd0ZVUrb0tYeHBPUjJ3Ujc5UlNzdG5n?=
 =?utf-8?B?cEdBSU5aWlBHSHRhNWZTWkQrcmYzemtHRlhxVGRsTEY2VlZFWk9yUE1UdXY0?=
 =?utf-8?B?RmFRb2tBakd6bXY0dmVUVTl5Nkw2WWlvdlBidFpKUTRwbTZFUFlSZWMzL2pm?=
 =?utf-8?B?UjBVQjQwZTdVMkgxNFRYK0NRUEF5NGk3UFZSajhIRE12b3I4M3lBUGZPdkgr?=
 =?utf-8?B?QUtrT0dzekFyNnR1TWhPc2NlaVlGcEo2WHp0UlJvWXl1UnhkVjRnUDAzMXRB?=
 =?utf-8?B?UVA0U0JZNjh6Ti9UbCsrZ0dBNEJJMC9pQ0JGTE9leGRKWkFrVlZ6REZYRHM3?=
 =?utf-8?B?Q2RBYXZLaFhNRDF6UXpTM0lrT0pXUURSZWprUGMrOTFxSmpkV01KeGpwanBa?=
 =?utf-8?B?OTlwdVJqSzBsanNweG9wTVFiSUZjRVpGRDYyOVNOeTFoK1l4eFJJampVR2Vj?=
 =?utf-8?B?TGJ5dkpMRTFDZVBmd01YTGpKTDROeklzSEFjZXVQQTNZZGY3a20ySmtGV09B?=
 =?utf-8?B?Z212cE9VOVg3emljOWlyQ2Z2bXJOS0pvTUhTM3BLYy9YcDJyS29DdGZhVity?=
 =?utf-8?B?a2QyUFdubTlBR0RNK09kekE4TEcvSUFxL1g4Y3ZQYVlMenhWa05MSUNjQVl4?=
 =?utf-8?B?ZE5oVjZUb1hRQzhrbGJnZGFyUlFyQnQ4MkN3Qy9MRUJKUEFoTW1UaGVkczZY?=
 =?utf-8?B?bnZPRUhteCtpUGdXTTh6ZjhNcW1tekQvYW45bXBOeUw4SWg1SE1iNDFaaEFv?=
 =?utf-8?B?K1RlOTB3ZGVJNWFDd1JYL0t4UkpSdmJ4b1ZaZC9kbjBlVTNtMzRXdXhQd0cw?=
 =?utf-8?B?UDkvTDRNRTVSSTYvRzBmeTUxQno3NnluRE94dEtLanNTMG10cStBVmcxeDBa?=
 =?utf-8?B?NU1RNGZHcFVaY0VwWXZ5WWFNdWJkR0lyaGdjZEdqZ1IyV2FCb0RkM3JMYVMw?=
 =?utf-8?B?cTVXNEtIQjY5YXdTRGtKcXArUFY3aWRwcXlxbnRjMXIyc0JkWDhORVFUanlR?=
 =?utf-8?B?TmVDV2ZCdmU2YU5yZzNHMVYwT0xZckRBZ2dpNzZheUJibnAzR2VmWXViM3JY?=
 =?utf-8?B?TmxqVmsrcnlKTmFyOERlaHRnMHI1SW1ucVU5TE8xUnNma3Y5SEdJZzEzYWtN?=
 =?utf-8?B?dlRWdkpnZnZadkRmNlNtQjJGMlp5T2x5RHJUQlFYbC91ZWo0YVY1ZUp5U3g3?=
 =?utf-8?B?cjNVYVJ5V25SVmNoNWUrRDd1NzVKbDFzUjVHbGdycklMR0R3NE1MRi9ia0R1?=
 =?utf-8?B?YjRJaDByWk1iSTBZenhIbHFEb2JJY0JTbjZlajVUN01jbEgwd0h0WnJaOU9r?=
 =?utf-8?B?TEtqclFVbmZBdWlzbnVwbThLcGErNWwzZ0VrR1RaVUh6Mnh4SjBKMGh4VndJ?=
 =?utf-8?B?SnZwMGtoNzFoN050UFhrUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXNHWW9iRzdCS0dLbFdUS0g3TDNyaXRCUzFxcEFQVmI0bkk0M2ZrRXNmbnlp?=
 =?utf-8?B?aU4yTHd3TDQ0UEJZWFdCTGZuWTVsYkxIVkpZWjNMd1J0N21XTVZObzMxTWNS?=
 =?utf-8?B?dG5HWFpXb1ROZXg4ZlVXK3ZGSHRkb0JkOXZtZ1Y3c21ORFFtNmFjWlU5R0hI?=
 =?utf-8?B?ejN4LzFWUjNWQWN4QU5QeklINmVvcExWZUMzZDZmNFRsZE9sakVTVzYxdFha?=
 =?utf-8?B?RkRqYTFsaWE5bExxZlNPZm5iSnM1SFpQa29Ed042Vi83UDZaN0lQanJFVEF0?=
 =?utf-8?B?djFTdlk0TFdjTWZFSDdLTGJLNEhOaTV2bjVsRWtCUkRHdVR4UDlWMVFzSTIz?=
 =?utf-8?B?NDNvUHV1bER2QjdDSUtHUkZjN2daTTV0WUNLeUdrZ1BMM0IyT0JmOEpPd21Z?=
 =?utf-8?B?TDNyS1ZpUzkxUlN1bWNKMXVrTHAyc1A5NlVrTU9NdkMxZ2t0RHRWTHVVUkFy?=
 =?utf-8?B?VWNVVGFWZCt0VHpyRC9mcEo4SnA4SDdkWHRqSTVsamxEVkxqQmpCM1VUTWts?=
 =?utf-8?B?YndZWmhhUWd1eEJveGdzYkxrNmRiSXY2b3RuMXc3cC9CUHArdG5HWGZHaG9R?=
 =?utf-8?B?RmkxUy8rVUQycGVWNng3VTk5c0V0WmU1UzR3UXROd1NzNGZXUzIzZXVJeEVC?=
 =?utf-8?B?TDlxSkZRTStPNC9xdnNESDhFTXVaa1BxeTFrMUhpOEFVVUNJSmJSQUZCNkdo?=
 =?utf-8?B?VVRQS21WWUxrOWhUOGw5ZGtkVHlUUk4zWW12NXpXcmxXL0J2MjN6Qnl2YUt2?=
 =?utf-8?B?QnBnbDYzLytXUFlpVHNVcmdpNHFXeXduSzFZL3N5UElPQmpCdDVLVUhPSE55?=
 =?utf-8?B?NXFCYWRZb0h3VFJCUkRLV3lIS09NOGI3ZkFpWXlhMmdDMzZCZVkzQ1Uyempz?=
 =?utf-8?B?RTIyakFLV2tXOHBsckJQTUxMUzUxQmE1T0JNZDRyaVJiSG9LRVhINnY4dlF2?=
 =?utf-8?B?QmZZRzVVcWdreENhNjRrcForN09HNWhLNGVmRC8zdEtqZGsrU2l6YUFQWFdE?=
 =?utf-8?B?YzI1bUc0S1NXRDRJUXFhQWhrOForT2FhejViMzU5VUJFc1U0NUdvV1dWWVR2?=
 =?utf-8?B?WXg2Qko0eUNTYUJuejNZWHhqbnlEcWpsOFMwWEtTUGl0cmZVdWZvV2JiMDNq?=
 =?utf-8?B?NWhlanlFZFdRQ21HUVVWQnhrbUF2aHFNU1V4eXdFS0U4a3hBZnhZd2J2RkMr?=
 =?utf-8?B?SEs4K005WkdWSEpCU2J5MzJIOG9hRlVUWmp6TkpKRHFMTkF4cTNjV3lObEFs?=
 =?utf-8?B?b3Y5Q2dMV2JNUHl6QXdabFBqMEVia2lDS3hFK1VmZHNWNUgwTUJNeG4rREZE?=
 =?utf-8?B?VG9nS1VxbzhjeXJINXlQeUVCdDltRVovSjA0cW9GZnlyRTJHa3Z2YW5YR1JM?=
 =?utf-8?B?UGdkNnNDWFYvQVFYN0hMT1cxVkNYL3hJd1ZyZGpyNGhsNEMwa0FkdEJia01U?=
 =?utf-8?B?NjVYaGFBTGRTMnRUV0tMak1YQmE0bm9FdkhuNStQTG4wTkxnNElqa0NFQ0lL?=
 =?utf-8?B?MndpQ0VZaWxTNGwyazhYUnl6S3JNYTZXVlNTNlNualJxZEJ3SVF3bVo1WStR?=
 =?utf-8?B?Zko2U3pxTGxETlg0Q1ZRSkxlWEE1VFhTUnVUcFc1VndqeDkrUGRJbitPaVo0?=
 =?utf-8?B?UFNYRy91SEV6TVFkOUg4b0h0VllrZU5MeGM5N0pBdUFwR3J5THdVN2xXa2ZV?=
 =?utf-8?B?NGVwOHQ5TE5ybVRCYUUzMFA2TXNpSlRvamJOTm5ZZzhQc1cxTVhCbXgrNGYv?=
 =?utf-8?B?NjRGMWxNbmJveExYZHpZc0hXNkFZTG55OUlnK1NiTnY5Yzc5ZEI0VW9zMXdT?=
 =?utf-8?B?NE5QUUhSY0J2RkllU2dnbFlRQzhKK2RkZ04vTFJvZlI2Smp5c3RnSUZlYmJD?=
 =?utf-8?B?NjRuLzc1cmdka3lSZ2g4cXBjUWdGaWUzNDAxUXpoaXhOR1lZUlREK3RwNkk1?=
 =?utf-8?B?L1dmWFNNdlZKd1ZBRTVBajd3c2pZclRXcnZFTEo0MmVVZTNvVkdCYzgyOFI0?=
 =?utf-8?B?YXdYOElJSEJmemtOTlo5MGNROXl2blZ2M3QwRTdEWDZOaWY5ZXB3U01kRTkx?=
 =?utf-8?B?dTNycitSVlRQK1BBT2tSQmNvanAvZmR0Y1dHSVE1QVNVbzVXck9ydWs4MlRH?=
 =?utf-8?B?M1hIMjMyeVdwVHlxWTNRUU9uc1VKK1VvT29mK3UxUGk5cmwrbmJheUMvbDhh?=
 =?utf-8?Q?2ofrUD9lKXDiiguQsqGNMAE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e02b2c45-5771-48db-90a6-08dc976ca2e7
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 12:20:02.6012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7h1++q6NpE/HL39WmjBmpQ9ZwiqGWR3hGFIZk2xRs7SMm5JmD/oTpfbNwIyayKdOVEp1pdaadrHMt3b9UmSa7+3X/Whziwr7hvDp2qJzuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5912
X-OriginatorOrg: intel.com

On 6/27/24 17:33, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Make the core responsible for tracking the set of custom RSS contexts,
>   their IDs, indirection tables, hash keys, and hash functions; this
>   lets us get rid of duplicative code in drivers, and will allow us to
>   support netlink dumps later.
> 
> This series only moves the sfc EF10 & EF100 driver over to the new API;
>   other drivers (mvpp2, octeontx2, mlx5, sfc/siena, bnxt_en) can be converted
>   afterwards and the legacy API removed.
> 
> Changes in v8:
> * use struct_size_t in patch 3 (Przemek)

Thanks! Also for the additional explanations!
For the series:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> 
> Changes in v7:
> * ensure 'ret' is initialised in ethtool_get_rxfh (horms)
> 
> Changes in v6:
> * fixed kdoc for renamed fields
> * always call setter in netdev_rss_contexts_free()
> * document that 'create' method should populate ctx for driver-chosen defaults
> * on 'ethtool -x', get info from the tracking xarray rather than calling the
>    driver's get_rxfh method.  This makes it easier to test that the tracking is
>    correct, in the absence of future code like netlink dumps to use it.
> 
> Changes in v5:
> * Rebased on top of Ahmed Zaki's struct ethtool_rxfh_param API
> * Moved rxfh_max_context_id to the ethtool ops struct
> 
> Changes in v4:
> * replaced IDR with XArray
> * grouped initialisations together in patch 6
> * dropped RFC tags
> 
> Changes in v3:
> * Added WangXun ngbe to patch #1, not sure if they've added WoL support since
>    v2 or if I just missed it last time around
> * Re-ordered struct ethtool_netdev_state to avoid hole (Andrew Lunn)
> * Fixed some resource leaks in error handling paths (kuba)
> * Added maintainers of other context-using drivers to CC
> 
> Edward Cree (9):
>    net: move ethtool-related netdev state into its own struct
>    net: ethtool: attach an XArray of custom RSS contexts to a netdevice
>    net: ethtool: record custom RSS contexts in the XArray
>    net: ethtool: let the core choose RSS context IDs
>    net: ethtool: add an extack parameter to new rxfh_context APIs
>    net: ethtool: add a mutex protecting RSS contexts
>    sfc: use new rxfh_context API
>    net: ethtool: use the tracking array for get_rxfh on custom RSS
>      contexts
>    sfc: remove get_rxfh_context dead code
> 
>   drivers/net/ethernet/realtek/r8169_main.c     |   4 +-
>   drivers/net/ethernet/sfc/ef10.c               |   2 +-
>   drivers/net/ethernet/sfc/ef100_ethtool.c      |   4 +
>   drivers/net/ethernet/sfc/efx.c                |   2 +-
>   drivers/net/ethernet/sfc/efx.h                |   2 +-
>   drivers/net/ethernet/sfc/efx_common.c         |  10 +-
>   drivers/net/ethernet/sfc/ethtool.c            |   4 +
>   drivers/net/ethernet/sfc/ethtool_common.c     | 168 ++++++++----------
>   drivers/net/ethernet/sfc/ethtool_common.h     |  12 ++
>   drivers/net/ethernet/sfc/mcdi_filters.c       | 135 +++++++-------
>   drivers/net/ethernet/sfc/mcdi_filters.h       |   8 +-
>   drivers/net/ethernet/sfc/net_driver.h         |  28 +--
>   drivers/net/ethernet/sfc/rx_common.c          |  64 ++-----
>   drivers/net/ethernet/sfc/rx_common.h          |   8 +-
>   .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   4 +-
>   drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   2 +-
>   drivers/net/phy/phy.c                         |   2 +-
>   drivers/net/phy/phy_device.c                  |   5 +-
>   drivers/net/phy/phylink.c                     |   2 +-
>   include/linux/ethtool.h                       | 110 ++++++++++++
>   include/linux/netdevice.h                     |   7 +-
>   net/core/dev.c                                |  40 +++++
>   net/ethtool/ioctl.c                           | 136 +++++++++++++-
>   net/ethtool/wol.c                             |   2 +-
>   24 files changed, 496 insertions(+), 265 deletions(-)
> 
> 


