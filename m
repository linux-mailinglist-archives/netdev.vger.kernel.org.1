Return-Path: <netdev+bounces-277012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE/nLlut12kMRQgAu9opvQ
	(envelope-from <netdev+bounces-277012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 15:44:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298D93CB786
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 15:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51F76301A2AA
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 13:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01672D3725;
	Thu,  9 Apr 2026 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bt96q2vz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9E36494C
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741881; cv=fail; b=aKG6qvULiYvkA6PxC0eRBeaIy2982aLNlcrLQHmLZHM04AsiqtEgZUe47QOlgRD9L5itOBBVMoXlT/yxE07tPy6OJMW9olwo3kxDtcZAVnaOrKnP2BNIPdk72rNjQuYDiqo+pK8FsLlrGAhWREaLddqZUPydKFXbxsxtqkuLKNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741881; c=relaxed/simple;
	bh=8TwS9fnw79bWH72v3d0ELO3QWDv/Li4RdCbPfgQi3Lk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A51eDqE/eI6ZZtDGQT7TxknAXuMb899ziiALRfUzb18lt/6qF7PIkn+Py1goWShEzELGMcTdYGCH6ZaJ+EA7QwCz3z09dkS5BREkF6m40OgcA0X/fX22LE9dIuJEYcGEi5zQYbiC4Xq4wOzVTN/IkcZFXGw6zqnCagT0s9/uIO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bt96q2vz; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775741877; x=1807277877;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8TwS9fnw79bWH72v3d0ELO3QWDv/Li4RdCbPfgQi3Lk=;
  b=Bt96q2vznHdEKAeCZ3L7qtAQFuhqxcsVOFjDk5rA7FJI0Nnkfr+GHiHP
   Fc0waUswnnaWG+Fp93Cmu+e4MwnXqC/BLgeRBsRMXe2D0wVYZyOH7kFHZ
   n4Nz527aaG3z+S8gHlOrBCainkeoNdTpSKcVgdF41GlGkoy2cOXTn0Gdp
   AFcxhioJp0qA9+dwVsvfg43gPq4zqnw/C4ax943hcxNK2MpJ/J4z0+sS4
   SbIr4E1zs73xAmwIHtryAKFx18iC7faVXlOgDfIZJf3Zn6OPbgACrjvtu
   U904KcVpFYMwtFjJvPbDkKNVg/T4R6akULftJMNsUXhhT7RNWPpqmjt4f
   w==;
X-CSE-ConnectionGUID: wCEE8abaQMe8HeVo7I38qg==
X-CSE-MsgGUID: yUPhihFhRhK73UVvysNMlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="79333761"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="79333761"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 06:37:55 -0700
X-CSE-ConnectionGUID: MN+T9jfvTjmxI4McGb/afQ==
X-CSE-MsgGUID: z5TctSXxSluxBHIgZJvveg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="233138202"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 06:37:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 06:37:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 06:37:53 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 06:37:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+yc6QLywKMkHa4BLJsNcDlik6dC7GDjqT+AJk8l7hsYUpYuEjCR4Z1gQxV6DFGCQhkPswZsSGrq0Mb5Oes5GVrcgkNNn7zCezMLjnksrLyrca4b6YF8zgj+i7Q4CP1tOHt/48jZaXMPzVEQMwiJJ3sjul9LWUxppd2Mcb97GJ1lobjBcMpsdqEqJf4AXbJliMbYI51cIn9cvg0Mw5m3TRM7gtB0SrA+e3EUJ37hvXRwLyZ2Vm29yl1x/y0lE7i8v0Mrvi/MSyOfMVJSJ0FU9PMd4ewAPBr8/8LBMBFAmgAircwQR2f99SPwRBFOHsNYCmU+qZ7qP1sPQwtYbO/c7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsJjdSZ1DT5PmW13JD7pW49ipZCm7qYwTbvutj1DnO4=;
 b=dRv0aRT3VQw7+iIHIUusBlfbcavhr9vj9HUiz0754klgQS9soWjsl3U+uZNSISQ0pSv+n1d3kKpEhQCKGxlHUTJs6dIUNpOOqOeJRAz3KEEdZCdjPeQyYdvfKk5zLAiuHLgLnLaBPOvGA5jr+6ryFrJ2G+aEEPHfQ2e4hOC2jjskmlEKOZkHOjrJ489jg9ubrfQWprWmRMpuA14kqM/3H9lGT/KWMYJ2nuQLzv+EfnL9NzYXXUWexJbNwonvHAwQoCxeFsvjzmALQfgfc1lXDPjxOxG5CCV5LcstnR71t8utkRKz2Xh9MSHTTCNo53qMb/Y07c5HgqzobeawvbLysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 13:37:48 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9791.032; Thu, 9 Apr 2026
 13:37:48 +0000
Date: Thu, 9 Apr 2026 09:37:41 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>, Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	<joonas.lahtinen@linux.intel.com>, <aravind.iddamsetty@linux.intel.com>,
	<anshuman.gupta@intel.com>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
	<pratik.bari@intel.com>, <joshua.santosh.ranjan@intel.com>,
	<ashwin.kumar.kulkarni@intel.com>, <shubham.kumar@intel.com>,
	<ravi.kishore.koppuravuri@intel.com>, <raag.jadav@intel.com>,
	<anvesh.bakwad@intel.com>, <maarten.lankhorst@linux.intel.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang
	<Hawking.Zhang@amd.com>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 1/2] drm/drm_ras: Add clear-error-counter netlink
 command to drm_ras
Message-ID: <aderpXuhLoiUoxcT@intel.com>
References: <20260409073318.2909379-4-riana.tauro@intel.com>
 <20260409073318.2909379-5-riana.tauro@intel.com>
 <e7978696-eff6-4c1f-ab0f-047dccb18b59@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e7978696-eff6-4c1f-ab0f-047dccb18b59@intel.com>
X-ClientProxiedBy: SJ0PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::15) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|LV8PR11MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: a197d617-c87e-4295-9327-08de963d2fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: LF7HQnh+7fmbl9aqHRgplvONz0rYwyv9+P93NUi1Fbsuy1HV7386S4CLOXaZuzVkSvS9QNi3+gERcI+OVv/OJjz0qZIDSDKTfAYATWO092z1LfLu5acb1e83ZvPfnNyacIs+eGCJ1S8WeqQ4GkymM0LUFx5WN9S6KcsepLfkzeKdy4svIKFObLaGKw9hNoC0/YnRPKYvW57BXYJq8OHd9uQZU5dVCEgFjPOzusoqIf18JGaO5cucyJw25+yAKvVVkplzdLaufBwnROPcDhN6mwvKVIRJJty4ghrv8yKDe3uXxBRXaRZ7IDVM59pEbSTB/9uVXA67/v3rCH9/8sBjtZNUCGASUe4GuBby5RThU2jyHuVTWED4wSI34Q4q/Kumazmqbwi0HMhd8fpDbSF4tnYvCsNtRIPnv9+dmubAEbpggJuE7MKLitzrPKllD178azIJ7e2XdBsey01jmGWtnB6G6LiE206ubL7fsCoBhPlooFuVC5xKf57xhQRrQ+cdIjro6DK6HRif46w0Je+UJNprl2qUuGTPvBgsb4lZUb5tcYATEgMnOEH3p7CxakTiKyilCDxqbS4BFBe/QaS7GmULMcBoFdsLs5RaCJJW0c0ed1i+3U3Htx59et2gha5y1tpl7nuB1p2gN3oWM/t8s6xFYDdFL3uutsg/VWQiJYZogjEXFy9WszGwQXPRYYrMbTGQNAVErDnCPeZoWImx0WBlTBjnxIpiEnswGYV7LeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qoHrTrXP+fMtcC/LhG4na24wYaicSzVqeGwIq5UY9zzYw8/UyU4WVt6anHt3?=
 =?us-ascii?Q?aiOygejBWCGAjaFQvImtV42nsiAaBCzTrdmCYRo/2QI+Fo8f1tbikR4kptJy?=
 =?us-ascii?Q?q7YDknsjHpxG+iVHPImXwF42BS/boFps3CIyZ3uBxHZbdNHhVOqJQ9jDtpeA?=
 =?us-ascii?Q?aY/GQLIE86EijniPAk229ZjKh/EX6ERzxxr+VqOwW511xk0GvwkU/B5R9iRO?=
 =?us-ascii?Q?q0kydjyRl9aYK8k3WcqFpJWTxvcvMH5tjy/tIcnKAW78FW6uEwI6Za9T2g+9?=
 =?us-ascii?Q?8d0OrMPvqJ2G+4yja0aOsRaNjG1Ht/eaBgwjAlQZwoCKpVJ3osqmHsN5lg1L?=
 =?us-ascii?Q?KwvA4vRTvkt1XDYErU6EnJdNYsx5BiWAXKGQ0P561mYkUvoD/Q9JGf5YXS7D?=
 =?us-ascii?Q?3zjjG2KtqmzfQhHs3k9DPTXj4bRRmPKe7+MPXaeE45SHPbqrI68jV1zK0//s?=
 =?us-ascii?Q?zB+DqanRVfOixxMvlsKDbomnM8ijuYnQsZ9N/McQXaM5XVm+z9CmxVMqEGyj?=
 =?us-ascii?Q?iDVPnu/yWxY5BhH75XUV6xNCz2FgsmS/Ea1rr/DbKh+6CkeK7pVX/f9xZxiI?=
 =?us-ascii?Q?pcs9OXCqoMem+69rXi4kTfXn/sfz3ZIH3VF4+6WXhNDlGBsO9yWm+XeA3TZP?=
 =?us-ascii?Q?0t17rOLezqLQFypD/T1MLO9VpiAT31/dohfjxgnl+DF4+JHDMzUrylX+3bTY?=
 =?us-ascii?Q?wGd/zCIhlcGOe2FglyKWc6sImpQvi2KJqFxGxSB62KGJfYQgY74QuFIgQ1bQ?=
 =?us-ascii?Q?Xgrl/FXrA9IOE5Dqk2SMh7CHt33ti5KmvZC8Em/1HgAY5smQEK6dCa0U05kH?=
 =?us-ascii?Q?iERROYFTGK0UpuRyS25+0A64g0e1oL5XmS+m2pPGoOUz7FBR9bZfoKHSm/kx?=
 =?us-ascii?Q?rH40KF/paw3FaDBgOuBzv3kvIHH5Jff+g80ioZajeUAz+XlzEeUFGdqE2LaK?=
 =?us-ascii?Q?60Q+DVrlJ1r/rf/qnLUYQ9yr0/5B3XjMRBZEQTFrc3KlOD+trP8qeBBkUGqP?=
 =?us-ascii?Q?EWMYyJD1QtjkL4j8DQ5KvlTkdl8X6MIhsGndMyyOaQ1vb446btfBPB8LqcWU?=
 =?us-ascii?Q?CIa3UoBHXvxbaxrVI/gUOpJvgsasWYpsgOM8WIq/IInUgPE1LJqmc95Kfh5A?=
 =?us-ascii?Q?B9EaNCDJC0s19IdePGMuOPBJP01IUBqIxprmStD00br13mPj2PManFzsV6fi?=
 =?us-ascii?Q?Rwh9+u7UBI0VYCgjua5fp4hBKJVjS5jlrpTBlrqXb7HiwmMcjSbRYQABKDC6?=
 =?us-ascii?Q?1tjRRw2jY7nUSQ4tA+7yhcQOwTGI6GHa3sDJluXho6mKo3PefXjY1xbozJWY?=
 =?us-ascii?Q?VSlNti9SlYVYsO3VVNjG1c+ntHeOu0vjEdy4yvvwgjWOJNGZk5ZqnSogVvCk?=
 =?us-ascii?Q?o8uQM+zwuxFWklke7FoXrD48o6Qc/98kpZm45rqTucxG9fny4wOJ12kF4KpV?=
 =?us-ascii?Q?qrOkQytrhaClvGuFZsVla5SjCphnQwzkZpz+R+/mQ2EYavw2bAup4lNfLyW6?=
 =?us-ascii?Q?eT2Viy1rVj21PhLRkYEORTZTJtzxAbugwsbVmxxqYQ6vmdVjO/l9y36uoO28?=
 =?us-ascii?Q?YNDdI2nGVjfQUNsWstQD6ie2XqQou+6ImpQy055Oo7ocTGmuNFf7z6ZtE/KG?=
 =?us-ascii?Q?G93S+bdXHTCzU42wwNhdguptMkkmr2ci1ugLnRQSNmINIx8XgnM0Ztdmn+fp?=
 =?us-ascii?Q?+RQn3EIVNmImaaWxxBeDW10Z6eIsW56Fv6Go0xx/sk/qxfAaZsQ7fpj0SM8K?=
 =?us-ascii?Q?XJdjL8g5WQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: Rbsh/bjVMK6/z+f2BWEp4o6CWLJ1hzIFZyHnfbpb7b/puQMy7B+Dqwfzp8561aWe5x/j10G2Farw1fnpyOoghh1JcW7IFvaO7+v35gNpxB+zd02sBTXuCU8XR4HSKJfxwONoELLR8CgdpF86EWTmv37YXywjDTZxXj0B4JmeSOwFj/T/vgyNN++eDD5gDS0EZh1XnCtqWwaf921Nq5hpwZWxPyP53Gh3/kOUZgAIacK10vHIcFagYbk29RPjDDySlaMSaHCOvjQvzRV899tr3XltFuBPWKfhq5xDz866ZmELV8zCO10xo/3eMJbEAxmW/VuKM10CiQEI8IFT44J3EA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a197d617-c87e-4295-9327-08de963d2fe4
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 13:37:47.7502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTisuKE3sFUTubAskyWW3kfggmRAtrdIuLVajMxSJD50d5I1I40yeJiArT3/OWV5L6/3/udvWYZPxmBpACxdug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8509
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,oss.qualcomm.com,linux.intel.com,intel.com,ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com];
	TAGGED_FROM(0.00)[bounces-277012-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,davemloft.net:email,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rodrigo.vivi@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 298D93CB786
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 12:51:44PM +0530, Tauro, Riana wrote:
> Hi Zack
> 
> Could you please take a look at this patch if applicable to your usecase.
> Please let me know if any
> changes are required
> 
> @Rodrigo This is already reviewed by Jakub and Raag.
> If there are no opens, can this be merged via drm_misc

if we push this to drm-misc-next, it might take a few weeks to propagate
back to drm-xe-next. With other work from you and Raag going fast pace
on drm-xe-next around this area, I'm afraid it could cause some conflicts.

It is definitely fine by me, but another option is to get ack from
drm-misc maintainers to get this through drm-xe-next.

so, really okay with drm-misc-next?

> 
> Thanks
> Riana
> 
> On 4/9/2026 1:03 PM, Riana Tauro wrote:
> > Introduce a new 'clear-error-counter' drm_ras command to reset the counter
> > value for a specific error counter of a given node.
> > 
> > The command is a 'do' netlink request with 'node-id' and 'error-id'
> > as parameters with no response payload.
> > 
> > Usage:
> > 
> > $ sudo ynl --family drm_ras  --do clear-error-counter --json \
> > '{"node-id":1, "error-id":1}'
> > None
> > 
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> > Cc: Lijo Lazar <lijo.lazar@amd.com>
> > Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Riana Tauro <riana.tauro@intel.com>
> > Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> > Reviewed-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> >   Documentation/gpu/drm-ras.rst            |  8 +++++
> >   Documentation/netlink/specs/drm_ras.yaml | 13 ++++++-
> >   drivers/gpu/drm/drm_ras.c                | 43 +++++++++++++++++++++++-
> >   drivers/gpu/drm/drm_ras_nl.c             | 13 +++++++
> >   drivers/gpu/drm/drm_ras_nl.h             |  2 ++
> >   include/drm/drm_ras.h                    | 11 ++++++
> >   include/uapi/drm/drm_ras.h               |  1 +
> >   7 files changed, 89 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> > index 70b246a78fc8..4636e68f5678 100644
> > --- a/Documentation/gpu/drm-ras.rst
> > +++ b/Documentation/gpu/drm-ras.rst
> > @@ -52,6 +52,8 @@ User space tools can:
> >     as a parameter.
> >   * Query specific error counter values with the ``get-error-counter`` command, using both
> >     ``node-id`` and ``error-id`` as parameters.
> > +* Clear specific error counters with the ``clear-error-counter`` command, using both
> > +  ``node-id`` and ``error-id`` as parameters.
> >   YAML-based Interface
> >   --------------------
> > @@ -101,3 +103,9 @@ Example: Query an error counter for a given node
> >       sudo ynl --family drm_ras --do get-error-counter --json '{"node-id":0, "error-id":1}'
> >       {'error-id': 1, 'error-name': 'error_name1', 'error-value': 0}
> > +Example: Clear an error counter for a given node
> > +
> > +.. code-block:: bash
> > +
> > +    sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
> > +    None
> > diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> > index 79af25dac3c5..e113056f8c01 100644
> > --- a/Documentation/netlink/specs/drm_ras.yaml
> > +++ b/Documentation/netlink/specs/drm_ras.yaml
> > @@ -99,7 +99,7 @@ operations:
> >         flags: [admin-perm]
> >         do:
> >           request:
> > -          attributes:
> > +          attributes: &id-attrs
> >               - node-id
> >               - error-id
> >           reply:
> > @@ -113,3 +113,14 @@ operations:
> >               - node-id
> >           reply:
> >             attributes: *errorinfo
> > +    -
> > +      name: clear-error-counter
> > +      doc: >-
> > +           Clear error counter for a given node.
> > +           The request includes the error-id and node-id of the
> > +           counter to be cleared.
> > +      attribute-set: error-counter-attrs
> > +      flags: [admin-perm]
> > +      do:
> > +        request:
> > +          attributes: *id-attrs
> > diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> > index b2fa5ab86d87..d6eab29a1394 100644
> > --- a/drivers/gpu/drm/drm_ras.c
> > +++ b/drivers/gpu/drm/drm_ras.c
> > @@ -26,7 +26,7 @@
> >    * efficient lookup by ID. Nodes can be registered or unregistered
> >    * dynamically at runtime.
> >    *
> > - * A Generic Netlink family `drm_ras` exposes two main operations to
> > + * A Generic Netlink family `drm_ras` exposes the below operations to
> >    * userspace:
> >    *
> >    * 1. LIST_NODES: Dump all currently registered RAS nodes.
> > @@ -37,6 +37,10 @@
> >    *    Returns all counters of a node if only Node ID is provided or specific
> >    *    error counters.
> >    *
> > + * 3. CLEAR_ERROR_COUNTER: Clear error counter of a given node.
> > + *    Userspace must provide Node ID, Error ID.
> > + *    Clears specific error counter of a node if supported.
> > + *
> >    * Node registration:
> >    *
> >    * - drm_ras_node_register(): Registers a new node and assigns
> > @@ -66,6 +70,8 @@
> >    *   operation, fetching all counters from a specific node.
> >    * - drm_ras_nl_get_error_counter_doit(): Implements the GET_ERROR_COUNTER doit
> >    *   operation, fetching a counter value from a specific node.
> > + * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
> > + *   operation, clearing a counter value from a specific node.
> >    */
> >   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> > @@ -314,6 +320,41 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
> >   	return doit_reply_value(info, node_id, error_id);
> >   }
> > +/**
> > + * drm_ras_nl_clear_error_counter_doit() - Clear an error counter of a node
> > + * @skb: Netlink message buffer
> > + * @info: Generic Netlink info containing attributes of the request
> > + *
> > + * Extracts the node ID and error ID from the netlink attributes and
> > + * clears the current value.
> > + *
> > + * Return: 0 on success, or negative errno on failure.
> > + */
> > +int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> > +					struct genl_info *info)
> > +{
> > +	struct drm_ras_node *node;
> > +	u32 node_id, error_id;
> > +
> > +	if (!info->attrs ||
> > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
> > +		return -EINVAL;
> > +
> > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> > +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> > +
> > +	node = xa_load(&drm_ras_xa, node_id);
> > +	if (!node || !node->clear_error_counter)
> > +		return -ENOENT;
> > +
> > +	if (error_id < node->error_counter_range.first ||
> > +	    error_id > node->error_counter_range.last)
> > +		return -EINVAL;
> > +
> > +	return node->clear_error_counter(node, error_id);
> > +}
> > +
> >   /**
> >    * drm_ras_node_register() - Register a new RAS node
> >    * @node: Node structure to register
> > diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> > index 16803d0c4a44..dea1c1b2494e 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.c
> > +++ b/drivers/gpu/drm/drm_ras_nl.c
> > @@ -22,6 +22,12 @@ static const struct nla_policy drm_ras_get_error_counter_dump_nl_policy[DRM_RAS_
> >   	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> >   };
> > +/* DRM_RAS_CMD_CLEAR_ERROR_COUNTER - do */
> > +static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
> > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> > +};
> > +
> >   /* Ops table for drm_ras */
> >   static const struct genl_split_ops drm_ras_nl_ops[] = {
> >   	{
> > @@ -43,6 +49,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
> >   		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID,
> >   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> >   	},
> > +	{
> > +		.cmd		= DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> > +		.doit		= drm_ras_nl_clear_error_counter_doit,
> > +		.policy		= drm_ras_clear_error_counter_nl_policy,
> > +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > +	},
> >   };
> >   struct genl_family drm_ras_nl_family __ro_after_init = {
> > diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> > index 06ccd9342773..a398643572a5 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.h
> > +++ b/drivers/gpu/drm/drm_ras_nl.h
> > @@ -18,6 +18,8 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
> >   				      struct genl_info *info);
> >   int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
> >   					struct netlink_callback *cb);
> > +int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> > +					struct genl_info *info);
> >   extern struct genl_family drm_ras_nl_family;
> > diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> > index 5d50209e51db..f2a787bc4f64 100644
> > --- a/include/drm/drm_ras.h
> > +++ b/include/drm/drm_ras.h
> > @@ -58,6 +58,17 @@ struct drm_ras_node {
> >   	int (*query_error_counter)(struct drm_ras_node *node, u32 error_id,
> >   				   const char **name, u32 *val);
> > +	/**
> > +	 * @clear_error_counter:
> > +	 *
> > +	 * This callback is used by drm_ras to clear a specific error counter.
> > +	 * Driver should implement this callback to support clearing error counters
> > +	 * of a node.
> > +	 *
> > +	 * Returns: 0 on success, negative error code on failure.
> > +	 */
> > +	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
> > +
> >   	/** @priv: Driver private data */
> >   	void *priv;
> >   };
> > diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> > index 5f40fa5b869d..218a3ee86805 100644
> > --- a/include/uapi/drm/drm_ras.h
> > +++ b/include/uapi/drm/drm_ras.h
> > @@ -41,6 +41,7 @@ enum {
> >   enum {
> >   	DRM_RAS_CMD_LIST_NODES = 1,
> >   	DRM_RAS_CMD_GET_ERROR_COUNTER,
> > +	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> >   	__DRM_RAS_CMD_MAX,
> >   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)

