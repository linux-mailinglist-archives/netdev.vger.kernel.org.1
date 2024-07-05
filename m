Return-Path: <netdev+bounces-109424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F0C9286C4
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11ED31F24E0E
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1C7147C98;
	Fri,  5 Jul 2024 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="McC4bN/k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA781474A8;
	Fri,  5 Jul 2024 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175324; cv=fail; b=s2kPonW4ttkQ5oTi2c+LStBvv++UPsPxbZfTlIQFHZKBrz4FQpOaOY0oR9frgtJoGVcbugnf/z5bv/SeREw97c0HXSBg3ivQ4CMiID0uEA0xvyvM/fEyVdDoyM9iA2LU7i1jI6+5SufMXk0ezHpLHlkjRrCwmCmR4kbhIH1cnhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175324; c=relaxed/simple;
	bh=KQOeBx+G7AXkGqR9vCJTdi4fOtGX6D7izXwZ4LCQorY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=frsFr0AN3wq/4AmLdX5HjLb8eTeKqdIst4VWrLv/0cItGAa6TJPs0p70LsihkDFLEETM6+MeeZmtHcMEifvPDKfcpcqnnJfmtRPp1JEnlqgtRD4iwq17RmYNSCgk5eD5tZiL8Gwp34Pf/0XBtWd7LQ9dTe5GfMNBAUxTM0Bt5kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=McC4bN/k; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720175322; x=1751711322;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KQOeBx+G7AXkGqR9vCJTdi4fOtGX6D7izXwZ4LCQorY=;
  b=McC4bN/k4bUjd/XMtcVS3NdJSRS7TtVjWlq9pHdHniDbo3TLIolNnaHh
   QMUEctqtve3XOFJqZr14cIM6yTENkjPijrZX0ZQxhTns6QDbbO/WLLGUN
   OHbLN2z4iOI/RySDO2NCksC8FzPN36Vw5KeYbjX+FlFxvive6oJuzrn6Z
   mKXI4NwtgrUn53upF+vdhNgxbnHmzEhMcUyXuS2YNYcz323aXe1V3cJNM
   RoNK/nUs4kZqOvzj3oBprw4NGEWyqn+RfcMuWEj4UqmQ8L5l0vahIoYop
   JytjRTDIAak2nU/CUBD29c2tGz6KMakwRtINLfLwt31MjbFTq/pSuhpXb
   w==;
X-CSE-ConnectionGUID: N1RyrAf2ROyGt/5g2UYmQA==
X-CSE-MsgGUID: rC9z9V1vRHCNWbMVveWnFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17297362"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="17297362"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 03:28:42 -0700
X-CSE-ConnectionGUID: m/+maFLfSWCMFTNJmz6AaQ==
X-CSE-MsgGUID: lW9bE4ypQfKVue/SWZ8rpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="51174288"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 03:28:41 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 03:28:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 03:28:41 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 03:28:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXWNnaNkKLyYqDeCCw12hVdra7I+p5LDxnhSDUSF9rQeh342CcBIO3xlKtqy8RoMiy/nO+zrDDif2nQ/QY1uExZQnQ5nx3mBeHw+1xWj7m72ZanIHzF+lPg9HWIA9M3bXCdK8LaaHv1WZwjhMQr6Fh8bGhtES0vNq86gLax92KGspxRr/yj6RE1WTxMkBH8iC+wvLEoMMeNx2TwIz50K45DL9Xs14ejn/KY/3Eko1bMoNL0r4kgkCI0CFldK9FV/UOdjI06WrWrLwDXksmweQxo0QNSyrx2wCPpj2RaPKJuH75ljBh76HU7SYw0SjsfCD3iCf6buKKXDkHkngnsWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qis5o03S1OvswSzutV6izkSqMV3okh20E7xP1AmIfuc=;
 b=P57jCdKwc7dFr3R1mGsWOS1tbC2TvmM/WHZPr5AzIYaCbnNkKb/taJflvimAjuwPZDwz96ngyngiSrp5mUZhN8dd9B2Viy9qsokRh0tEkYePRrzmWg+55pxlAvmB02I7hnjuYH/Qoyeo4wD+C02DwfmrAS1Pnv5BVN34GDRMW2Y8xW2XhqFMJX56qt/fBJQ2+DgYOYd9Kbci+YOZb5lLJrQI9JxW2OPuDjU6gFsWxNc76GLD66kLdRB3BpELmKi7/XYPI+gVJVmqktPZW97VrHDeydCckYsw3xmmCCYRJJn9Vw5/r7SPVfpofnmbLRHrbgruStxD7zdqeNrElHvbww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by LV8PR11MB8560.namprd11.prod.outlook.com (2603:10b6:408:1e7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Fri, 5 Jul
 2024 10:28:38 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 10:28:38 +0000
Date: Fri, 5 Jul 2024 12:28:25 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Furong Xu <0x1207@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Joao Pinto
	<jpinto@synopsys.com>, <netdev@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xfr@outlook.com>, <rock.xu@nio.com>
Subject: Re: [PATCH net-next v1] net: stmmac: xgmac: add support for
 HW-accelerated VLAN stripping
Message-ID: <ZofKyRVcgzLn/pxx@localhost.localdomain>
References: <20240705062808.805071-1-0x1207@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240705062808.805071-1-0x1207@gmail.com>
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|LV8PR11MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbc8c31-37af-4f20-b58b-08dc9cdd3bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CYmBd+xyEU0TMT78iTXCz1w6kjUlkvWwjhnXLQ01vScAYUy6sK10j6TPC22K?=
 =?us-ascii?Q?Hbsb7NRRg3b9hRhoXOmRRBtfGgMOsQ9YBUvIIOVgp6yc5CqtfKuA3fpyldj3?=
 =?us-ascii?Q?/htHq/ZMQeKxBQEfpr52s2sGK9e50z4G2LQM2SiS37F1UW4PYZCgOnNUEfwg?=
 =?us-ascii?Q?blnyt6LCcUcP6dqNUVbPY8quFTDqArEJrTRnEMcqYE8I59X75Kl9REECEYRX?=
 =?us-ascii?Q?mqwJzPfFM6wme2SMyCKJhVbPoiw4YhQM76kpqpJ918j9AlMxgZuQ6XptA29v?=
 =?us-ascii?Q?lmjZyPBFd/NpkTiHp3vZ81aSFEaH0uikWHQiTpFDcj2lXJFQ8qY2XR6Yhn9c?=
 =?us-ascii?Q?cU0rlelBUnj8RD/rjvYobPCb209FrWdplWpx+BZ1yqSPSMKNRCf/qVhSXpQZ?=
 =?us-ascii?Q?rocHmGQap9rhNewKPyEAPGgChYHp/KglSz5pOVYbiHyrfjk5fgkdPpz4NuPi?=
 =?us-ascii?Q?+zDV4mp+vNu1v/okrwuk8YVDxTljlm1Np5YjaF4oqfCKSzSQR+29sxWlM+ai?=
 =?us-ascii?Q?/4vysJQEIljMXPWDtFUiOq3HFy/NSS1TlqDETDb8vsdt4psgxH/nNGLoXMPl?=
 =?us-ascii?Q?tfcVp4AjWMvrGCv0OLeTbpkIaEBpqWDYwMvtqZa82Mn0dDVljAeCBM2Y4fEa?=
 =?us-ascii?Q?u3MHKNJblh24rpRiKqMgWlWhWWGozGGV+vufjvsZfpKBg0lM3lC4nf0EVO3Y?=
 =?us-ascii?Q?q+lg9n3DFklcYIU1tGW2yzl6MBS2sxrz+gpLJblF0NDoIm1SVmGLG6mrewjh?=
 =?us-ascii?Q?7N+GtMg9C5iX8qFIIhDHcCW3SFNVf+ygAvkmC1iXJNp9T4gmCTFKRe4VKU8r?=
 =?us-ascii?Q?pJwwwLKDjiRcvtAy0Jy+DfIlW0S3i0o/1ubywJ1dHMgMEaZKJjtDs++PdeiY?=
 =?us-ascii?Q?0oaTJbqapXdQnJgd6WWrJHo4A7SEgVcZq0pGsFOOb88V/THZujzyPBOOQW9Q?=
 =?us-ascii?Q?W66j4yOqq86BYARzxIOCVcE/uTKbaHd3cGR7bztPaz1w3yYyXSC1/0aXFJzH?=
 =?us-ascii?Q?h/1p5+lwlMHdLFtnlYcvpvbthJpTosp42a1/0piMPm+O1Y6ueDEKHDXF/LXm?=
 =?us-ascii?Q?taBau7M1K7gXsNiCYpIn6R8elKemH6ecnTYp/xomZ11Wia2zaGDn9NABq0+u?=
 =?us-ascii?Q?1Y+LgjXOE3CjKWWxVoUmXTs29JfNgsz/Rq+CXiJuiBMvXvWPki2hIpaJRJDP?=
 =?us-ascii?Q?PAbOO72JCWVXBJNIhhVksoyUG6krItzuhkzbBKa7LtKF+8QfkfIXEBuwcCnp?=
 =?us-ascii?Q?2T/eaeVodNRUbngJhdxYHQMktKXej120nxorZhusLa7wuD0qSurUeoHJTSCl?=
 =?us-ascii?Q?45eCP1b1FNwnxAGtwJiDd7Sv+3k4GjzRVwcYjItqXhUsbg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dKEAkLOCSLWCpywlEgS8CPROUA2pyWfDjtInKRBCsCac9/HScSDq2sBWxCa/?=
 =?us-ascii?Q?mS3FrXPhphhkhnlcbivMDS9O9Rst/31klUx185ciN910GXsUzIas0bIN0fhE?=
 =?us-ascii?Q?gcAuO7JY5oxN3m69eAa3v5o97DCGA+KSpuOsAlKctpEy+DCwmmVx1m1KwrKY?=
 =?us-ascii?Q?fooG8khgcDDoCPKjITEf6GNW5A860zFckga9ZJ4ACtaOXV/R7hVCOX/buDf/?=
 =?us-ascii?Q?PYFQruFbyjup1s7v69k2m7v+4JNJ8wbRMytkAb69eiQvnNynYZ4bOcpvHf/u?=
 =?us-ascii?Q?usoanseQYBECspHt3Qtym7dpUzq2QYF884Ba3KT2Q2S/XZjewZH02LtWLiHL?=
 =?us-ascii?Q?K+zYYyKqjiZSTOJzcRrKR89/qnLLeFkQI+WwPE95zhpopkBxV3qxWGGOwhB6?=
 =?us-ascii?Q?TVK7yHaElATIlinBPR0kjDsULUaj1gKTvntIlmCL1Oxp67c9J7bg3abh5pgJ?=
 =?us-ascii?Q?a3NJc+HO80ODAew7YhLz/wUyz3u8a9wNI8oLfohjj9AUuL2xMnZRtx1FVWlp?=
 =?us-ascii?Q?JvP91i3x19797JDXgLmmO8rUskeO6DttpPurxYSSrjHXBDDt6ivP6XD8duzg?=
 =?us-ascii?Q?L8imEMF7evV008RNDbOT6S+8FH8/+v0HYFbXxBq0RWkBHZsW/oa+1W0sMuMA?=
 =?us-ascii?Q?UdivtyTWx+KlCZmlotkzjIfvUGEufvTj1fSvgVOa3OrOM+ThGcciQyJ1xnmo?=
 =?us-ascii?Q?I8TX12lhKK4VoL5vBPmQ73NiH1N5XxJGYvs7W/gSXYyl0LNKIdBf9VHYPs0O?=
 =?us-ascii?Q?F69RJQ2wNJ5ZB8owP/cxzfXtSWIdjnK5fLOhn1Nq7zmPgGoA4ufbhrjsPAF8?=
 =?us-ascii?Q?Gci5e2PQBLaT8HnXHbzEW3gVS4LtkdC7SG7+OhGycdDpdi+cpCtQsQegF8Iq?=
 =?us-ascii?Q?1IU6LPe+5Iv8je5KeZt7O0sDqeOnSWvt/Qixcc0IZ+a5vyDf0zZ7LiJL2IaY?=
 =?us-ascii?Q?tF6hQQv72rTH75lXOuokliBMgh33sdHzJQZ4HoO3mPPD3W4Rq3h+QIXUgPnl?=
 =?us-ascii?Q?5Ii7t7pSvvR4/+6QH9yULuK+8NKWFBifuyPsaJhUK9MqMVO5AZRU70pMFBlr?=
 =?us-ascii?Q?wPdeaoqzo1XPRUwDCd78UzxaDN/ULVZGMvyscPevz66M/1Bf3hFDvoQs5LTz?=
 =?us-ascii?Q?j5daRmbt9Oj0DjSpa5sAWACLRcFts3XsgUw0vn+rgux2V34/P0d++YJFkYCH?=
 =?us-ascii?Q?EwA8IY2SOZbftZugyvC/dRINGL/VsZYOe7b70I9HEOlyeUMrXm+PZOCGvssM?=
 =?us-ascii?Q?z46wlx/IMnWKuxgmLqg44y/5fmO5RNQRRAbJrHuRsRpd/NUNUCLubuFLYep0?=
 =?us-ascii?Q?QQIsuZNuqpe9RijE/9tCxIP3D5IMCOz2DFeNwID8kbBZ8CwFxqQ8UnLfDNdb?=
 =?us-ascii?Q?wlP08VHVWgaWoyw6ryT7TPZudhdu2BiEbV+Gq+q8WPuy7txIJ4lXAFTC/J7+?=
 =?us-ascii?Q?EdwsqxoHxql4jEK2gG8a39ePzAs7FQO9lIQIdAG3UGT3wYyBoD7HcG1EQ1S+?=
 =?us-ascii?Q?bMrXrrgpXCvjWvmb3vk9OKJ5qWFkoEK4827+tE1AdjwRyZmON+WNYmX+CMnW?=
 =?us-ascii?Q?+jehMu2uaBzJpZCSC/5S3bodNCaPXAShJn0/zvC9Mkif6w9GOu3iyRBnkKZ0?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbc8c31-37af-4f20-b58b-08dc9cdd3bda
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 10:28:38.6676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiTluOYCgBDULZ7Y3uTsaEqJXNXeVXxhhMJoD61tgdGf/L/dY99Rt7pAL6Tsxf5IaQoe4F196QCRZcPzEorLqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8560
X-OriginatorOrg: intel.com

On Fri, Jul 05, 2024 at 02:28:08PM +0800, Furong Xu wrote:
> Commit 750011e239a5 ("net: stmmac: Add support for HW-accelerated VLAN
> stripping") introduced MAC level VLAN tag stripping for gmac4 core.
> This patch extend the support to xgmac core.

typo: extends
Or maybe: This patch adds the same support for xgmac core.

> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  7 ++++
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 39 +++++++++++++++++++
>  .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  | 19 +++++++++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +-
>  4 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 6a2c7d22df1e..db3217784cb0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -60,6 +60,10 @@
>  #define XGMAC_VLAN_TAG			0x00000050
>  #define XGMAC_VLAN_EDVLP		BIT(26)
>  #define XGMAC_VLAN_VTHM			BIT(25)
> +#define XGMAC_VLAN_TAG_CTRL_EVLRXS	BIT(24)
> +#define XGMAC_VLAN_TAG_CTRL_EVLS	GENMASK(22, 21)
> +#define XGMAC_VLAN_TAG_STRIP_NONE	0x0
> +#define XGMAC_VLAN_TAG_STRIP_ALL	0x3
>  #define XGMAC_VLAN_DOVLTC		BIT(20)
>  #define XGMAC_VLAN_ESVL			BIT(18)
>  #define XGMAC_VLAN_ETV			BIT(16)
> @@ -477,6 +481,7 @@
>  #define XGMAC_TDES3_VLTV		BIT(16)
>  #define XGMAC_TDES3_VT			GENMASK(15, 0)
>  #define XGMAC_TDES3_FL			GENMASK(14, 0)
> +#define XGMAC_RDES0_VLAN_TAG		GENMASK(15, 0)
>  #define XGMAC_RDES2_HL			GENMASK(9, 0)
>  #define XGMAC_RDES3_OWN			BIT(31)
>  #define XGMAC_RDES3_CTXT		BIT(30)
> @@ -490,6 +495,8 @@
>  #define XGMAC_L34T_IP4UDP		0x2
>  #define XGMAC_L34T_IP6TCP		0x9
>  #define XGMAC_L34T_IP6UDP		0xA
> +#define XGMAC_RDES3_L2T			GENMASK(19, 16)
> +#define XGMAC_L2T_SINGLE_C_VLAN		0x9
>  #define XGMAC_RDES3_ES			BIT(15)
>  #define XGMAC_RDES3_PL			GENMASK(13, 0)
>  #define XGMAC_RDES3_TSD			BIT(6)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 6a987cf598e4..89ac9ad6164a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -1530,6 +1530,41 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *
>  	writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
>  }
>  
> +static void dwxgmac2_rx_hw_vlan(struct mac_device_info *hw,
> +				struct dma_desc *rx_desc, struct sk_buff *skb)
> +{
> +	u16 vid;
> +
> +	if (!hw->desc->get_rx_vlan_valid(rx_desc))
> +		return;
> +
> +	vid = hw->desc->get_rx_vlan_tci(rx_desc);
> +
> +	__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
> +}
> +
> +static void dwxgmac2_set_hw_vlan_mode(struct mac_device_info *hw)
> +{
> +	void __iomem *ioaddr = hw->pcsr;
> +	u32 value = readl(ioaddr + XGMAC_VLAN_TAG);

RCT format of declarations is not met.
(However, in this particular case it can be debatable because it would
require introducing a new line).

> +
> +	value &= ~XGMAC_VLAN_TAG_CTRL_EVLS;
> +
> +	if (hw->hw_vlan_en)
> +		/* Always strip VLAN on Receive */
> +		value |= FIELD_PREP(XGMAC_VLAN_TAG_CTRL_EVLS,
> +				    XGMAC_VLAN_TAG_STRIP_ALL);
> +	else
> +		/* Do not strip VLAN on Receive */
> +		value |= FIELD_PREP(XGMAC_VLAN_TAG_CTRL_EVLS,
> +				    XGMAC_VLAN_TAG_STRIP_NONE);
> +
> +	/* Enable outer VLAN Tag in Rx DMA descriptor */
> +	value |= XGMAC_VLAN_TAG_CTRL_EVLRXS;
> +
> +	writel(value, ioaddr + XGMAC_VLAN_TAG);
> +}
> +
>  const struct stmmac_ops dwxgmac210_ops = {
>  	.core_init = dwxgmac2_core_init,
>  	.set_mac = dwxgmac2_set_mac,
> @@ -1571,6 +1606,8 @@ const struct stmmac_ops dwxgmac210_ops = {
>  	.config_l4_filter = dwxgmac2_config_l4_filter,
>  	.set_arp_offload = dwxgmac2_set_arp_offload,
>  	.fpe_configure = dwxgmac3_fpe_configure,
> +	.rx_hw_vlan = dwxgmac2_rx_hw_vlan,
> +	.set_hw_vlan_mode = dwxgmac2_set_hw_vlan_mode,
>  };
>  
>  static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
> @@ -1628,6 +1665,8 @@ const struct stmmac_ops dwxlgmac2_ops = {
>  	.config_l4_filter = dwxgmac2_config_l4_filter,
>  	.set_arp_offload = dwxgmac2_set_arp_offload,
>  	.fpe_configure = dwxgmac3_fpe_configure,
> +	.rx_hw_vlan = dwxgmac2_rx_hw_vlan,
> +	.set_hw_vlan_mode = dwxgmac2_set_hw_vlan_mode,
>  };
>  
>  int dwxgmac2_setup(struct stmmac_priv *priv)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> index fc82862a612c..f5293f75fbb4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> @@ -67,6 +67,23 @@ static int dwxgmac2_get_tx_ls(struct dma_desc *p)
>  	return (le32_to_cpu(p->des3) & XGMAC_RDES3_LD) > 0;
>  }
>  
> +static u16 dwxgmac2_wrback_get_rx_vlan_tci(struct dma_desc *p)
> +{
> +	return (le32_to_cpu(p->des0) & XGMAC_RDES0_VLAN_TAG);
> +}
> +
> +static bool dwxgmac2_wrback_get_rx_vlan_valid(struct dma_desc *p)
> +{
> +	u32 l2_type;
> +
> +	if (!(le32_to_cpu(p->des3) & XGMAC_RDES3_LD))
> +		return false;
> +
> +	l2_type = FIELD_GET(XGMAC_RDES3_L2T, le32_to_cpu(p->des3));
> +
> +	return (l2_type == XGMAC_L2T_SINGLE_C_VLAN);
> +}
> +
>  static int dwxgmac2_get_rx_frame_len(struct dma_desc *p, int rx_coe)
>  {
>  	return (le32_to_cpu(p->des3) & XGMAC_RDES3_PL);
> @@ -349,6 +366,8 @@ const struct stmmac_desc_ops dwxgmac210_desc_ops = {
>  	.set_tx_owner = dwxgmac2_set_tx_owner,
>  	.set_rx_owner = dwxgmac2_set_rx_owner,
>  	.get_tx_ls = dwxgmac2_get_tx_ls,
> +	.get_rx_vlan_tci = dwxgmac2_wrback_get_rx_vlan_tci,
> +	.get_rx_vlan_valid = dwxgmac2_wrback_get_rx_vlan_valid,
>  	.get_rx_frame_len = dwxgmac2_get_rx_frame_len,
>  	.enable_tx_timestamp = dwxgmac2_enable_tx_timestamp,
>  	.get_tx_timestamp_status = dwxgmac2_get_tx_timestamp_status,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 4b6a359e5a94..6f594c455d0f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7663,7 +7663,7 @@ int stmmac_dvr_probe(struct device *device,
>  #ifdef STMMAC_VLAN_TAG_USED
>  	/* Both mac100 and gmac support receive VLAN tag detection */
>  	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
> -	if (priv->plat->has_gmac4) {
> +	if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
>  		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
>  		priv->hw->hw_vlan_en = true;
>  	}
> -- 
> 2.34.1
> 
>

The patch looks mostly OK, but I would request to improve a description in
the commit message.

Thanks,
Michal

