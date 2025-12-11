Return-Path: <netdev+bounces-244394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2ABCB6343
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 15:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCB313071958
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08FA2367DF;
	Thu, 11 Dec 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYP4tGD8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A0E555;
	Thu, 11 Dec 2025 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765463496; cv=fail; b=uTP4J+IGeSwOm91ypTrEqoNsExprFBTJ40fc7zl9BVZEGHnJY9uJnRQgiXnXsJAv/EIPakM6v1WEZcl/ZKdYsZogWfVoelaoHp6FBmWqkp4Kh28tRKqt3rvK9eUgqfdugPze6YEhbCkN24L6qI4KrHPbs3im5bayvvn1X0d+l2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765463496; c=relaxed/simple;
	bh=/vlFGNaxdeOVmX/0IX5cdjSy+qnHnNADpza5NI5QI7I=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=c4CPvUZgEYD+GZ674AXcOwgXiOcdVWYUJk1T9922tuvOB8wJT2gj4FXUm5lCgN3r85PWGWHsqDZBeR766r26CM3BtaH2PIKZDuU596P5LS/XVbyJdUscY7dooPgw5lcwQ5L/H62QPu8ZGpU/0kr5BHS2pghAsvWTxZOqfXJPEfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYP4tGD8; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765463494; x=1796999494;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=/vlFGNaxdeOVmX/0IX5cdjSy+qnHnNADpza5NI5QI7I=;
  b=ZYP4tGD8eb+4G8gZXHsVJMTjr1nQUuLGUTkmNNP7rRsoDD4VHjIb1BMT
   GHuALegR9odxCwJeE/XUMANS6PknvaCF0yBWY8ZLvL9oM40Tt5xBPd4H/
   +uAIw/AbCmeBUMgGwOrIlIlbojjYD5WIy8W74bzRrLk4ziuUDdhkWa/p6
   kVxPfwzIFy62iaxeLkJVmB5R9IdJ5v8Pb+uGwGX2DFYkv4dowciWqHp3n
   77t3B+WiRe5N1UQSFaeqK/Kterjj6fYg/4mqVDNdSDFckkzFd4/CIPkr1
   Br/M2mwXvxQRxg3X/j8BwE/wRQ7IKuvZYraJu5Ts+CIXBlSOGHcih+A/W
   g==;
X-CSE-ConnectionGUID: xGvy7Yh3R6SjGVtpkBATkg==
X-CSE-MsgGUID: I7yAzkJhQW2s9fOP6uEvew==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67178493"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="67178493"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 06:31:33 -0800
X-CSE-ConnectionGUID: KLviafGNSK2C/NF1aEkFpg==
X-CSE-MsgGUID: NALYf3qkTK2xtjmBXnPNtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="196079190"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 06:31:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 06:31:32 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 06:31:32 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 06:31:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFxAVXPMveHA9e0tdFm1kO4JvDolxUwvLJd1AO5TOGT86QmCJmN4RHVrUbHmMQPH6cYC+Bdxk3kkaGx7P2ccKean4bxE1nJY7D+eb2PWcFFfyiqb9o1xifHl6aaNy/gFyr8V05xKY37PB3D1OuKN9j5zpQOMTpmbzIirKJkObRFSY9PwxttFVpuVFs2pAoyu0PpEPThfmZJrmaZ8R4R6MDD30lIYfDbobvJFHrm70gen1JINDaPHu7qmeBOyT1+bqvtNLBY+ItQ1DqWxCP4clQAQe6OCVCCI7EyfNhNENw2ptvH3GFhH4ExwdjJ2wSaLqkHY6gSnkLqR39Lf3GNC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBDe42lnf+7v72swq+2HpHV7P9whdetPsV4rcPjyBxo=;
 b=AJ+E76EQuio1k8L4y/fAvoKD3D5GfGqvssnJDZDg2l24COoceI89YdL8K3UHpyl+sFbN29dfEoKU3IOvh7Ii+ehicHwV9nyL1GivyITh4mzG+mXlU2fJjGF2jGg7XhQ8ZHqnvpu6iFE8HpTKk5dmibnDI4SqeuSTnj2XwlQeaRLg9MC58PEuzPs/TIytTjNm5VycyF/Zbb1qK9mh5RYZM6KktlX9pu08EWEg6AHKCzJg/9MAXlA6AGo0CLxsCKzxMCHI5eXCThBHa/LdhfiEePlIASiwf0IuffOCrs5OJbfuYwOTopQsdf4mHl96j1P8fMWJ8wYp+EfXEO5KAdAUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB6764.namprd11.prod.outlook.com (2603:10b6:303:209::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 14:31:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 14:31:27 +0000
Date: Thu, 11 Dec 2025 22:31:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [net]  5628f3fe3b:
 sockperf.throughput.UDP.msg_per_sec 20.1% regression
Message-ID: <202512112119.5b9829a-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: cdbcb909-4007-485e-d3e9-08de38c1f7f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?cYEM3QDRWQ8ZQ/JuVEPIUCnY5xs5NT4ibZvyeFFgfjuJgY3OoE5cW4/BEt?=
 =?iso-8859-1?Q?pn6gLcqnRXutSlynqK47+YEqMGrp5CdAKSNSBmIhS1PNlL1T/7513GQfhe?=
 =?iso-8859-1?Q?f/VfB+VIbL7sZKKMgI8xmnTt6T+iTrs0lycy+uhhhCvmkcwGfdhRtQEji4?=
 =?iso-8859-1?Q?cj05mhtmqzKUBGbsyQzupUnOUQ8jFfH68zi5exYv0gjvlJr/f+oAwIO2Ft?=
 =?iso-8859-1?Q?j6bAiJ0yq7s1TqNqtyvByHLPANqpzNtTDkrzowGgoDomU+t622EMQFnwV9?=
 =?iso-8859-1?Q?BOGZ7VlM55PLiJ/JdhmjBZQgtkJZ5JKv71+GaG9WxGbjihobwS6UwhXvD6?=
 =?iso-8859-1?Q?w2qzOEKaConrDsraAroNt8zKDOPC5wfUZn0soh1s4r97QU7BoCTo5Ibm5s?=
 =?iso-8859-1?Q?s6JmTxQ9boHqESz14fqIAeLXTCwUEDcGZzidrlmHhMsxw6/wy4FQBCjNWy?=
 =?iso-8859-1?Q?CKaAcrJgwu18zkq+i0LwSBTFlt0AIryweD9Y50gJWPLLFWxGlxl1KQVqS2?=
 =?iso-8859-1?Q?KM4pBT/D94P3OmFNvj00aHA+7+xzX3JgDj8pBVYMJ7z0saTKSL5qX7hSG9?=
 =?iso-8859-1?Q?0mCnHLwfFMy1roZyUwGtQU+lmTHd7k3ecdy93e5mJfB6LBLtAYyKVcc39P?=
 =?iso-8859-1?Q?6121tID5nOXL48ab76uJGN8wMmr97Dy8+NoCl9/xz4BtixIGsQ71htcwdl?=
 =?iso-8859-1?Q?ACHHp+o74haeiY2zvmHrqcy+cqBzliMwq5BvoIiij6RxPLxXR9Kx4CxHMg?=
 =?iso-8859-1?Q?riUcierq9okKUAL6qfPNAokDIAs3JDjNfzfoetJIK+71rqKmjv6FTOBCo0?=
 =?iso-8859-1?Q?4B1G4/oAfVenr4Ge+vCebYXEfU2Z+0hzx+zsjye6ynX4sRbWHet+9konj4?=
 =?iso-8859-1?Q?QbJWgRGmqwQzyhYGkatExmTpKsvB+Pk8HVWSBuHsfs5tI9/GTkguRgII38?=
 =?iso-8859-1?Q?ixR7O6rDflHEpDF26tZVKTLkubpJkYanqRUYV7uZlfXpwuzt/uP9hReUYL?=
 =?iso-8859-1?Q?loYtZCuGdXRgT3jTslFwrkcByOu0f80MJ3ZVIyx9t8hIJeR2+Wax2VyY79?=
 =?iso-8859-1?Q?E8PkhKn+WcGoSZORWk4Jhu34hnoNm7B4SUu5luMaLZqb/mHV3P/5hP1Zx+?=
 =?iso-8859-1?Q?VCj9E4CFckslPuOeqNQX8cJW3R0ujps6pg/QGoYDgo/JE+u5/dRYG+7E7A?=
 =?iso-8859-1?Q?PPrTp8GABinSNbt3tQvUQni07/KuEaMPPoW44HfX3aHAmujLc2J/+33e1K?=
 =?iso-8859-1?Q?CUastupAMqnPm9eoU7KkDh/eWD9l80uwIOBDRMVwm+PIVRoBM+SMQSWPYQ?=
 =?iso-8859-1?Q?5/Ja+nRfryrPIbjv/qjX6qT3jOBOjTNPhNK31ImAksiiCuN+9tNUDwfBXd?=
 =?iso-8859-1?Q?KJu+kOXNlu7FnkKw5b+XNZ2Bwxh+er/AKWfrsPOUVDGDGAgTUCMKk5mhYX?=
 =?iso-8859-1?Q?yJQDPm3XeHel1HARBNuc7hqiJYg3JpFoHgEqcBrIftAMgLM1A2n2qVDQHa?=
 =?iso-8859-1?Q?nZPGQ18xW0fPeecnYqnZ6UyUeniDPhg1BP0FY7nVid7Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?elsPDyktGjAO70GZlsC/uqEUCBWaO2u/uYakYTKrwPcV2VZwhtQJMGIGFN?=
 =?iso-8859-1?Q?FBEfkd5p6Vyz4wxoKBzludLbjWvZDNepDuDrJGQCaJ0p/BvKs2KzHizznn?=
 =?iso-8859-1?Q?KJ8s+8zHiRQm903C/D7FG2eOGWIKB6u1RakhUSSO1AyAgtpJHkBEQEI0WN?=
 =?iso-8859-1?Q?qeeBHzlJayV5AYGwZMiL0GDpGBUkFdnzPxuj8JUtSGAFxIYsKQA+it5Tfq?=
 =?iso-8859-1?Q?5EDEqhX/L3mWZb2RKYh2V74aoj04XbKNS4Eh0953CcskvSmPAw6fsWwRVB?=
 =?iso-8859-1?Q?E0DCKckIBKs59EfffZ9FZnG6z0oihZHcqN+BCw5tHv8dKUBYmLJbDTtB3o?=
 =?iso-8859-1?Q?thd2LkK0y3y57ma8vCE/6vicO6zJ7ysxEq9M3j9ckckvHtHppl9rGIPMlD?=
 =?iso-8859-1?Q?krVLR5AtovSZeFfZfG7A3iaDaGVzC2FM6uX8c21U2EOVvcvYtgsHADfKvB?=
 =?iso-8859-1?Q?ByUdqoJ5RBtBE/Y9/78kGkEnex+M1NnRnOzG+CLr1PtaAUKixuKpeavHDC?=
 =?iso-8859-1?Q?8l9KcNWxMxdOaHs/gcOyZxqhKPrrP8gcuAV3f1cnqlyH+h/HN5JazwULGe?=
 =?iso-8859-1?Q?6YmmD8DRFZPIIVvi0mcFtvkevBsVA7ocUpLqPQKPl3yZiXWaT5C4opUoET?=
 =?iso-8859-1?Q?fBE/VHTqcceBGU43dEXP4FTuQTL0yWBp4wIGRCxeHU85uBwHUe/trSJIs/?=
 =?iso-8859-1?Q?WEsQZieC1VO+hVxUOb+8CZ84c1QJ4bCx4dXubQNEnIJJae2IRyfaLdRfwM?=
 =?iso-8859-1?Q?OIH9fUWGnxgm94B7iXYNkrGLV5b6UR1vHVKAY8LTlB+Ryu8D/AOMIm9GGt?=
 =?iso-8859-1?Q?dYht38GMCQ6wfvsshi500ZwEiXc7fePxgO/eqtTc5TjVjhAoA/RWHWNONW?=
 =?iso-8859-1?Q?+U2peuKPBlGE7RXT2c+8YVc9RhSR0KyB4WqlHssrwZEjHSHMUzm/KfIBCT?=
 =?iso-8859-1?Q?SZ0CRp2TMVk+m608mkKvONmqcgu8L15Vz8xLRb/l+fYonKO0KIGpRu/4YS?=
 =?iso-8859-1?Q?ycQGD6DHES+W4fYf+Iko5D9lRJvBSKnX8muqwqzSnYPUDtW8Gfm/klJ0Nk?=
 =?iso-8859-1?Q?jJO8BoIIIup9ze6zx7bYPLL43rGtWDy5m4gOWAGQLGbcTVQ3kdeCpDFxbC?=
 =?iso-8859-1?Q?uyhlaMSsfMPReET7X8YmIBuvUn9LDfcpIsQ4iwyL0SsoCXva7AoiOYrO7v?=
 =?iso-8859-1?Q?zmSyKhTBAMKVnOSrcmkBnfspaPQ6m7vg2QAVPPoUuMtsFOb9qCI5aE/TuK?=
 =?iso-8859-1?Q?4OgPb7y/Ir3Lp8gHUTqs9cgk9WRcVIEcnnnF+YzkjU5Oroft0ZCMVA2N00?=
 =?iso-8859-1?Q?aEb/BHmJv5QsakXr5CVHkGJHNprWt3gkV3j7QFQKbvrRcodXQ4E+VasFUl?=
 =?iso-8859-1?Q?g5t9XGK2UxLlvSQtY2sZJbkiLxcyh3hBoVrlfajcFqnO78TObKIa+rrPT/?=
 =?iso-8859-1?Q?FMvgi4smHFjJEByyW6cTS4UWIvIkQb9TxlRUF+xXcE0ji7xz1FBnGxX13b?=
 =?iso-8859-1?Q?GF+8KBilfdksbBlc0KEVsZ7+RlR6gTVM+mEleqfOc3q/If6YykhOtFwrKH?=
 =?iso-8859-1?Q?BCWB9X1kecLYuGcDSuZ3wSBtRvYNkVXM7ZoV9y6pvLiIrLHldFCCNzfFjt?=
 =?iso-8859-1?Q?y7l/z3vRy0UR9gfzLzj1TQP66iAp7Wnt+57xxju51Sv3oNnE4/NhybDg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbcb909-4007-485e-d3e9-08de38c1f7f8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 14:31:27.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTZsvwLeWhPiZ9J8u5j/PSLknG+hIfZVxKuCDpakDV7KE5JCIhL9LdNiJ0zzOwvFzG2tQaAyIaSUL2mvHqysCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6764
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 20.1% regression of sockperf.throughput.UDP.msg_per_sec on:


commit: 5628f3fe3b16114e8424bbfcf0594caef8958a06 ("net: add NUMA awareness to skb_attempt_defer_free()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on linus/master      cb015814f8b6eebcbb8e46e111d108892c5e6821]
[still regression on linux-next/master c75caf76ed86bbc15a72808f48f8df1608a0886c]

testcase: sockperf
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Forest) with 128G memory
parameters:

	runtime: 600s
	cluster: cs-localhost
	msg_size: 1472b
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_Mbps  6.0% regression                               |
| test machine     | 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Forest) with 128G memory |
| test parameters  | cluster=cs-localhost                                                            |
|                  | cpufreq_governor=performance                                                    |
|                  | ip=ipv4                                                                         |
|                  | nr_threads=1                                                                    |
|                  | runtime=300s                                                                    |
|                  | test=UDP_STREAM                                                                 |
+------------------+---------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202512112119.5b9829a-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251211/202512112119.5b9829a-lkp@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/kconfig/msg_size/rootfs/runtime/tbox_group/testcase:
  cs-localhost/gcc-14/performance/x86_64-rhel-9.4/1472b/debian-13-x86_64-20250902.cgz/600s/lkp-srf-2sp1/sockperf

commit: 
  844c9db7f7 ("net: use llist for sd->defer_list")
  5628f3fe3b ("net: add NUMA awareness to skb_attempt_defer_free()")

844c9db7f7f5fe1b 5628f3fe3b16114e8424bbfcf05 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.10            +0.0        0.12        mpstat.cpu.all.soft%
  16915992 ±  6%     -16.0%   14216230 ±  6%  turbostat.IRQ
    207555            +4.0%     215887        vmstat.system.cs
     28663 ±  6%     -15.2%      24304 ±  6%  vmstat.system.in
  11048577            -1.6%   10873254        proc-vmstat.numa_hit
  10782437            -1.6%   10607299        proc-vmstat.numa_local
  75337098            -1.9%   73920567        proc-vmstat.pgalloc_normal
  75257799            -1.9%   73843141        proc-vmstat.pgfree
      2564            -2.0%       2514        sockperf.throughput.TCP.BandWidth_MBps
   1826630            -2.0%    1790940        sockperf.throughput.TCP.msg_per_sec
    941.44           -20.1%     751.96        sockperf.throughput.UDP.BandWidth_MBps
    670636           -20.1%     535658        sockperf.throughput.UDP.msg_per_sec
      6259 ±  3%     +44.0%       9013 ± 12%  sockperf.time.involuntary_context_switches
     66.00            -3.0%      64.00        sockperf.time.percent_of_cpu_this_job_got
 7.698e+08            +3.3%  7.955e+08        perf-stat.i.branch-instructions
    208310            +4.0%     216675        perf-stat.i.context-switches
    298.79            +6.0%     316.62        perf-stat.i.cpu-migrations
  3.92e+09            +4.1%  4.081e+09        perf-stat.i.instructions
      0.79            +3.9%       0.83        perf-stat.i.ipc
      0.68 ±  3%      +7.5%       0.73        perf-stat.i.metric.K/sec
      0.11            -4.4%       0.10 ±  2%  perf-stat.overall.MPKI
      1.19            -3.7%       1.14        perf-stat.overall.cpi
      0.84            +3.8%       0.87        perf-stat.overall.ipc
 7.681e+08            +3.3%  7.937e+08        perf-stat.ps.branch-instructions
    207867            +4.0%     216199        perf-stat.ps.context-switches
    298.39            +6.0%     316.29        perf-stat.ps.cpu-migrations
 3.911e+09            +4.1%  4.072e+09        perf-stat.ps.instructions
 2.419e+12            +4.1%  2.519e+12        perf-stat.total.instructions
      1.51 ±  5%      -0.5        1.06 ± 26%  perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output.ip_send_skb
      1.46 ±  5%      -0.4        1.03 ± 26%  perf-profile.calltrace.cycles-pp.xmit_one.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output
      1.26 ±  7%      -0.4        0.88 ± 28%  perf-profile.calltrace.cycles-pp.loopback_xmit.xmit_one.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2
      6.40 ±  4%      -0.3        6.06 ±  2%  perf-profile.calltrace.cycles-pp.udpv6_recvmsg.inet6_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      6.42 ±  4%      -0.3        6.09 ±  2%  perf-profile.calltrace.cycles-pp.inet6_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
      1.06 ± 17%      -0.3        0.75 ± 31%  perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg
      2.37 ±  6%      -0.3        2.06 ±  3%  perf-profile.calltrace.cycles-pp.ip_make_skb.udp_sendmsg.udpv6_sendmsg.__sys_sendto.__x64_sys_sendto
      2.54 ±  9%      -0.3        2.25 ±  4%  perf-profile.calltrace.cycles-pp.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udpv6_recvmsg.inet6_recvmsg
      0.69 ±  2%      -0.1        0.63 ±  5%  perf-profile.calltrace.cycles-pp.__wrgsbase_inactive
      6.90 ±  4%      +0.8        7.66 ±  3%  perf-profile.calltrace.cycles-pp.udp_send_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      9.88 ±  2%      +0.8       10.64 ±  4%  perf-profile.calltrace.cycles-pp.udp_sendmsg.udpv6_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      9.94 ±  2%      +0.8       10.72 ±  4%  perf-profile.calltrace.cycles-pp.udpv6_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.77 ±  4%      +0.8        7.58 ±  3%  perf-profile.calltrace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto
      6.65 ±  4%      +0.8        7.49 ±  3%  perf-profile.calltrace.cycles-pp.ip_output.ip_send_skb.udp_send_skb.udp_sendmsg.__sys_sendto
      6.77 ±  2%      +1.0        7.77 ±  5%  perf-profile.calltrace.cycles-pp.udp_send_skb.udp_sendmsg.udpv6_sendmsg.__sys_sendto.__x64_sys_sendto
      6.68 ±  2%      +1.0        7.69 ±  5%  perf-profile.calltrace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.udpv6_sendmsg.__sys_sendto
      6.58 ±  2%      +1.0        7.59 ±  5%  perf-profile.calltrace.cycles-pp.ip_output.ip_send_skb.udp_send_skb.udp_sendmsg.udpv6_sendmsg
     20.94            +1.3       22.20 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.92            +1.3       22.19 ±  3%  perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.07 ±  2%      +1.9       14.99 ±  4%  perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.ip_send_skb.udp_send_skb.udp_sendmsg
     12.72 ±  2%      +2.0       14.69 ±  4%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_output.ip_send_skb.udp_send_skb
     10.50 ±  2%      +2.3       12.85 ±  4%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_output.ip_send_skb
     10.39 ±  2%      +2.4       12.76 ±  4%  perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_output
     10.29 ±  2%      +2.4       12.70 ±  4%  perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
      9.77 ±  2%      +2.5       12.22 ±  4%  perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      0.00            +4.1        4.08 ±  5%  perf-profile.calltrace.cycles-pp.skb_defer_free_flush.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
      4.79 ±  3%      -0.5        4.24 ±  5%  perf-profile.children.cycles-pp.ip_make_skb
      6.40 ±  4%      -0.3        6.06 ±  2%  perf-profile.children.cycles-pp.udpv6_recvmsg
      6.43 ±  4%      -0.3        6.09 ±  2%  perf-profile.children.cycles-pp.inet6_recvmsg
      1.51 ±  5%      -0.3        1.22 ±  7%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      1.46 ±  5%      -0.3        1.18 ±  7%  perf-profile.children.cycles-pp.xmit_one
      0.95 ±  6%      -0.2        0.77 ± 11%  perf-profile.children.cycles-pp.sock_wfree
      3.02 ±  2%      -0.2        2.85 ±  2%  perf-profile.children.cycles-pp.__ip_append_data
      1.26 ±  7%      -0.2        1.11 ±  7%  perf-profile.children.cycles-pp.loopback_xmit
      0.20 ± 11%      -0.1        0.10 ± 11%  perf-profile.children.cycles-pp.__enqueue_entity
      0.52 ±  3%      -0.1        0.43 ± 11%  perf-profile.children.cycles-pp.arch_exit_to_user_mode_prepare
      0.22 ±  7%      -0.1        0.12 ± 21%  perf-profile.children.cycles-pp.switch_fpu_return
      0.22 ± 12%      -0.1        0.13 ± 12%  perf-profile.children.cycles-pp.ip_setup_cork
      0.09 ± 11%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.75 ±  2%      -0.1        0.69 ±  4%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.26 ± 13%      -0.1        0.20 ± 17%  perf-profile.children.cycles-pp.udp4_lib_lookup2
      0.08 ± 20%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.__ip_finish_output
      0.25 ± 11%      -0.0        0.20 ± 15%  perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.17 ± 13%      -0.0        0.13 ±  9%  perf-profile.children.cycles-pp.ipv4_mtu
      0.21 ± 11%      -0.0        0.16 ± 10%  perf-profile.children.cycles-pp.__mkroute_output
      0.09 ± 15%      -0.0        0.05 ± 52%  perf-profile.children.cycles-pp.vruntime_eligible
      0.10 ±  9%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.update_min_vruntime
      0.16 ± 12%      +0.0        0.20 ±  8%  perf-profile.children.cycles-pp.wakeup_preempt
      0.01 ±223%      +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.tick_nohz_get_next_hrtimer
      9.94 ±  2%      +0.8       10.72 ±  4%  perf-profile.children.cycles-pp.udpv6_sendmsg
      0.10 ± 11%      +0.9        1.01 ±  6%  perf-profile.children.cycles-pp._find_next_bit
     20.93            +1.3       22.20 ±  3%  perf-profile.children.cycles-pp.__sys_sendto
     20.94            +1.3       22.21 ±  3%  perf-profile.children.cycles-pp.__x64_sys_sendto
     19.98            +1.3       21.26 ±  4%  perf-profile.children.cycles-pp.udp_sendmsg
     13.68            +1.7       15.42 ±  4%  perf-profile.children.cycles-pp.udp_send_skb
     13.46 ±  2%      +1.8       15.28 ±  4%  perf-profile.children.cycles-pp.ip_send_skb
     13.28 ±  2%      +1.8       15.13 ±  4%  perf-profile.children.cycles-pp.ip_output
     13.13 ±  2%      +1.9       15.04 ±  4%  perf-profile.children.cycles-pp.ip_finish_output2
     12.78 ±  2%      +2.0       14.74 ±  4%  perf-profile.children.cycles-pp.__dev_queue_xmit
     10.71 ±  3%      +2.3       13.04 ±  4%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      9.84 ±  3%      +2.4       12.28 ±  4%  perf-profile.children.cycles-pp.net_rx_action
     13.63            +2.5       16.11 ±  3%  perf-profile.children.cycles-pp.do_softirq
     14.05            +2.5       16.57 ±  3%  perf-profile.children.cycles-pp.handle_softirqs
      0.00            +4.1        4.09 ±  5%  perf-profile.children.cycles-pp.skb_defer_free_flush
      0.98 ± 13%      -0.9        0.08 ± 14%  perf-profile.self.cycles-pp.net_rx_action
      0.94 ±  7%      -0.2        0.76 ± 12%  perf-profile.self.cycles-pp.sock_wfree
      0.20 ± 16%      -0.1        0.06 ± 46%  perf-profile.self.cycles-pp.xmit_one
      0.70 ± 10%      -0.1        0.58 ±  5%  perf-profile.self.cycles-pp.menu_select
      0.20 ±  6%      -0.1        0.11 ± 20%  perf-profile.self.cycles-pp.switch_fpu_return
      0.18 ±  9%      -0.1        0.10 ± 12%  perf-profile.self.cycles-pp.__enqueue_entity
      0.70 ±  9%      -0.1        0.62 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.43 ± 10%      -0.1        0.36 ±  7%  perf-profile.self.cycles-pp.__ip_append_data
      0.30 ± 11%      -0.1        0.22 ±  8%  perf-profile.self.cycles-pp.dequeue_entity
      0.35 ± 10%      -0.1        0.28 ± 11%  perf-profile.self.cycles-pp.sched_balance_newidle
      0.13 ±  5%      -0.1        0.06 ± 48%  perf-profile.self.cycles-pp.__udp4_lib_rcv
      0.41 ±  8%      -0.1        0.35 ±  9%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.29 ± 15%      -0.1        0.22 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.71            -0.1        0.65 ±  4%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.21 ± 13%      -0.1        0.15 ± 15%  perf-profile.self.cycles-pp.handle_softirqs
      0.84 ±  2%      -0.0        0.79 ±  2%  perf-profile.self.cycles-pp.__switch_to
      0.25 ± 11%      -0.0        0.20 ± 15%  perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.18 ± 21%      -0.0        0.13 ± 10%  perf-profile.self.cycles-pp.udp_send_skb
      0.09 ± 12%      -0.0        0.04 ± 75%  perf-profile.self.cycles-pp.vruntime_eligible
      0.16 ± 14%      -0.0        0.12 ± 10%  perf-profile.self.cycles-pp.ipv4_mtu
      0.07 ± 24%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.sock_recvmsg
      0.24 ± 11%      +0.1        0.29 ±  3%  perf-profile.self.cycles-pp.udp_sendmsg
      0.08 ± 16%      +0.1        0.15 ±  9%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.01 ±223%      +0.1        0.10 ± 15%  perf-profile.self.cycles-pp.tick_nohz_get_next_hrtimer
      0.10 ± 15%      +0.9        0.98 ±  6%  perf-profile.self.cycles-pp._find_next_bit
      0.00            +2.9        2.88 ±  7%  perf-profile.self.cycles-pp.skb_defer_free_flush


***************************************************************************************************
lkp-srf-2sp1: 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Forest) with 128G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-14/performance/ipv4/x86_64-rhel-9.4/1/debian-13-x86_64-20250902.cgz/300s/lkp-srf-2sp1/UDP_STREAM/netperf

commit: 
  844c9db7f7 ("net: use llist for sd->defer_list")
  5628f3fe3b ("net: add NUMA awareness to skb_attempt_defer_free()")

844c9db7f7f5fe1b 5628f3fe3b16114e8424bbfcf05 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  20600541 ±  3%     +14.1%   23500650 ±  2%  cpuidle..usage
    214491 ±  5%     +11.5%     239155 ±  2%  meminfo.Shmem
      0.11            +0.0        0.13 ±  2%  mpstat.cpu.all.soft%
    107642 ±  4%     +17.1%     126046 ±  3%  vmstat.system.cs
      0.04 ±  8%      +0.0        0.07        turbostat.C1%
      0.46            +9.8%       0.50        turbostat.IPC
      4284 ± 13%     +28.8%       5519 ± 10%  numa-meminfo.node0.PageTables
      5684 ± 10%     -21.7%       4451 ± 11%  numa-meminfo.node1.PageTables
    208697 ±  5%     +11.0%     231719 ±  2%  numa-meminfo.node1.Shmem
      1073 ± 13%     +28.9%       1383 ±  9%  numa-vmstat.node0.nr_page_table_pages
      1423 ± 10%     -21.7%       1114 ± 11%  numa-vmstat.node1.nr_page_table_pages
     52145 ±  5%     +11.0%      57900 ±  2%  numa-vmstat.node1.nr_shmem
     12387 ±  4%     -12.9%      10792 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.avg
     12387 ±  4%     -12.9%      10792 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
     64470 ±  3%     +16.0%      74816 ±  3%  sched_debug.cpu.nr_switches.avg
      8.08 ±  5%     -12.6%       7.07 ±  3%  perf-sched.total_wait_and_delay.average.ms
    197564 ±  5%     +13.5%     224145 ±  2%  perf-sched.total_wait_and_delay.count.ms
      8.08 ±  5%     -12.6%       7.06 ±  3%  perf-sched.total_wait_time.average.ms
      8.08 ±  5%     -12.6%       7.07 ±  3%  perf-sched.wait_and_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
    197564 ±  5%     +13.5%     224145 ±  2%  perf-sched.wait_and_delay.count.[unknown].[unknown].[unknown].[unknown].[unknown]
      8.08 ±  5%     -12.6%       7.06 ±  3%  perf-sched.wait_time.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
    224037            +3.1%     230892        proc-vmstat.nr_active_anon
     53676 ±  4%     +11.5%      59861 ±  2%  proc-vmstat.nr_shmem
    224037            +3.1%     230892        proc-vmstat.nr_zone_active_anon
 1.129e+08            -5.9%  1.063e+08        proc-vmstat.numa_hit
 1.127e+08            -5.9%   1.06e+08        proc-vmstat.numa_local
 8.928e+08            -6.0%  8.394e+08        proc-vmstat.pgalloc_normal
 8.927e+08            -6.0%  8.393e+08        proc-vmstat.pgfree
    194605            -6.0%     182934        netperf.ThroughputBoth_Mbps
    194605            -6.0%     182934        netperf.ThroughputBoth_total_Mbps
     97220            -6.0%      91387        netperf.ThroughputRecv_Mbps
     97220            -6.0%      91387        netperf.ThroughputRecv_total_Mbps
     97384            -6.0%      91547        netperf.Throughput_Mbps
     97384            -6.0%      91547        netperf.Throughput_total_Mbps
     78.67            -6.8%      73.33        netperf.time.percent_of_cpu_this_job_got
    232.75            -6.6%     217.32        netperf.time.system_time
 1.114e+08            -6.0%  1.047e+08        netperf.workload
 5.854e+08            +7.9%  6.313e+08        perf-stat.i.branch-instructions
      0.60            -0.0        0.57        perf-stat.i.branch-miss-rate%
   3570607            +2.7%    3668021        perf-stat.i.branch-misses
    108376 ±  4%     +17.1%     126925 ±  3%  perf-stat.i.context-switches
      2.29            -9.3%       2.08        perf-stat.i.cpi
 3.086e+09            +8.7%  3.353e+09        perf-stat.i.instructions
      0.44           +10.2%       0.49        perf-stat.i.ipc
      0.61            -0.0        0.58        perf-stat.overall.branch-miss-rate%
      2.24            -9.1%       2.04        perf-stat.overall.cpi
      0.45           +10.0%       0.49        perf-stat.overall.ipc
      8344           +15.6%       9643        perf-stat.overall.path-length
 5.833e+08            +7.9%  6.292e+08        perf-stat.ps.branch-instructions
   3558414            +2.8%    3656824        perf-stat.ps.branch-misses
    108014 ±  4%     +17.1%     126500 ±  3%  perf-stat.ps.context-switches
 3.075e+09            +8.7%  3.341e+09        perf-stat.ps.instructions
 9.295e+11            +8.6%   1.01e+12        perf-stat.total.instructions
     29.40            -1.8       27.59        perf-profile.calltrace.cycles-pp.ip_make_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     28.64            -1.8       26.86        perf-profile.calltrace.cycles-pp.__ip_append_data.ip_make_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto
     25.28            -1.7       23.60        perf-profile.calltrace.cycles-pp.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg.__sys_sendto
     25.91            -1.6       24.27        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg
     33.24            -1.6       31.66        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv_omni.process_requests
     33.22            -1.6       31.64        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv_omni
     31.95            -1.5       30.42        perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     33.73            -1.5       32.21        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv_omni.process_requests.spawn_child.accept_connection
     31.86            -1.5       30.35        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     33.68            -1.5       32.17        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv_omni.process_requests.spawn_child
     31.84            -1.5       30.33        perf-profile.calltrace.cycles-pp.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     24.73            -1.5       23.26        perf-profile.calltrace.cycles-pp._copy_from_iter.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg
     26.98            -1.5       25.52        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
     26.96            -1.5       25.50        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg.sock_recvmsg
     35.15            -1.4       33.74        perf-profile.calltrace.cycles-pp.recv_omni.process_requests.spawn_child.accept_connection.accept_connections
      0.66 ±  5%      -0.3        0.35 ± 71%  perf-profile.calltrace.cycles-pp.skb_attempt_defer_free.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      0.71 ±  5%      +0.2        0.91 ±  4%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      1.06 ±  9%      +0.2        1.26 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp
      1.09 ±  9%      +0.2        1.29 ±  6%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
      1.14 ±  8%      +0.2        1.35 ±  6%  perf-profile.calltrace.cycles-pp.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg.inet_recvmsg
      1.28 ±  7%      +0.3        1.56 ±  7%  perf-profile.calltrace.cycles-pp.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg.inet_recvmsg.sock_recvmsg
      0.98 ± 13%      +0.4        1.36 ±  8%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      1.36 ±  5%      +0.4        1.80 ±  4%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sock_def_readable
      1.36 ±  5%      +0.4        1.80 ±  4%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sock_def_readable.__udp_enqueue_schedule_skb
      0.17 ±141%      +0.5        0.64 ±  7%  perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      4.74 ±  3%      +0.5        5.22        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
      4.72 ±  3%      +0.5        5.21        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
      1.38 ±  8%      +0.5        1.88 ±  6%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.schedule_timeout
      4.49 ±  3%      +0.5        5.02        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
      3.89 ±  3%      +0.5        4.42        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.ip_local_deliver.__netif_receive_skb_one_core.process_backlog.__napi_poll
      1.73 ±  6%      +0.5        2.27 ±  4%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.sock_def_readable.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb
      3.88 ±  3%      +0.5        4.41        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.__netif_receive_skb_one_core.process_backlog
      3.90 ±  3%      +0.5        4.44        perf-profile.calltrace.cycles-pp.ip_local_deliver.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.try_to_block_task.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets
      3.82 ±  3%      +0.5        4.36        perf-profile.calltrace.cycles-pp.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.__netif_receive_skb_one_core
      3.39 ±  4%      +0.5        3.94 ±  2%  perf-profile.calltrace.cycles-pp.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      3.40 ±  4%      +0.6        3.95 ±  2%  perf-profile.calltrace.cycles-pp.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
      1.77 ±  6%      +0.6        2.33 ±  4%  perf-profile.calltrace.cycles-pp.__wake_up_sync_key.sock_def_readable.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      3.15 ±  4%      +0.6        3.74        perf-profile.calltrace.cycles-pp.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu
      0.00            +0.6        0.62 ±  3%  perf-profile.calltrace.cycles-pp._find_next_bit.skb_defer_free_flush.net_rx_action.handle_softirqs.do_softirq
      2.16 ±  5%      +0.6        2.80 ±  3%  perf-profile.calltrace.cycles-pp.sock_def_readable.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv
      0.00            +0.8        0.76 ±  3%  perf-profile.calltrace.cycles-pp.__free_frozen_pages.skb_release_data.napi_consume_skb.skb_defer_free_flush.net_rx_action
      6.82 ±  3%      +0.8        7.65 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +1.2        1.24 ±  4%  perf-profile.calltrace.cycles-pp.skb_release_data.napi_consume_skb.skb_defer_free_flush.net_rx_action.handle_softirqs
      0.00            +1.3        1.27 ±  4%  perf-profile.calltrace.cycles-pp.napi_consume_skb.skb_defer_free_flush.net_rx_action.handle_softirqs.do_softirq
     15.03 ±  2%      +1.4       16.40 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     15.04 ±  2%      +1.4       16.42 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     15.05 ±  2%      +1.4       16.42 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     10.13            +2.3       12.44        perf-profile.calltrace.cycles-pp.udp_send_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     10.02            +2.3       12.34        perf-profile.calltrace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto
      9.73            +2.3       12.07        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.ip_send_skb.udp_send_skb.udp_sendmsg
      9.79            +2.3       12.13        perf-profile.calltrace.cycles-pp.ip_output.ip_send_skb.udp_send_skb.udp_sendmsg.__sys_sendto
      9.39 ±  2%      +2.4       11.76        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_output.ip_send_skb.udp_send_skb
      8.41 ±  2%      +2.5       10.88        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_output
      8.36 ±  2%      +2.5       10.82        perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
      8.51 ±  2%      +2.5       10.98        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_output.ip_send_skb
      7.91 ±  2%      +2.5       10.45        perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      0.00            +5.1        5.13 ±  2%  perf-profile.calltrace.cycles-pp.skb_defer_free_flush.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
     29.41            -1.8       27.59        perf-profile.children.cycles-pp.ip_make_skb
     28.64            -1.8       26.87        perf-profile.children.cycles-pp.__ip_append_data
     25.28            -1.7       23.61        perf-profile.children.cycles-pp.ip_generic_getfrag
     25.95            -1.6       24.31        perf-profile.children.cycles-pp._copy_to_iter
     33.23            -1.6       31.65        perf-profile.children.cycles-pp.__sys_recvfrom
     33.24            -1.6       31.66        perf-profile.children.cycles-pp.__x64_sys_recvfrom
     31.95            -1.5       30.42        perf-profile.children.cycles-pp.sock_recvmsg
     31.86            -1.5       30.35        perf-profile.children.cycles-pp.inet_recvmsg
     31.84            -1.5       30.34        perf-profile.children.cycles-pp.udp_recvmsg
     24.78            -1.5       23.29        perf-profile.children.cycles-pp._copy_from_iter
     26.98            -1.5       25.52        perf-profile.children.cycles-pp.skb_copy_datagram_iter
     26.96            -1.5       25.51        perf-profile.children.cycles-pp.__skb_datagram_iter
     35.15            -1.4       33.74        perf-profile.children.cycles-pp.accept_connection
     35.15            -1.4       33.74        perf-profile.children.cycles-pp.accept_connections
     35.15            -1.4       33.74        perf-profile.children.cycles-pp.process_requests
     35.15            -1.4       33.74        perf-profile.children.cycles-pp.spawn_child
     35.15            -1.4       33.74        perf-profile.children.cycles-pp.recv_omni
     76.98            -1.1       75.86        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     76.90            -1.1       75.78        perf-profile.children.cycles-pp.do_syscall_64
      0.65 ±  7%      -0.2        0.47 ±  6%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.66 ±  5%      -0.1        0.51 ±  8%  perf-profile.children.cycles-pp.skb_attempt_defer_free
      0.94 ±  6%      -0.1        0.81 ±  3%  perf-profile.children.cycles-pp.__check_object_size
      0.78 ±  6%      -0.1        0.66 ±  4%  perf-profile.children.cycles-pp.check_heap_object
      0.44 ±  3%      -0.1        0.38 ±  6%  perf-profile.children.cycles-pp.sched_clock
      0.47 ±  3%      -0.1        0.41 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.32 ±  8%      -0.0        0.27 ±  3%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.20 ± 13%      -0.0        0.16 ±  7%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.06 ±  7%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.udp4_csum_init
      0.07 ± 14%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.prepare_to_wait_exclusive
      0.08 ± 17%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.update_cfs_group
      0.23 ±  7%      +0.0        0.27 ±  8%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.09 ± 19%      +0.0        0.13 ± 14%  perf-profile.children.cycles-pp.available_idle_cpu
      0.37 ±  6%      +0.0        0.41 ±  6%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.30 ±  8%      +0.0        0.34 ±  7%  perf-profile.children.cycles-pp.enqueue_entity
      0.39 ±  7%      +0.0        0.44 ±  5%  perf-profile.children.cycles-pp.enqueue_task
      0.26 ±  8%      +0.1        0.31 ±  5%  perf-profile.children.cycles-pp.update_curr
      0.32 ±  6%      +0.1        0.38 ±  8%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.37 ±  4%      +0.1        0.42 ±  6%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.34 ±  6%      +0.1        0.41 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.27 ±  9%      +0.1        0.35 ±  4%  perf-profile.children.cycles-pp.cpus_share_cache
      0.47 ±  6%      +0.1        0.56 ±  3%  perf-profile.children.cycles-pp.dequeue_entities
      0.42 ±  5%      +0.1        0.51 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      0.48 ±  6%      +0.1        0.57 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.48 ±  5%      +0.1        0.57 ±  2%  perf-profile.children.cycles-pp.try_to_block_task
      0.43 ±  4%      +0.1        0.53 ±  6%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.39 ±  3%      +0.1        0.49 ±  3%  perf-profile.children.cycles-pp.os_xsave
      0.46 ±  4%      +0.1        0.58 ±  6%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.48 ±  8%      +0.1        0.60 ±  7%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.37 ±  9%      +0.1        0.48 ±  5%  perf-profile.children.cycles-pp.select_idle_sibling
      0.43 ±  8%      +0.1        0.58 ±  2%  perf-profile.children.cycles-pp.select_task_rq
      0.50 ±  3%      +0.2        0.66 ±  6%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      1.58 ±  6%      +0.2        1.77 ±  4%  perf-profile.children.cycles-pp.schedule
      0.73 ±  5%      +0.2        0.92 ±  4%  perf-profile.children.cycles-pp.sched_ttwu_pending
      1.18 ±  8%      +0.2        1.39 ±  6%  perf-profile.children.cycles-pp.schedule_timeout
      1.28 ±  7%      +0.3        1.56 ±  7%  perf-profile.children.cycles-pp.__skb_wait_for_more_packets
      2.25 ±  7%      +0.4        2.60 ±  4%  perf-profile.children.cycles-pp.__schedule
      1.04 ± 12%      +0.4        1.43 ±  8%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      1.38 ±  5%      +0.4        1.81 ±  4%  perf-profile.children.cycles-pp.autoremove_wake_function
      1.42 ±  5%      +0.4        1.86 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
      4.72 ±  3%      +0.5        5.21        perf-profile.children.cycles-pp.process_backlog
      4.74 ±  3%      +0.5        5.22        perf-profile.children.cycles-pp.__napi_poll
      1.76 ±  6%      +0.5        2.28 ±  4%  perf-profile.children.cycles-pp.__wake_up_common
      4.49 ±  3%      +0.5        5.02        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      3.89 ±  3%      +0.5        4.42        perf-profile.children.cycles-pp.ip_local_deliver_finish
      3.90 ±  3%      +0.5        4.44        perf-profile.children.cycles-pp.ip_local_deliver
      3.88 ±  3%      +0.5        4.41        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
      3.82 ±  3%      +0.5        4.37        perf-profile.children.cycles-pp.__udp4_lib_rcv
      3.40 ±  4%      +0.5        3.95 ±  2%  perf-profile.children.cycles-pp.udp_unicast_rcv_skb
      1.79 ±  6%      +0.6        2.34 ±  4%  perf-profile.children.cycles-pp.__wake_up_sync_key
      3.39 ±  4%      +0.6        3.94 ±  2%  perf-profile.children.cycles-pp.udp_queue_rcv_one_skb
      3.16 ±  4%      +0.6        3.75        perf-profile.children.cycles-pp.__udp_enqueue_schedule_skb
      0.14 ± 17%      +0.6        0.77 ±  6%  perf-profile.children.cycles-pp._find_next_bit
      2.17 ±  5%      +0.6        2.82 ±  3%  perf-profile.children.cycles-pp.sock_def_readable
      7.10 ±  3%      +0.8        7.90 ±  2%  perf-profile.children.cycles-pp.intel_idle
     15.05 ±  2%      +1.4       16.42 ±  2%  perf-profile.children.cycles-pp.start_secondary
     12.18            +2.2       14.38        perf-profile.children.cycles-pp.handle_softirqs
     11.50            +2.3       13.75        perf-profile.children.cycles-pp.do_softirq
     10.13            +2.3       12.44        perf-profile.children.cycles-pp.udp_send_skb
     10.02            +2.3       12.34        perf-profile.children.cycles-pp.ip_send_skb
      9.73            +2.3       12.07        perf-profile.children.cycles-pp.ip_finish_output2
      9.79            +2.3       12.13        perf-profile.children.cycles-pp.ip_output
      9.40 ±  2%      +2.4       11.76        perf-profile.children.cycles-pp.__dev_queue_xmit
      8.60 ±  2%      +2.5       11.07        perf-profile.children.cycles-pp.__local_bh_enable_ip
      7.91 ±  2%      +2.6       10.47        perf-profile.children.cycles-pp.net_rx_action
      0.00            +5.1        5.14 ±  2%  perf-profile.children.cycles-pp.skb_defer_free_flush
     25.81            -1.7       24.15        perf-profile.self.cycles-pp._copy_to_iter
      1.73 ±  4%      -1.6        0.10 ± 12%  perf-profile.self.cycles-pp.net_rx_action
     24.62            -1.5       23.14        perf-profile.self.cycles-pp._copy_from_iter
      0.64 ±  7%      -0.2        0.47 ±  7%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.66 ±  5%      -0.1        0.51 ±  7%  perf-profile.self.cycles-pp.skb_attempt_defer_free
      0.23 ±  8%      -0.0        0.19 ± 11%  perf-profile.self.cycles-pp.skb_release_data
      0.16 ± 11%      -0.0        0.13 ± 11%  perf-profile.self.cycles-pp.handle_softirqs
      0.15 ±  7%      -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.__sys_sendto
      0.05 ±  8%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.06 ±  7%      +0.0        0.08 ± 14%  perf-profile.self.cycles-pp.udp4_csum_init
      0.08 ± 17%      +0.0        0.11 ± 10%  perf-profile.self.cycles-pp.update_cfs_group
      0.09 ± 17%      +0.0        0.13 ± 14%  perf-profile.self.cycles-pp.available_idle_cpu
      0.31 ±  6%      +0.0        0.36 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.12 ± 14%      +0.1        0.17 ± 11%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.06 ± 19%  perf-profile.self.cycles-pp.__skb_wait_for_more_packets
      0.02 ± 99%      +0.1        0.09 ± 26%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.27 ±  9%      +0.1        0.35 ±  4%  perf-profile.self.cycles-pp.cpus_share_cache
      0.38 ±  6%      +0.1        0.47 ± 10%  perf-profile.self.cycles-pp.sock_def_readable
      0.37 ± 11%      +0.1        0.46 ±  5%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.37 ±  9%      +0.1        0.47 ±  3%  perf-profile.self.cycles-pp.__wake_up_common
      0.43 ±  4%      +0.1        0.53 ±  6%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.39 ±  3%      +0.1        0.49 ±  3%  perf-profile.self.cycles-pp.os_xsave
      0.36 ±  5%      +0.1        0.46 ±  9%  perf-profile.self.cycles-pp.try_to_wake_up
      0.58 ±  6%      +0.1        0.71 ±  3%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.12 ± 11%      +0.6        0.74 ±  5%  perf-profile.self.cycles-pp._find_next_bit
      7.10 ±  3%      +0.8        7.90 ±  2%  perf-profile.self.cycles-pp.intel_idle
      0.00            +3.1        3.08 ±  4%  perf-profile.self.cycles-pp.skb_defer_free_flush





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


