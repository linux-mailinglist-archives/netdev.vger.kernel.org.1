Return-Path: <netdev+bounces-103493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3581E908526
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB79C1F23CF4
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 07:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAD918410E;
	Fri, 14 Jun 2024 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwwasYTg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0F18410D
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718350443; cv=fail; b=gQfRifklRUrTZDF8n72Q/dnzObaasqozwU+dJoLDZfo9x0/mD1QZ7itThssE+Qr9irhYE+ZArDdwkkymV6XjCAhFhgw+qmWmHxSDSGNiAyX3JKdQi76vLWbZNibtTiSwiLXM7o+OV2RzCkw9vTeK5o5CCpgG2w4gDKBYX4Dfis4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718350443; c=relaxed/simple;
	bh=94mR+mtIAMA/fwCKntzqT4tCCA7tpEfh06BZmYxYY4U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K4IavbpkPGEUvBcaihk986VXBPy8kZ/dTjNlC5zMgPNL1uu97dTRPrZzQWKEIhNXik8ChrNF+Zc+2KXmnFzkmpiSMixEdawLp6DVBwWVWrhQxTaBOCaFULEsmTNBFipmtSjyDrfdM0qLSGmKpkK/+jVARMHxqgZPtkizmf6wfdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwwasYTg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718350442; x=1749886442;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=94mR+mtIAMA/fwCKntzqT4tCCA7tpEfh06BZmYxYY4U=;
  b=JwwasYTgjdzO5Rm+wN2Z6kZ1lQnJs7C9bF9LRth3AHUIpxsAY9fr55vn
   2xClLWw4twyeu8GtKQrrCdi5g0nM4svq9Sb0dVsu9CHBkDir/KPbE+z69
   qht+Rvn5EyV4vT8M4177FmjJUaaI2+DdngSjYTq6hEtCudE+IvmBFuqES
   07hyFKab4q5/TwYAX9mhpCxD00OOI00i/Cll4nj/5/Qiz3ChgufnFo24r
   BPMHBXUp1uCPqJFS+DcoM8td/do0Xl/mEwKliET5T4fpmL5/2SJ+Ar2EI
   J7W4yerUcmRLUlU6FLSrDFbyuyh+vntUu2BcrjWPOWoHiwXnAD35Z9OId
   w==;
X-CSE-ConnectionGUID: xK1Ysbq+TcWrjoVrleE7qQ==
X-CSE-MsgGUID: bm44eUsiRU6pEp4rvOntOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15384827"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15384827"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 00:34:01 -0700
X-CSE-ConnectionGUID: voeiL/oUSuCAEB9dizMNXw==
X-CSE-MsgGUID: WCC6ykAySBCpGWh72VmHjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="45376403"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 00:34:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 00:34:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 00:33:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 00:33:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 00:33:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M94jd449w5lcV3Iug0XrYDwTto7YZI6qygUWBrTyG4NhUMrC1kyQx58tGyDgvgp7GpnK9/QKX2oPLSOJ93W35F8DTWb9GZngySNE/2VQsa3XDFIOjPa0R9rNGmAHXQa5G0sRVG/2aW32XAJ80XSAyFdQFaWe9x7TEA/dHDyg0UXkJ5lY7mtv/w+lT3tBkJ2RBRet26WKjMZhr1cifY315Sei7OlB9+8DCgsqAzHqmH4tPVeRQCvpYWiEm/dFExYIXN/ykBZCvvJFFbpZ3BYKU0vPhp9w4TfHE4yZHfN/2fDBN6C1mvle77DfD6h5IalS/g70iMCq4Xu3cX2Z16GUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c//9UFL2EEXnLtZXRfS5QyDen/xrCqHGMLwBYWOPepU=;
 b=YMpZND8UHAYTJSx0SdE+c/A2HLMASp4A0ErDzzSiq6K0P3QRG38/ceNJKhifSXM/djCp6TcL3B2aZqfcG6XJYLD9K/nq/RPc5bQC0vLyGtca0lPmn9EaxO9kOf2DRn9TUwCShnq8kQmo2PbHKLHAqa4ZtJhVAlAF0C1/nGAnWHS/RRgl4kk2pZsVQoKyeeO3WXiW2DELwgiTTRXHoNvedD83j44uiMBTqf+f5lYXWEtqnxvKWKcbitkz1hzIzyQl+ReG8xZlkNMDaFFTH8gVVwOC9BVXi1TaNgwi0BN+7bHAnOPrVdX7QYurgDlQBfCjV6NMHP5fvo6/p3p7cURxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MW6PR11MB8438.namprd11.prod.outlook.com (2603:10b6:303:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Fri, 14 Jun
 2024 07:33:58 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 07:33:57 +0000
Date: Fri, 14 Jun 2024 09:33:49 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: Karen Ostrowska <karen.ostrowska@intel.com>, Eric Joyner
	<eric.joyner@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [Intel-wired-lan] [iwl-next v1] ice: Check all ice_vsi_rebuild()
 errors in function
Message-ID: <ZmvyXQy2dnGIj1OM@lzaremba-mobl.ger.corp.intel.com>
References: <20240528090140.221964-1-karen.ostrowska@intel.com>
 <f95c09fb-3a97-4afd-87ec-aedc719241c3@molgen.mpg.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f95c09fb-3a97-4afd-87ec-aedc719241c3@molgen.mpg.de>
X-ClientProxiedBy: VI1P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::15) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MW6PR11MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: f7245eb0-4c85-4ad4-303d-08dc8c445a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4vCSSpDxxPtsTY9wWmaIyDwFWVRZ9d9cDpNhHN/7XPnsbpuF2/ci3xKu4rjM?=
 =?us-ascii?Q?bgPVtUPgFtq0KBuO4P5EwbS9XlZiJYaK7NE28/PlZMTGsYcd6kvTeYk88KMl?=
 =?us-ascii?Q?g3QmxWlUS0lEz4BGOQMBwQb/IIEpWr1PRtigL8py1V+xnG3Bgz+bDEWV6080?=
 =?us-ascii?Q?F41J49B9zSnF2jxvdskcDXf1xDZeMz8d1uXUhZRuxxqbbHyTGuIZfi18hWFE?=
 =?us-ascii?Q?YYOZTwNy2zZMCiIyoUq4mF7U7GmfCVlY1ZRwXefLT3koFT8wX1/c7/zicOyQ?=
 =?us-ascii?Q?3EtSZrRgOcW8jQSohbMbmA2NurMwZl32pb2+FJclcy5wH6zSCoWlxMrTuH4n?=
 =?us-ascii?Q?Y0O5PxGVH+Cf4mtIvj38X0iJrwggunPJ0HfwgCLUVUd5rFo6fuNqonsC9Vym?=
 =?us-ascii?Q?xogl9NS720TzGotZw5l8taOyuNEPI4DzuPZbXQl1HwiztN8z+oR93vL4cJAz?=
 =?us-ascii?Q?gyAkDwjeWF0Ew7N95xlRwAgxRgwnuEgZ/EzBR9L+k98IW7leO5LNUnv1YGQl?=
 =?us-ascii?Q?5BbEtJeR0dUlYIP+73bX/HfNQdLgd7qZPyJcFxRALjc/eo87SNYZPU1YvgL1?=
 =?us-ascii?Q?ZwDNDy/A9OrdmxfV802J6cN9uH0DAYE0xL9YJ6ENbaBK+NYIrfNgP0l4OtzG?=
 =?us-ascii?Q?27Yq353WWdoOKSStM0tOdJvftflhEAuk58aIHv+hxts08yD9I7R5hPsWgqsK?=
 =?us-ascii?Q?Rsbjlvs06Q2Zlv1QwuasQT9oq/4aRuEyMvZ/ha/wofYHZg/1xWlJYwYr0qwv?=
 =?us-ascii?Q?/XMrGG8pycpE81Jz4ifQGx34CVE9Hp+8WFaqpr1gQHuDS1GSLy+gryoBbtHL?=
 =?us-ascii?Q?3y+vTP1lEhr6DnKNUOBFRTZHFTqzStR7msNRC7pY2baZmridSyhahQ/c4JBD?=
 =?us-ascii?Q?UGSvpPKsonl7RsBC2Qo0yPKhoTKS+nhQ+8vDXB4YfCfKnzX3g6G6Cggd4fLJ?=
 =?us-ascii?Q?YehbACwuhqt9Chy7yygQeKr89iK6rR6SXYdKR2JMvaXAbTxdDthh9G7pum3j?=
 =?us-ascii?Q?Y6jaE1dcclernu2o9h3/YfzUNtwxM4ELkIlO12HXMgA5vnyep/5woEdPgbps?=
 =?us-ascii?Q?87rj+B4v46t6TO31HY+kGekTmpcGSCjDT1Ql3FuCIhVpcFSEp20witf65eno?=
 =?us-ascii?Q?mMKRVVtbqlJFV8FvzKLdLku3PeBuejQKCuEviqpEtOupGUb1IN+DfzN9N0jA?=
 =?us-ascii?Q?PdS6nqUmlgohUWbqyEAz9hhMEv9WHBFbciNLjB0AMBN4yhQRgHiku7V6zJW/?=
 =?us-ascii?Q?uu2AfaMSM2hJ9/Ehe/eAJRz/kmBejPdWstYckzAtmyGvhGLs9eenwWb6E9z0?=
 =?us-ascii?Q?GzM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ATPgabCubZ7wfLkSc3aL/UvxASM2DaHScutmppYEaOSbyQ8NHR8Uyzz6CoHt?=
 =?us-ascii?Q?/z+1dKK0Wrnu06jUjHnPeB832YPPAT0G2QJ3QKxGXs/FDLwP2C8VXBBvzTvl?=
 =?us-ascii?Q?3xrV/xlXfmOqPYt2Z7a95HAChjaBePdCjcilRN4nglj12Q377DRhz5eK5y9u?=
 =?us-ascii?Q?5DXRZ9GTCqyj0aIR6+r/rBgtYv+cThd+4biNfoxD536S/ZARcx2Cdrlc7oLM?=
 =?us-ascii?Q?8h3U8AHVPGf28h8ZhWV4dE/E/86d7jr8pfyFHsAjfDGLwE9QwvaYMbwUSwg0?=
 =?us-ascii?Q?uwbxqTpcw16vJG/BETJ4/wW0Yj2teBs1dF8FkcVp+5DCLFCfbXEVeBvTwn5y?=
 =?us-ascii?Q?c9E4IVAfNfVFcJSc+QLK2xV0kTZSTARRQhm35MK6bOclo+AZV5ljF20ou3gb?=
 =?us-ascii?Q?jd4EKPPlPV1By4JwkHHYl7mu04ddJSQ/PHAXiWauYrjNfdcllc0yIniweDHG?=
 =?us-ascii?Q?+OwHST6YAC6qrk7wW0zq/scYJDtOH8Pp8yHgO1vOD3kOERCaUBPgdtFgq1J0?=
 =?us-ascii?Q?NPrtR3qQCvJUQx01a5M7JQh3EFra2vdTr8HxZfF3OewN6yAjLxz1uzbUxF1s?=
 =?us-ascii?Q?CbwlJ3gglZoxmVwlBY1/vxsAzIK3c+pVJlqpWzRi4iebusYSoa4lgy4w+tLn?=
 =?us-ascii?Q?oxdrnR5gLXK/4YNjQ3kU5qpIS8/QkGuhIXv6w0ZOALgT9eCbN07+UPhMJdxZ?=
 =?us-ascii?Q?jdj4xFVp95PRkvcjpYsL3kvr/v+SzPpwVWH4f3B/XH0W24q0cJ0gHvlO7NYc?=
 =?us-ascii?Q?NiK4BzKXZCJV8T7gfMP4Z7XIUW0uZNoo46n+g0kL9GOl8Z0lkgrjj0t+7Nf3?=
 =?us-ascii?Q?ZEwiRoOytmxoWiaY0dHFvpvbmtAKBqRMQnt1b/sfgh88M1hhYv86GCJ8pKIr?=
 =?us-ascii?Q?9XiPIdaQbLwFZnQEJC7TZBYxetJjY2T8xY5kGdMRlc/dGzdcMk4MQEHDpxig?=
 =?us-ascii?Q?2yDDrbT3hpwJArD8/0oSsnqfABjiZ+Ix4/iU1s4RGXiAYwLciFDocX1cfOou?=
 =?us-ascii?Q?ygQsfxYWBsGVw1nkCAA7gPCa2AcR06QLzUQuXOCzv74iOO8UxwAeOQVc5UvG?=
 =?us-ascii?Q?mkGGbXsp3V1OAKbZOFPlmgW51JdbEpR2+Dg/OepuBXngSJd6u0hZqecYUYVu?=
 =?us-ascii?Q?2xakCzI4RY70HRDKw5AFhigARp1QJHkrLazABanrc70CaiP7mQrOXzcCDhN7?=
 =?us-ascii?Q?1TmjjPBdDRLOK8tDyw3tT2i1NiDqXBnXsg35DWtzXPHhogfsLGobjcHO2A2J?=
 =?us-ascii?Q?Lxm2MurFARmJS0AioAI3fx/NpphT2O10CMFjuuiGR+WNEkz6rJHwYAXbawdt?=
 =?us-ascii?Q?dFPP0rLBNP65Ewpcn7hLYa6CViOYyd4Ql3D7Jw4uyit27YqGtBgtN/cF5qyd?=
 =?us-ascii?Q?aws1e4CoL/SiEQ3uXBJI3kCg34dEMxOz17JS3/uPLzJriToM5iHPYF65P5yQ?=
 =?us-ascii?Q?IuVes4ZSBcKKVGM3ZuI0c+78bdtp/nPdXVqcUBWq1t6XVJr2vVTs3E2sDCDF?=
 =?us-ascii?Q?2E2iNqbDT/ScfWwplrvmFCG57abzmo25rMKOaq+mgeuz+v95A7Pkytdzlosn?=
 =?us-ascii?Q?51Bmtjj+0Dok0Eo0LpRtNlEP+TE4yQp5NMDfWtEy7cqtmKIwwpDeoBEdH6Ca?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7245eb0-4c85-4ad4-303d-08dc8c445a2b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 07:33:57.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGO6w/3cVXiQLcfX3/d8tgMPE9VLmWqKCNfYSjYaz+XbWALl6rUqdRmRok1Xl8zb6ulVMgdbkFIwi5058L2rblYjWvfgFChw1O/WV61ocY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8438
X-OriginatorOrg: intel.com

On Tue, Jun 11, 2024 at 11:01:55AM +0200, Paul Menzel wrote:
> Dear Eric, dear Karen,
> 
> 
> Thank you for the patch.
> 
> 
> Am 28.05.24 um 11:01 schrieb Karen Ostrowska:
> > From: Eric Joyner <eric.joyner@intel.com>
> > 
> > Check the return value from ice_vsi_rebuild() and prevent the usage of
> > incorrectly configured VSI.
> 
> Was this found during code review, or is this seen in practice? If the
> latter, please document the test system and test case.
> 
> > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Signed-off-by: Eric Joyner <eric.joyner@intel.com>
> > Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>
> 
> Should there be a Fixes: tag?
>

There MUST be a goto here. Patch results in an error message without an error 
[43788.733637] ice 0000:18:00.0: Error during VSI rebuild: 0. Unload and reload the driver.

> 
> Kind regards,
> 
> Paul
> 
> 
> > ---
> >   drivers/net/ethernet/intel/ice/ice_main.c | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > index f60c022f7960..e8c30b1730a6 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -4135,15 +4135,23 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
> >   	/* set for the next time the netdev is started */
> >   	if (!netif_running(vsi->netdev)) {
> > -		ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> > +		err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> > +		if (err)
> > +			goto rebuild_err;
> >   		dev_dbg(ice_pf_to_dev(pf), "Link is down, queue count change happens when link is brought up\n");
> >   		goto done;
> >   	}
> >   	ice_vsi_close(vsi);
> > -	ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> > +	err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> > +	if (err)
> > +		goto rebuild_err;
> > +
> >   	ice_pf_dcb_recfg(pf, locked);
> >   	ice_vsi_open(vsi);
> > +
> > +rebuild_err:
> > +	dev_err(ice_pf_to_dev(pf), "Error during VSI rebuild: %d. Unload and reload the driver.\n", err);
> >   done:
> >   	clear_bit(ICE_CFG_BUSY, pf->state);
> >   	return err;
> 

