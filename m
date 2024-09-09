Return-Path: <netdev+bounces-126713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811C5972470
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 23:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0080B1F244FD
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 21:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66DC189F2F;
	Mon,  9 Sep 2024 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I51/ahsD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D93178CC8;
	Mon,  9 Sep 2024 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916794; cv=fail; b=N1d3NiWknGfBsVFQdkrZJADt9odaEIt4cC0ZhsobzcqI00I7JlhYhqe+CceKngzCbSt9LrVoz9qTn4uxBva8xPoP9DGWzwtm6rifEh3VvmvxOyYjcriF523BnGsnKDx/RXRyDLGFC0slja8hx/GdVyGvPL+39xnxAcY7TwYM65g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916794; c=relaxed/simple;
	bh=zt3Gzti3KxTklJjMHVexeZgyhr17x114l3swpbpE0v0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=upmxsHTMTxxS87N/zHDfuUuKTBiqgUDp2clqd6B3Qo6LJOEVQcyyPe/IU7kfWhvksBfNiy7Yj7KKANKiVS3vP+MojRUUJOdeN6Y3pOWmQVljw9sxY49NuUc7AUU8zDxtTxaNKv1sv2RsOzHL93lx9R/6H2lRWptpM3Xta282Tfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I51/ahsD; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725916793; x=1757452793;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zt3Gzti3KxTklJjMHVexeZgyhr17x114l3swpbpE0v0=;
  b=I51/ahsDpVvzwwPDhpPMx77EChR18FzbNn99PWtuWBGxlhen1akmpdAB
   pZQLAiTW3tbXkcVmnvq0WEI+0kfyngcYViOW/QHwsgnA+MjYC0rf9mxgt
   hPR3tznmQlqWfJxyka6tgaZoVh0opPtMteAEjjxhAqqVlE17uGg+L6Q0k
   bD60xphs/SKThdQbSzcqVwVdvciKLtE20EM31Qo/RV0D3TLQlru/hJfzO
   Tcb4j0ySSqQlCofG+V/A/JhfJNQGyJTANUSfJLew1uIp5Ml4OCjNN+umS
   rhicnIkTfPCgoSLhhXEt0ah9I4uDWKrnxEYGGKgcvoPVT0401L98/XIdW
   g==;
X-CSE-ConnectionGUID: vQ6SpmqzTbu9asedZxu9Lw==
X-CSE-MsgGUID: 8lqruPaGRK2CWdbFSc9nQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="36018720"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="36018720"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 14:19:52 -0700
X-CSE-ConnectionGUID: OSwVO/jbRiyUMPAsSfuI+g==
X-CSE-MsgGUID: nuJ5k7znSyeGeDM1VlIooQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="90082924"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 14:19:51 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 14:19:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 14:19:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 14:19:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDLzz9KHGJhLfmid8uVeEc2xCG7KGePfnlhdOoZ8/IQ4HdSr2oLm9v55/GOIzcKUI493v/tIRp1WwuZ0a8qkuDV0JSrAUX7/vrmxpz5AQuFKE/uBEjb8Vi2Yex4clAD/CPj0jQEXgbtlkN9xOr35Wcv0X8xg0atz7i70o8keFORq5CSSl12mLu6Qqw5+ZrPV7OFojLKc+lJaQcxTQ3YNNc3Bx7NUcvkHp8CJBE+pdCg4m6EE6Hygu/JxEVLwC/8v4Fttnp2wTc41UlUvL11NLg7DttNFWcrtnQDC5p1jKyUxp+/4UgSWUIiudx1ftnTh68oU3+dPydyr5G4CNdsGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSwBnFLSRYtLqPa1A1DU/mmbTJUY+FPlofbAZ6Nktvs=;
 b=knVt+pXgBiC3GS6WGSP7frMIn7TYfrOzKOVlnbnBtgbbYa139dDqqNM4xcMJzdzn+8hZuiBuqq7jQ+CbyFvGNEFdtsnJyWnLzdTlDkwgDQ/E1ngEP9KNDIZTLqxjHOpmEavvDnK6yFknf0xQnd8MfeZ5B7AY8vn/rZo1PbztGkey1CDL1tL+8FUVmyzPhsCYITt1r5UApkbDZMnaloNRqzRHA7ARbIIAR/megSTb9mSpqED2JPJYJcO3axI6gaMc2FdslVkweMOOYPZ+GgFKbv1j7+WMSPRqtDyenvX7GgwxFT4WEDjxT4YWD7m8BuaviYzHa0cI8RKbaHmk8Z5FPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 21:19:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 21:19:47 +0000
Date: Mon, 9 Sep 2024 16:19:42 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Zijun Hu
	<zijun_hu@icloud.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Takashi Sakamoto
	<o-takashi@sakamocchi.jp>, Timur Tabi <timur@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v3 2/3] cxl/region: Find free cxl decoder by
 device_for_each_child()
Message-ID: <66df666ded3f7_3c80f229439@iweiny-mobl.notmuch>
References: <20240824-const_dfc_prepare-v3-0-32127ea32bba@quicinc.com>
 <20240824-const_dfc_prepare-v3-2-32127ea32bba@quicinc.com>
 <20240827123006.00004527@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240827123006.00004527@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0228.namprd04.prod.outlook.com
 (2603:10b6:303:87::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN6PR11MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 602a0445-3cd6-4041-943f-08dcd11521ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kSom1jz1WNOnj0ZQ23tn2/wvZFUU6FfzmqPtIejTysuKtrICtDKnP9Ye1ypM?=
 =?us-ascii?Q?6trTDYRP1UixgoZjCzQLff18E6/hfgj78HNI/pLOk8Mpd3erbanJjTnaZrJk?=
 =?us-ascii?Q?n7h5mk5H97I9SxE+95/wGivz4qQjz1vk2gblD8oDzMqO3aGmUoUtlLRjKIof?=
 =?us-ascii?Q?cnVzeEoyuh3QnoGhQe6Lmng17lMMVaq58iQzy1ZdgklC6KcaWbKrZ3qUI03G?=
 =?us-ascii?Q?YN+hNlXULaLnuvf4ZhppTRVnmHmkJO3Thp9LAPw5MvccmuN7/HtQnC4ln94p?=
 =?us-ascii?Q?/4YVRqCBdRfefOZTecz5f8g7NxC9tLolM2MXpBVOFVQnRHbZxScLSlLWPO7Y?=
 =?us-ascii?Q?kksSXHeQ5AbiSn5U4zWBt5s4xLOTuLnrnCfneau9XVXnHbruq14azBJwJpeP?=
 =?us-ascii?Q?2Kj93OcCVsbI5o0xcVBcV7TzbN7XCcpFtfup3ay3/qJuGj46Gd7J9nwMkjvk?=
 =?us-ascii?Q?tiHbsrsQPm0v9EakMsX8S62lgcQ0Mn9pbQnvmsASnMfDi1kyrcMKiI43X8sK?=
 =?us-ascii?Q?uKrh4rZHtBaCtVcLW9J8235xt9xxWtVSSsxEpQIJowr8bB/TyM370hvIKR9p?=
 =?us-ascii?Q?Wp+Mk8UGxezDdOdTrXgqlqd5OXxynfQetQTuzD3TfNOA1vIHR+RQmVvoAnzY?=
 =?us-ascii?Q?QN4xouUk+xkAR/msfEEsKtmMkAVQ353bMrVNdGZGFl5HGTxd8PrN0WrqejtU?=
 =?us-ascii?Q?KgkW3Y6UlZdTJng6PT+Zc7rbIJL9i3BGF6YP5DSmqf4WtFmyA+aKWuVeu7uV?=
 =?us-ascii?Q?lJVQMPE9pNRi5PLFp/T6OU2QSfJ1KjXwvSQThsmImynwyxUQXBPoOGxO2kYt?=
 =?us-ascii?Q?bM7KteBLilOL/vlRRehYlfJ1dHrJ8EgoiO+7U4ON5s3XgVd8PN1gWI3MLFj5?=
 =?us-ascii?Q?0uhkXZJKVKQo/vdkTNpULW3T6QX1D8iMyJwYDuRv2drw1dsveYYultdYpwR8?=
 =?us-ascii?Q?M/Am9CTqJvkc0nOHz7mhVovVW2IkYB/WFBBNyZ3h5crX+i7ibngZZH6r0YQA?=
 =?us-ascii?Q?eLZ60ol2a3eLPLt/foZG1cSt4RsTipqiuZwzmk/zaZgc4DF6fMhJ8zO0XXzA?=
 =?us-ascii?Q?E8klacDiuJW/iVg2x30TRDrJHLW5WY7DA5gl9CQQrOxrHa2+IP3sjMd4B/q8?=
 =?us-ascii?Q?cxAi4Il1BA1ffUFSy8xrb8in7OmLqxRyWbzAjDNXiKOgeS4UeEw45Nwq9q8+?=
 =?us-ascii?Q?yRU1NU6zqh6L8mQAL/2CcPm3l+CCc24RbrvyTs8yPCp2EHj6R0OejH649dyc?=
 =?us-ascii?Q?ow983B6Y7A5hSuUNCvA8eWQqSMs1Hf3N0LK9A6krvm+pcXAT96y5rFkZmEpO?=
 =?us-ascii?Q?m55yrkjecXxUOtEqYsJHIpx4vBMkpthEfTxnrf4XHd/Vog=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ccOfRvZwMhSLFIAo+yi3G9AQF4dvQlsi2dUBfb+mWb+7SlsQaQ8Mrx1olSvI?=
 =?us-ascii?Q?FFfM7DhFQkh9TADeVpOReHFXXhGoxCH9xLJmpWwAbXu/jXfagul9AHb/Dr9p?=
 =?us-ascii?Q?LO6c2HDax1N3lXzZb+GOrDwk3ubelbVoiK5jyknIQjvfGkbG1gLZr2u2DNW7?=
 =?us-ascii?Q?adiKfsez1nMO/GZYqNVQVioF0Innu9J5mz3O7u+Gfyf1JIzIQP1oOUo8kXtZ?=
 =?us-ascii?Q?lARTzS2LZrm7mAZXz7b6tUxVOOHBWZNyXgJ1g2OBYKSXJJewfauVDXF83O/X?=
 =?us-ascii?Q?ARinykGISJRYJ0pqjBZGRRU1jbltPHJd/hNndpSLXFUXcn4vcHtCEtCYjo4X?=
 =?us-ascii?Q?2n0Y0+hjplXMeHUg5L2WXmhk+tjRJ00caT8MTT7u/YjZxpVUFr2g4JDwVDyF?=
 =?us-ascii?Q?bVxGEE1kgfeA5yKmviAAoyANPJqlhxYwkFYPv/nhou0czWG4VrgUMGm3QsvM?=
 =?us-ascii?Q?MFxawn0Aggyl3T6mJ/dWaWWXFdNWh9xri2r4bG7fnKTpzKcn7dZQMNekY0NM?=
 =?us-ascii?Q?wC/VQMuwPnms05Z+GP+pwJEI1dgxbv7MINb17M2Hsc/bQqC8k9E0/tTjcBZQ?=
 =?us-ascii?Q?qzIh1c761aDxMJf5phRDLk0cS3U6d/tceVQlPGmO+jVb+RTB5gMLkHFcQpxF?=
 =?us-ascii?Q?PFzWylQPL0/c5Qlx65wOvO7KeWuLZ1nBs8iaq5A/ouRh10eNDdGihfa8h2u8?=
 =?us-ascii?Q?OUj+/rb0pL3AIjFWMv1nipcaQp0e8TW174af8yMfO5b6mPfdR1fijCsSal6b?=
 =?us-ascii?Q?zKwcLhAk50hnhiWQB3NDBbfW7F3lDKQP4Vl/SUNWE1nNH4fSEsKlHaVWj20f?=
 =?us-ascii?Q?6k5hlhCsplLCOivUPqJCiWbWf6nWvZeVNiMagwQi7mwzgZETP8m7NpvPh7DL?=
 =?us-ascii?Q?vtH48Mj7YfxpLaNuVdZXFBuJlHm9bi/FQ9vDWq+rBVZHZcq1/opE5MvpF+NL?=
 =?us-ascii?Q?wmR/uitJERodZpdnTo8LpQagMB2jR9LYbhWPxnFOzw/O4gs5ITBFr0Cd6z+e?=
 =?us-ascii?Q?mC+xyntcZq+O7g611Aw/cmMkMLwUsJgSvGQwCNoMy2WCfYo/CMr3elty+a8r?=
 =?us-ascii?Q?yp5NiDBYvoSVtoetIVwvsrrHSIe9j9BSULrI++vdWZk9i7IuzfoRgyj2JNwb?=
 =?us-ascii?Q?G92gFGeGHzCNiYs4VYwTGq82hDfDHHDqd5FmP9Twfn1z0QrgWev3Kze2dvdl?=
 =?us-ascii?Q?nA1pAm4UznUyT5p3Hgqup8yf7TZS5bNc4cSwM1yexicCW9zOOXv8Z/985XB8?=
 =?us-ascii?Q?9NxDJAxmRnO/qZfdpjGZNhgonPXW1/ioD0gSRMKd8uhABG4V5WzMzvkz+kr5?=
 =?us-ascii?Q?0oDaCo3BevEq5inJ4YWBvPLn2ITMpnUpMunA/PuXntD//Tg7n3/KnHpFPCX4?=
 =?us-ascii?Q?ShTzFSlWAEUSUS0KCwh3HGKSPZGOG2ECr5IoGAKiZ00gh05aLTIHw+kL3UOu?=
 =?us-ascii?Q?ChKdvpwMN13mj3x46DiWFG9GkhXAYN90sCO5DZPPbcQJLGY4/SqKXYVbFcCD?=
 =?us-ascii?Q?+Q1ZekMleZ7X1lk40nMg3gUAwlK0QY3V8wQpkbcQiOmf4naDzTe8G62XTtI2?=
 =?us-ascii?Q?PbVEN02I7w7oLvaI+Cq1Y34saEAEjxoHbcKAgWJg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 602a0445-3cd6-4041-943f-08dcd11521ea
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 21:19:47.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiuQhA1Txg7JYRBbtdBMObfxnwCbt+0d6JAX1oOfaRcLKFwDbpnvstR26HJkUQaJoBdWfVMySHTyX0JjQG187w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Sat, 24 Aug 2024 17:07:44 +0800
> Zijun Hu <zijun_hu@icloud.com> wrote:
> 

[snip]

> >  
> > +struct cxld_match_data {
> > +	int id;
> > +	struct device *target_device;
> > +};
> > +
> >  static int match_free_decoder(struct device *dev, void *data)
> >  {
> > +	struct cxld_match_data *match_data = data;
> >  	struct cxl_decoder *cxld;
> > -	int *id = data;
> >  
> >  	if (!is_switch_decoder(dev))
> >  		return 0;
> > @@ -805,17 +810,31 @@ static int match_free_decoder(struct device *dev, void *data)
> >  	cxld = to_cxl_decoder(dev);
> >  
> >  	/* enforce ordered allocation */
> > -	if (cxld->id != *id)
> > +	if (cxld->id != match_data->id)
> 
> Why do we carry on in this case?
> Conditions are:
> 1. Start match_data->id == 0
> 2. First pass cxld->id == 0 (all good) or
>    cxld->id == 1 say (and we skip until we match
>    on cxld->id == 0 (perhaps on the second child if they are
>    ordered (1, 0, 2) etc. 
> 
> If we skipped and then matched on second child but it was
> already in use (so region set), we will increment match_data->id to 1
> but never find that as it was the one we skipped.
> 
> So this can only work if the children are ordered.
> So if that's the case and the line above is just a sanity check
> on that, it should be noisier (so an error print) and might
> as well fail as if it doesn't match all bets are off.
> 

I've worked through this with Dan and the devices are added in order in
devm_cxl_enumerate_decoders().

So I don't think there is an issue with converting the code directly.

Sorry for the noise Jijun,
Ira

