Return-Path: <netdev+bounces-109249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D249927921
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607471C233BB
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE4B1AE873;
	Thu,  4 Jul 2024 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sa8tKhkF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A515491;
	Thu,  4 Jul 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104410; cv=fail; b=jkbnvytX8MVYbT478HhAMGkEhPDIf3ZliqaTF7enOPWZPIvTEYqJ2xnKdE5VQb52ZjVxJtD+qJpsgwWKlJZln8rHI6StQ+1rjQy/4TE+V4CqCSouybcVhrl08dZc2NhW766+FHECGKT4V5OEiWHQBpBoBuHOO5wkOFm/gp16YSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104410; c=relaxed/simple;
	bh=LYZTqLvMgCJca2MGpI5opZrpOO5vR+Mv+vGuFFw8sSA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FTKg+vHHtPSKjGGfc7Z6AKkGsT+vGQv0zkGctNkjgkFl56kfqhfrkskpUxphoIGuR9IZGl/6Ew+DXoCUYnpkVCkPWFnBTudZRrUnLMV91bL4An+3Jurv3sQh7x1qz2QszOvk39oblZ273lBOeSY1P6+ea/LHSXOVmEDFDETgUaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sa8tKhkF; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720104409; x=1751640409;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LYZTqLvMgCJca2MGpI5opZrpOO5vR+Mv+vGuFFw8sSA=;
  b=Sa8tKhkFH/8b44Cp1YPkgTv52FPIv3tCrkZGpfQ+eQP9kQRJKVdudSsD
   pT308UYwQyaTjrVIAHz3kDFtxSSv3FJZ1yGDr1iJe3zTFPBMJlII5hhtJ
   Yut8upLMXDGninruIvUzMMacbvXKEV0Me8C9eqna2HyuneXujgY7KWMmU
   26/nT1+qrdOmjL/XqSKeMWx1eYOSjOjxELyJ6XlDmRoG2OXvVhGUl6WDN
   Yof4aULXmyofpvoRv7ZiFQDe2JAaf6jp+Dr0eDNiMpQFuoouqC+LU09pc
   rJDrZKxZ3MUxK/0A+k8firnjeKQ/nF1gFWWI+xwky/gblC5BHl7m1yMBR
   Q==;
X-CSE-ConnectionGUID: GBRa1VZdSKyMjDRGoS6z8g==
X-CSE-MsgGUID: VWILOUZbRZmtqqWJ6CN69w==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17206236"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17206236"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 07:46:49 -0700
X-CSE-ConnectionGUID: k6OkOf8xSf+xLZ9qEcqNgA==
X-CSE-MsgGUID: bzohcxmuSperw//3g/fJLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46697492"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 07:46:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 07:46:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 07:46:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 07:46:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 07:46:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9/VzBdhXL7MNG3+rKeQJkgLXsBg/AjigbOQ5/cRQWQm9/AuoHeIaxqdEwpUyaQQuImEYNZW0e/NGbpxrg6n3EKdI5IgNN5BCTcyez1BHzpU4F8cA4E1VO4bq578FP4JzDBjwZq4Qhcv+8oTwjwO9/KI5ENTiGldxIXmjnEScu6j8Uo93m719HQPCnmo1v/pfQGQKC682jlMyEXkKwW1e0l0gTc0ae9b6kwKqefPi7he9n3tiKq3qh3MVlX+YnzZmBeYk6ZUcwRcIen7QuKd2SLXjDrmXcZViqbHgrH3LxmPdPsiUrk1iA8yN48ZGgSNBS6w9ogBCCm21Jv2fUEEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC7BQXY2Fz7vErFL54K0iUzPQk0yodMub5GreBmh5tU=;
 b=JgJIUkhHnsUKXJ3d0sz0zXPOrdkfMRXjmbRK4ozqpDIbSD2blQASTqdYp3EEUgNACIuK51cUXtYE0ZyKB4Z8+3s35m96O9g/vWsispIBnKiAe3AxqRzOc4UTwdMtIWQr+YecEuqSF72u7cmLQqobTlelPnjKfD/SFjmo8wQeEgd+I8eZ84pp7B7t6pPrR9anqyKBLL7YnuCCMvUSZoziLv0cVkGhsJXFtzV1GX55cZOhDSwUIbTDk9Ze1rhhmEZCTUqJTD7eu9zjIUGVj+4zqsVJGIVNsrYu7AZBWLdLGuu1S6hNzk9c//7yyOcIWJqw2/9BjdrngFM9rOZuyn0VLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by CH3PR11MB7819.namprd11.prod.outlook.com (2603:10b6:610:125::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 14:46:44 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 14:46:44 +0000
Date: Thu, 4 Jul 2024 16:46:35 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Chengen Du <chengen.du@canonical.com>, <jhs@mojatatu.com>,
	<xiyou.wangcong@gmail.com>, <jiri@resnulli.us>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <ozsh@nvidia.com>,
	<paulb@nvidia.com>, <marcelo.leitner@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gerald Yang <gerald.yang@canonical.com>
Subject: Re: [PATCH] net/sched: Fix UAF when resolving a clash
Message-ID: <Zoa1yzXtP/KvFLkk@localhost.localdomain>
References: <20240704093458.39198-1-chengen.du@canonical.com>
 <ZoaAH/R8NM1rtYFt@localhost.localdomain>
 <20240704073059.2e797f2d@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240704073059.2e797f2d@kernel.org>
X-ClientProxiedBy: MI1P293CA0009.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::6)
 To PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|CH3PR11MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1d928a-ba47-45cb-cfd7-08dc9c381fcf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zzZrWDtaWGkbuMddHmJ5BNEJf3fmQL1ZekKhFSAAxaoAep6OS13LPygYu/b7?=
 =?us-ascii?Q?639nk6Fe2JEeu/ZmrjTA5kkHzpABdQKjqvcdkpaWLmGtC6DN1DF5CqqSaM4f?=
 =?us-ascii?Q?k+eMhfe3hPo2TKxueEvC+NwHDwRVqjGbvaPuK3CbzAbpXBlH9Dt2PI5Gvvt7?=
 =?us-ascii?Q?I+KTHx8/38+/1ce6Gz3IN8dE36+43wAIiy7qSTqM7yYqbnBvXfPcvVzPswSj?=
 =?us-ascii?Q?8JwEe6K39/SuvO3330N2NDxCJrElmcmSue/64i22Fv1XfOQIKXiDu1NpJqfQ?=
 =?us-ascii?Q?4ayVlw9G7uMJeauuusvfAXLyIgAi41pMxeqHyBbv6gTw5SQCtYCoq91H3oQh?=
 =?us-ascii?Q?dAM3WHtdCUt7xTlCetzcbdjYyQY0GYZbsB9vazW7N9MCLWu4Wn7n1Lj0Ptmt?=
 =?us-ascii?Q?X1m3eT0Ua8d3T9hSnpi1XGrpbGtd9+5cJ/JPhPh8a3sf0ZsKSqJjnOvCck11?=
 =?us-ascii?Q?+ML/xFjmyRQKqeIAkOhbx8Ka/Yizy0EJ0zaV8tZcrp57zxXY9u5B0mYTHv1u?=
 =?us-ascii?Q?En1DCumyFA3tOietaRUS4Lr2YmhTi2OPnYJ5/o8ZuBujt5OKJkIYzuQchYAu?=
 =?us-ascii?Q?QCj+2CuLWxTVgtGRNlKTkvUtwCoP+mrdBUtVjh6zAR2tEzEcwMyickjIQis0?=
 =?us-ascii?Q?gdWs8owuNZpOaYP4B5znzndBJBkAhBB3UaUW93qFalzgSv7Sk1uK30vecgid?=
 =?us-ascii?Q?EwCfTxPlTLxR5S54WNJLS2/MCb6UeabsdTPemTLytLXd9I9v9av2mOkoBg8a?=
 =?us-ascii?Q?PMWE5ZgZmmmtw6OZ15Jqu4yDnSOABwuGl93EPOq7S/nelZgbhHjpvrXhexW7?=
 =?us-ascii?Q?vWT/OPviJ6tLaU6sBenhApWNLUm1lbY9pagX0FlgcBErZeS5Ni3HcHChbO1F?=
 =?us-ascii?Q?dSAoNLVg/F9BNF+c8p5YzQzNHNf5m8yGzSdkxQebP+RoN9ixTlGCKEnb0JSv?=
 =?us-ascii?Q?QYqHaqKgsCoOhaFBMNYkiLCzJbsBb6KuVC3tutoXzpie0fg7HJgtfeh5gUp3?=
 =?us-ascii?Q?b7u8/rtBIPDiyRGcA0/hNaMIhQwZJCacTYQQBus8khvlbkNSnzIT3i/3GEY7?=
 =?us-ascii?Q?03FCO9A8QkEy710DiwEVVbPjQzoTy35lMAi3mnUPNhtODPfGMjdqJo5RA04Y?=
 =?us-ascii?Q?HsNttYQSzG+TSppbTgJWauVEaGwIlXOcZxHXS/DuWOVaTSQNAew7vvMWkUqn?=
 =?us-ascii?Q?zoIBrvVmvxbGWrS1y9jaAUFRocuM65domyzyTvu4axyEo2UQruwHB3U3iTo6?=
 =?us-ascii?Q?2hf/LxHzpB7Boix6S7Th4MqWZ73Jdj6vF4j+MJCsK/SAZ6nnNwSLvJMxeLP8?=
 =?us-ascii?Q?cHCPuC0NS0Gq9/f7swgmiHOgar7NmEXGRZ6WxQlHNmHLIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bybjyHuMmHyEIfzisALdhH9woVNV4Gal0RXLsZhdaQXDhHHOir67I2EBPKzi?=
 =?us-ascii?Q?LLKQqU3WWMSpHIZs73LwaShnbPmsXeOF2i1WN4aumBThM++HWU5yON6vPwfo?=
 =?us-ascii?Q?RYxnew28/dtDridOl2J+9WTH9due2tvDAOms+7vYbB+vdPF2z+P+t1+jYA6q?=
 =?us-ascii?Q?UTPV/fFLwJLZpOf9oWVB03PvXZ+oeQmM7l7bOu2w5IVSE9KCWppkT4Rbl1+y?=
 =?us-ascii?Q?53qV58YV0Y+jVT/zsOlvwlzI9WIMWF+a8DranmyIIl5MefjjsyyVSFmxJo8x?=
 =?us-ascii?Q?y3VT5l1IoUSRRZd28RETBJoifcyWy9UQ372RgBMeyZmZZnrwSgKqGnM6URbt?=
 =?us-ascii?Q?cq5O4sQ9UJWjsmGG8cwluCYgqsOZSMVs39guvESeRMTnLgW9oCtH/52HdLvk?=
 =?us-ascii?Q?mYrawHf8E72tYaiIDBL6NSdVXhHdSs++Aphgai6tXsRbrP3DeOJtHL29SVab?=
 =?us-ascii?Q?Zw1cL0GS5QrvB0k3eFs6LUKrVi07jkdc7c/NHcaFfcNs2yF124BiNSkGwVAN?=
 =?us-ascii?Q?4rQK2yc+MWT1zIVlHthjS95XRY2xO/XPIghI4uP2FolltGB3bxNosamQV6Kg?=
 =?us-ascii?Q?HBACyLtWBzCGtt9anwGdPDtS2G8NAbEsLdHOx8cudRrA0RZgvdrJMOumaonl?=
 =?us-ascii?Q?oKZp3LKD/BmXUIjWgRoMAmpcmzDuNaokUGIKRL4AXK0S2hQ3ZzbJqyof5+eg?=
 =?us-ascii?Q?wde4LE2CMyf79Cc1DXZaj2GJsdJavlt4bXpQIVv2zzuA923Z1UWGFTQrBFzJ?=
 =?us-ascii?Q?X33PS1OdmiUBBrJZxS2BUs9oxLfnBtjKUrHeMDMwPnfZRaHonAuAI7K5FF0I?=
 =?us-ascii?Q?xJwhAgbzxn4hL+1otbuNSD4smRIVqF6D8Th+Hs8kbnuAxbLJe0GHi6e9OejR?=
 =?us-ascii?Q?iqUaIQpg9S+wy22aQrRwCg7BNoXmfmZ6gYWk55okrnsNEWEn1asJ2VWDoc9f?=
 =?us-ascii?Q?oWGaBJYe7rbGPTv6x1srwO9xYeJ05awpfCYiK0dzXYaeQ8L80XLJTOBS9XvV?=
 =?us-ascii?Q?zTEqtN//xR64lV26BltjA6K361lC0N6BWOTrzH35fT2StZUrQiT2LJZMXdfK?=
 =?us-ascii?Q?zZI7dx6sAa0SJKWcdYTmxIIiLxZsC7zplY3VTBP0AuRuc3rBahJZ9AbA9Uzn?=
 =?us-ascii?Q?24k9PU+mMaA0Sp2tICOG01b98wKyiZpHFvt3PBZUGo3aocsjTh0lFwzv1Zvs?=
 =?us-ascii?Q?EbIr0sgXVRKRl47OCH0lmbMzkwOYgRmngBTbWVCgaBAlF1T3ClPtA7z8LxZg?=
 =?us-ascii?Q?h6KlU7hTvJC+RcbcpD1kQ5988hmCvJGOYiNlOGWnz4WxlfR5gvIafKgXhl10?=
 =?us-ascii?Q?Xrk/6NEXEmIYIv4nEFCgI8RVdArSMC2AF8xvkWgtSZi1JJJz57IHzzjnK1x+?=
 =?us-ascii?Q?95sng21aTnzD81pITKpY0CJQxQO+8g6yku7LEeRd3TvZTIIhUuXrQM/KzByF?=
 =?us-ascii?Q?ll7BionLbG29SOPXpEvq6Jo/2vcVVuYmLHaQ9OELRd0AEiqEQQyH6yLLvf27?=
 =?us-ascii?Q?CW6vRCpxlmJI9g/Yj+xSj3JnG6MLnccBgkhPw0JJ7aEZaV33IkDaP+EyyBo8?=
 =?us-ascii?Q?0cK3rS6UHh+QqFhE7pCrgCpL9HMJed4lGcD63lhh5RRaGyEQkOpn9w7DYalJ?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1d928a-ba47-45cb-cfd7-08dc9c381fcf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 14:46:44.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/4GjKlL+bdj87QhKHG7hOhNjRH0LuBr4UtDVimQxXa1Sj9yx72Fj7jx6Y8ZqM77TJ5QCo8HxEZHfIo+AfFH6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7819
X-OriginatorOrg: intel.com

On Thu, Jul 04, 2024 at 07:30:59AM -0700, Jakub Kicinski wrote:
> On Thu, 4 Jul 2024 12:57:35 +0200 Michal Kubiak wrote:
> > Please check the patchwork warning for details.
> 
> Please don't direct people to patchwork checks, it's not a public CI.

My apologies! I wasn't aware of this rule.

Michal

