Return-Path: <netdev+bounces-110897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C175092ED50
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 18:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADF31F238DC
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 16:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A168216DC30;
	Thu, 11 Jul 2024 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkhDVWTd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A364D16DC26;
	Thu, 11 Jul 2024 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717062; cv=fail; b=K6Thy1zplnZfOQSre0ATXyqzIFvIV2iLYX7W5nVX4FMSCohdIomLuo0tbWiGVAyFMA6w2KdiMyUWqTiiKtg89bfQwJMUGgpDceYdSB5rNlcvuNHHi+kxG9gUSQziG0A9yDy4gaxCTL8/UTIQauC2xGfkgnnNCpHicaoF7BXg/cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717062; c=relaxed/simple;
	bh=O1Gy10+JdIePOV47JrDBN+/bRtxCl3NkMF8zShbpQPg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OWijQadr8yVGgBnyrautOU+Kq0+JatYeHwC1sPXz7RLIKJj+cP5z9mSGAvMi1lVRgXRy0O5NbWKim5xgcE31BgE4slVgfm541Gm6bWCXdVTirfXNqVDW4vAxZHYHwp/8ceZmYustStu1QzaNhMMRaieOJ9c76iZXb4uihSVTt4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkhDVWTd; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720717061; x=1752253061;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O1Gy10+JdIePOV47JrDBN+/bRtxCl3NkMF8zShbpQPg=;
  b=UkhDVWTdwAJQvcTlaYlr94f84t+ND3TRMqox1Y6xBpAuXHs/5igVYNle
   8XlzK7eUxA4ThkgyxEMKHXmnSc5I7x5f6/Vdeo51Dr2tsAcXq5vZ7p4UR
   JPusDae6F/HIFat6nIdsN7gR9PMX8XQPZ9et00KzOFy4Hh+eTThE2xEq8
   y/c2dsCFC9EfhM5Uo2qpaxzQqSuBvRxqueFpqbGDkps/ePTkLKNrptnFY
   NezK0NhMXe8ags9PNl5J+MCrgpYELyr82cZmMHyUsf2BWbFperHhhbcEL
   ZhhH9D7gJ98RGEu28TwrY+M33KkjSH2BaQbbbcdJ68LdrxGUeEM3yC54U
   Q==;
X-CSE-ConnectionGUID: WoTRa2+ST8GCsXsBexOYkw==
X-CSE-MsgGUID: DYW0xn40Qf6CW5JLTq5XWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="40639541"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="40639541"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 09:57:40 -0700
X-CSE-ConnectionGUID: cTCNsnsWT4G+X/zf1lk8MA==
X-CSE-MsgGUID: Akuvjwt0QZqMSPAqfyTPsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="71829980"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 09:57:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 09:57:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 09:57:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 09:57:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyQwa7N1nLbEnz0NG7vqTa2rvqrj1lO9hmM7m+1cQydjTA+0tnuawddjZIijSJJxy7VWO3m9JsFz2TfOXEEiQ4mSPsoyB/9nXf7l0hq/NMn3q/wGKWbmCJjQS6pd1A04n5YnILwrYQgEBEqO/8E4y2BkSinXR65iFWF4y4htstzB+kIiizAdSS7QQ/PeVtcWzZLsaZLAFg+XgYBTVoJLJUaWuoDc8/YW5aCB8sJkUxlCWKpbEMk5MNv2b41E2Jc0alfqjQaxoWKWgSaXj8ghFursiVgq6luR1MoqigjnNjob7LzcFLOmEV1n43zy9ssYhMq/pvSlYtGHzvEz27uGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTjKbF9P7Bns/NL1FlwebkmELce97/ikiqwMhSfjo3E=;
 b=dd38RF+gCIhQvVQrswY3Xyzv4getF0xndZJRnN8h4Yb9jBdX4sPlLNM8SqPJOM8dxv8Be/xPS6u9nJ2UQ0CT+ZEC+K9Iu6f2ab7J1xpaf4C8vmCZAnS34exfcQKGtQIM3RHOzPcK4SA1vR6QujVgbRwcVeUmeGgMX12uU0X5DWoJXIOjRTFr/0qMzxArvUQpEnK1GpVrVX+FG8o1f1jdPN7wzX1uGFQCsEdyIkjVMO3Q14rLovjO8LZNG5wkajZad+zQiYeInJERqnZsPPqwTfK6cw2jCFllgHT9wop3aLqBmln5a579B9CB04kRIhlmR0vPNI/LCc6AfgG4fQefkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7191.namprd11.prod.outlook.com (2603:10b6:8:139::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 16:57:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 16:57:31 +0000
Date: Thu, 11 Jul 2024 09:57:29 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <admiyo@os.amperecomputing.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jeremy Kerr
	<jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v4 0/3] MCTP over PCC
Message-ID: <66900ef8e7c79_1a77429414@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240702225845.322234-1-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240702225845.322234-1-admiyo@os.amperecomputing.com>
X-ClientProxiedBy: MW4PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:303:b5::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c3639e-48c9-464e-a01f-08dca1ca8da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sG+FRkWgV0AxGNybSDrtzXT9z5BhtFQuw/41frhfEIyMMeM3+fshviTs+2uV?=
 =?us-ascii?Q?NaS4wnfqnV9FgyBMBM3OLVDeoUbN9Se28JNZR50doG28CmuFrVuh3j++b7KX?=
 =?us-ascii?Q?IRUTILM3UEvOqWN8EkDqNErvc8pCFbwSZikvLiaAKcCEcdMIGRLYONiA8MOC?=
 =?us-ascii?Q?powrXdrr0lhDTGc/+B4GPWt7td+SZVNiHwPq8y/+sw3a1m+N894ZUrqn4xXm?=
 =?us-ascii?Q?dIYi0Dn/gQs2lH7C2YrxLppt22gBxQuYtqla1lWeLju0NcuT3/bA4jW20ZwN?=
 =?us-ascii?Q?5zLCWgaiRlF7R1cGua8VpNlVxTB4RJqlcBVgzjRdvaSthKPbvlyZjxlIooCq?=
 =?us-ascii?Q?hgaEzic0fUmDrQ2LbdjKg/2AgcfOCts8VMiomFp/5v/Qwv3GvYNj0yzRAh7g?=
 =?us-ascii?Q?WyWxilLtBnqFpBOIcChnkZdQWjSRIMmsWudSGuSH5vPCiz16LUeJrJ1YbqT1?=
 =?us-ascii?Q?3+isJ8cXXK8GlRaAPHBzEl+w89rECbKJOElwBtDXqF/AejRTnJC7Fk6SKqii?=
 =?us-ascii?Q?wr5mkDusgCg9vJ35iwilUQDEjmeI/en2lf86bUDWQsFKV5skmgyzzuQ69YAr?=
 =?us-ascii?Q?XrIhlSMNHVb/BChmYtq6TZXbA0gulvoOpi/2eC5Bbq/+DTj+EqlvuHGU1Z99?=
 =?us-ascii?Q?RLi9xbTEBQMelqTPZciJgXpyYo5snwuwhBDj3UX17lVySpnTzU9MxtxnhhDE?=
 =?us-ascii?Q?+KBChFB8BbCyQ6JP62bBhPjPZeselmJQ1Qmy2ghf8iA3cFZ87U+261gWr4iW?=
 =?us-ascii?Q?jGjwKN2qKeZGuCh0qSHKbGeZDwlv9wwfRJRv2hzyctlpNBq7hDbfHtXahrQs?=
 =?us-ascii?Q?c1Sc1yzEhHcGYChQPgtiFRqDGAGIj98GomPV1NFHBHcO5lUWBdX6+qC62WBb?=
 =?us-ascii?Q?FuW/7URm4XdLEXmjtNfiyXtAE0y2DfSbhf3qe7qEV12BFH1/HrfkraFlbrV6?=
 =?us-ascii?Q?vW102FH5AVqx6cLhhNM9fGDqG5wgbABROU+3du9U7gMVps+zpJVmJl1eHQGX?=
 =?us-ascii?Q?T6NS/q2aX0m2HY4SJsbf8MF0cypHcSohwHW2fXOH20rEffxVQMpJNPQWqTAA?=
 =?us-ascii?Q?cWZq0GNhlhi3PBV+hkQ0EH72Pt2TsLckYHmtD/SDXEll/9yhmhx5FLIdWgkb?=
 =?us-ascii?Q?ylLcRF3RAlLNrjyU9kN9ezX9O5uyS+5RimqIknipDMi8jzhlaPCB+pc2lRfr?=
 =?us-ascii?Q?aRh/B6bN1RFiYEVcqxg3vxpFgY3MOf/WwtrTLE2ScidEZVQzAHzUQmCIiDBA?=
 =?us-ascii?Q?lZGsMfUvckcKQar/538RJB4FHgX91uH2H4vQJ3q0CdtGhogK192MGcx3kCIk?=
 =?us-ascii?Q?yTpOKiEahjseiKFcB8s9TRMAvCrQ+12H8lx1T5sBbR6y1A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GwpjW9IEIJX+Dg0Y6Xk62z+ct2xapbCHjjngpMSKYbbT6Kekh9vpDwRMkTqg?=
 =?us-ascii?Q?6FdAAQEkyoaGf8j+sQ/qwuOeeN6rHGpL+NqrlGrC/EGOQ/cM8fbENXoIbomq?=
 =?us-ascii?Q?f7+6GvFT+p4Bem/1rR9pfFOWebdKoYaP3v1hptC5AG0OWCBM2WHphf8yIyn2?=
 =?us-ascii?Q?zvw/3zXyHzW0WeJWzVfVkYjL06Ta9VTEHHNIGn7bX9kag4y5uw3xAg+JunCX?=
 =?us-ascii?Q?4x6RGhHnM9I5W+3iq+ZrWDLVe5GazAFWiQMjJJkKyzeb7mkddjkCDIEXF/p1?=
 =?us-ascii?Q?qqdGomHMQ+8rm///YtOtt+eH0ddjdv4nfOtuqPrqzIdqhT46D+AngpTqmjKw?=
 =?us-ascii?Q?3QglqaXxyNs3Uo4UeSGTHfF2L0CNwt6ktkUYWuPt3/1CRzhwtr//hUMe/jJR?=
 =?us-ascii?Q?ZdW6w2sqOCDrdkKivTc5d1Rbn1J+V+TWFDg0swyHY1cgoxKdJ/LaYxEjd6EJ?=
 =?us-ascii?Q?Fiakyuvdwml7mVhhas9/zKnYpWSG4kMjc1zUk3EAkOj1cTjLnBpICVP3r+kl?=
 =?us-ascii?Q?53aoWTHZhSVOXDtEiJOFVt4Akz2PDorwm0A+O7jrz+brUjKoc+mM6AJMJShM?=
 =?us-ascii?Q?ovJzRduWLt+UE6ghoPerpfDQWPNZQ+YrLGTg9UlrE1j3g8IwAPSFlrD/m6M1?=
 =?us-ascii?Q?nY+k24nQlTmcAAqAXOY0/e+s9d4I+QL0N3ckjrLv1XVYJ8zmKIRFn5Z2tPhw?=
 =?us-ascii?Q?/zAbtceGKTD8N5RTqglrczfjcqUt7krl3FicnON3MjrCn2HPERzJOZtiCVXy?=
 =?us-ascii?Q?gMELRJbt06nhvWEuCK1tZKlOFQ7ll7KsHot5nB/AtQS8nALZ0USX03t5ZLSQ?=
 =?us-ascii?Q?9xf1NV3Pr6cwg8Rcw+iXKWJi8IX7ucocAwkMW85HR0fgyHSkGNRJwbZVg2oJ?=
 =?us-ascii?Q?7uX83dnKjqHxtmjZ36HvzIq5g+vc1vuqp31Zh1pHyLhllDFmhE7myoKwsFJ5?=
 =?us-ascii?Q?lHRqpWGoHV8iGy7HrYMFAIWbVcUqLzFiy3yUERrPe+JAKilADltxFYH5qHQK?=
 =?us-ascii?Q?nXL0gYahxhGxb9Ae14kNuexSIBkMhT+gGjyEFsraVGzxL0Czq8+gMNWfCeU8?=
 =?us-ascii?Q?6k24TGh/0/TYg+vmADepI9NWF4RMY5DXhqEL5neXD9rL6cAZVeqPVVb28HUY?=
 =?us-ascii?Q?aXIChkJGYXBg1Wh/F2HQcXeoHWhrPIC5HsmVG+CbBZn2rmPvm9ziJG7x3UK6?=
 =?us-ascii?Q?Hlh/ovHGrBgq+YyIFQo2BLeUm8iX+ZANVDgWW8gE98jdyt1622NxK4jbIEMa?=
 =?us-ascii?Q?rvYOn8zfjHb+OXx7nwmvOy7a5nv1tWajQ9cvqpMD6fl2r74lo4YWf/56yVUC?=
 =?us-ascii?Q?WtKbjGJQ1dSGBDjHcHB3Rjryzl2NC5LcDrcOtl96v+FYX5BZiTL+v8Qj6rEa?=
 =?us-ascii?Q?Wt9X6Pi9xjxtbQdzYc596sHSt6ddDRUOeCMG1uj2Vs99OkYmDI/gcdluHI8x?=
 =?us-ascii?Q?co91Hvgf6m9Jzzi7jxn2aSwiZ2sCBEhTWKTGJUt6rQjQa68wEZ8cNYBCgG6X?=
 =?us-ascii?Q?DkGXycb1qCPR2V+pVvifi7au71efj/G8dxDxdtxVHaSOpJYGpccB/LPt1ADm?=
 =?us-ascii?Q?v+W7UaxhRj6rGovnQmf5yiBV1+vls2kAjGNpVXuFj5Ev9efu9B5kUdcfxwes?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c3639e-48c9-464e-a01f-08dca1ca8da2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 16:57:31.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lI2sJNTHvTJdxx28EBaf8ZO4LuKLcbgITk+WS3daplFSeTs4TweE6tcenNvfZT4OgVRhXL7QafVUvMB5vcTgzwJRH4Dtwtimk2+kRZdxAu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7191
X-OriginatorOrg: intel.com

admiyo@ wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> This series adds support for the Management Control Transport Protocol (MCTP)
> over the Platform Communication Channel (PCC) mechanism.
> 
> MCTP defines a communication model intended to
> facilitate communication between Management controllers
> and other management controllers, and between Management
> controllers and management devices
> 
> PCC is a mechanism for communication between components within
> the  Platform.  It is a composed of shared memory regions,
> interrupt registers, and status registers.
> 
> The MCTP over PCC driver makes use of two PCC channels. For
> sending messages, it uses a Type 3 channel, and for receiving
> messages it uses the paired Type 4 channel.  The device
> and corresponding channels are specified via ACPI.
> 
> The first patch in the series implements a mechanism to allow the driver
> to indicate whether an ACK should be sent back to the caller
> after processing the interrupt.  This is an optional feature in
> the PCC code, but has been made explicitly required in another driver.
> The implementation here maintains the backwards compatibility of that
> driver.
> 
> The second patch in the series is the required change from ACPICA
> code that will be imported into the Linux kernel when synchronized
> with the ACPICA repository. It ahs already merged there and will
> be merged in as is.  It is included here so that the patch series
> can run and be tested prior to that merge.

This cover letter looks woefully insufficient.

What is the end user visible effect of merging these patches, or not
merging these patches?  I.e. what does Linux gain by merging them, what
pressing end user need goes unsatisfied if these are not merged? What is
the security model for these commands, i.e. how does a distro judge
whether this facility allows bypass of Kernel Lockdown protections?

The Kconfig does not help either. All this patch says is "communication
path exists, plumb it direct to userspace", with no discussion of
intended use cases, assumptions, or tradeoffs.

