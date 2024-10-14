Return-Path: <netdev+bounces-135106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E3399C432
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B7A1F22A8A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47EE15666B;
	Mon, 14 Oct 2024 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/N5vJ42"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC2C156230
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896098; cv=fail; b=oEla9/BXfkvjW1BE70RN+h3UZ/EfAxeDcLkNiZzHhyOj+7HlMpvIRLkiG6FDjofRIE/vmSeGXuSuEzPa1IX13yXmdzjFfkM8L8OEFAWqyQY5RVSU6NtZbWVLPJ8jY1oVnm37AgchToiGQLUxwUd62d+0YixcQNBh62fb4/Q1o14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896098; c=relaxed/simple;
	bh=JRHUvDJtDEraLNju8aQeRuEmjG5G6Pw9/CRf1OVqEfU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oiy3rOHzpOGs4nclJLySB+NvUheA2sHTzS+Ic+sdrPIuEjjvxQyWenjOlqYOIvN+WQFsJ/95nsfLxST1H20xAoxrBXyYGRTtchPwhp+T4Ofme4wbDF9zddjW0IlbLcCWOUXDnduxuDcDzmW2YxBJ2aCUBIrEPKeLzrB+uKOm+y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/N5vJ42; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728896097; x=1760432097;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JRHUvDJtDEraLNju8aQeRuEmjG5G6Pw9/CRf1OVqEfU=;
  b=T/N5vJ42atE/jCQvPI/yQkw/oxnu2IKZ+/2JoV6qWhb7Im6Y7gkTjMDc
   br4o2IWkuA2Nx9Fj02EKokH3BkvsOWt+13USzJaxxAfbbM7PTvKlmhYBc
   Jm7SQVYEdFlG7OvriXbUG5Cdq1AvDmmvfj/9RwzTu4SjnXK1s20hKMVRe
   e1s6T9SHdQrC1X4W6UVMCkrJ6suUYnjc+tw03mSmZWmzivesi41Ns4NAu
   2/De46Vr5dh4ECY+P1sBmh2+scNV6eJcCvILSM30KsSAbqDi0QneQGIeJ
   YrhefLd5ZKG7U0d1uVnnBtqRVLk6SOYHrKOC/pfJwyLkyv6eLVZAm13Iq
   Q==;
X-CSE-ConnectionGUID: BMOjGoWMQYK7+JZTMb12hA==
X-CSE-MsgGUID: sd+IsewDT4WFmPQ8KeACbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="28316215"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="28316215"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 01:54:56 -0700
X-CSE-ConnectionGUID: FFuqvOGpQGCErrersCMKeA==
X-CSE-MsgGUID: uL/0gHQBRQi9YCz9hmFZvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="82539486"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 01:54:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 01:54:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 01:54:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 01:54:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhOQXXcj5ANhGRpeHJSCnrSwy1YLz6q1KihIXPAl3M8JNq4YUpdTobgjIIzeGLIjh39B1TV1t/H617UNI6Flo19SmjjlhfEsFJ4D4zJl6WcQOTVunJlVKxghYh75LBTIFdkZgpbwwOJ1j9OaBtxfQ76D6r/KWBlR1PTWtv5L67ukJq/rslkgF95Klk5Nv876HxnvBj9PbG/+OjVJVNa097NQ10uv7T+3rMNxGoPoeT7MzTepuQnZu5VzAqMYdy1chIFlbqV0SMaVCccnelkueUWC+zbAyld3oYHG41U+hXkartPbYhNgc0madC6cib/5hxu/me5G0xQmLw90cFRRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECvALRmoZoBh1bl6Isqo6BepqVQm0CfHxxQLH3NDxNI=;
 b=KzuSjIhkqOXXzE0w4jfmByn774IJZ1xv+Zx2fbLkUBJWue0nNd5dkGFhjf8nFwt0ZaUpLbTj7S+h5vy87nmKvsMoJRT0G+tWl8/aJWISA8+uFSQEtUYdmMgMTEvhL7ScmRH7rBqxIO69qfeYaahYL3akBkkbhpEfcwM162QDByJKuP1s520R8lmsgW9BClQX+Kw/pLWzr+8GAZ3g1bIaMGPPzL+2xTwF6zAsb/KyQYUpmy1qrmopC7XRcGj6Ya6NaovdD0tW6Fu8fxlcvQdgb5k4pbz0w5+sAWTjxVfNmdcwQ68oYHFm6HNsGMw4ohV7wA0rkJdsrWr3cao6Kah8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SJ1PR11MB6130.namprd11.prod.outlook.com (2603:10b6:a03:45f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Mon, 14 Oct 2024 08:54:52 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 08:54:52 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>
Subject: RE: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
Thread-Topic: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
Thread-Index: AQHbHhC84xGRVet9yUe/NQ4Vm3QmorKF8IWg
Date: Mon, 14 Oct 2024 08:54:52 +0000
Message-ID: <DM6PR11MB46573B295F2AE013DA758D979B442@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20241014081133.15366-1-jiri@resnulli.us>
 <20241014081133.15366-2-jiri@resnulli.us>
In-Reply-To: <20241014081133.15366-2-jiri@resnulli.us>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SJ1PR11MB6130:EE_
x-ms-office365-filtering-correlation-id: 923d4944-f6da-479b-d732-08dcec2dde4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KcX10FVH4G4d2KoHO3R7IcP6CtJs4DeYuFMKLP0LOaRnQelKGqOXVF849zZR?=
 =?us-ascii?Q?k3wAJBpPBn4NzvSDJEWxgvvUXjxAjZOFHv4T6YOxboxtNBzkZAh0u5g+j+TD?=
 =?us-ascii?Q?Y77+OWosR0iLgBn9U0Fvm7IdSN9GWSz0y2EPp98a4kqlHSk2X8Ad9gtqBD4T?=
 =?us-ascii?Q?hLKFUKTJvTydqIOWLE2QXZA6owUD6WkJka0FYv3WEe1xQGjlXd/Iq8X5yQ/n?=
 =?us-ascii?Q?6jKjgAUoXjqfit+wH9id8truAjbljQIEU7RMsI6xqatboxOsPPPBasnmdj+Z?=
 =?us-ascii?Q?8KQcOr5dddeKzepsvu3WR8p/E0WHzdtfRxkVt4Ep/dMEkBCJeCAskCOhiqDc?=
 =?us-ascii?Q?jMZ0vjSWMH04Lbsjt49h8FtAQw4G5rSSXY02EaoBbCHgmLv8YOJytyrBMf70?=
 =?us-ascii?Q?FVw7dSlxzQzd9R1P19zPpbNqcu7kQlguhiRtjNXb3EnmECQMomJTTaZFRITJ?=
 =?us-ascii?Q?w4yCFL5SMX6V2uuiY+rIybgn5RyQynpO3O8h8nC+IuKAUGf0ZulJ82dtEA/J?=
 =?us-ascii?Q?i+fmZf2gD/xuQslbS4DgyJZdPDFWEn+AccnPJb7tiv0wfq4AeAQv2WXHOVam?=
 =?us-ascii?Q?X8sEilaPWruMpnPy8iydBzssLgcqQIvoJm0oixaOy/EiPoI+u3CO4BF9YVm+?=
 =?us-ascii?Q?9LHKDkAxVvcIuovMQw4q1xkykByEg6uB8Ovt5aIJKMO+bdy/WfxKIpMe4yyo?=
 =?us-ascii?Q?GaCAHhqsFMiSZJHiRn5jz24/+3Nlr5L5ksRPjHyVPbYJMyr01FfSITOCUQ8+?=
 =?us-ascii?Q?n30DOxXHKupYf8BqZWN/s4XbeBks6REOBrvwhiYfhOSe9pKpjiFzQNxsAZch?=
 =?us-ascii?Q?pYciS0Red0u4IMol5jvWFTOV8XrMy9bM8Iy00FjiRZrVLJCC8nKIFMq4LNhl?=
 =?us-ascii?Q?2+Sd8WbU0LUYBhvpw0aCv01oePcrYFlwj13UYZ9M0Xo6g2L9fvbB7994y6o7?=
 =?us-ascii?Q?TrLuRsHsDgJ85L+O/XjtzQPYkR8Hza3iAd0sZzldFrU7NymjIv85AYkyMDPP?=
 =?us-ascii?Q?bYD4qFodmhK3Bj9id64idiflhP7+llplqPOmydH+T5AoMa2UYhbVuRUEuvur?=
 =?us-ascii?Q?v9Hw8+00hpU8QmCc2buXFGAlERklGqqMoqPhV6dazcXAxvFiV/eAfUHsXd5T?=
 =?us-ascii?Q?upTVJnewYP+pmVuYpVFNMngd9WH0QgIppcU8eyNZkBBsmuEJMJRNXGi9ELFr?=
 =?us-ascii?Q?s8X/MszoIg+IVoEHK6z3Bkg/85l9w0OYLiI5qkA3jpSRggeah4Fp2B+HIRfs?=
 =?us-ascii?Q?9CWXw9rzUAX+BLnWwc9JZDfrhh28J3mlmSQNWer1UoAzd4EpqOMbgiB3oTbr?=
 =?us-ascii?Q?NpI/jBtBxdszTsDu0LOptCYXVkpcCuG5Z/r2HhHXfpUn6g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vE1lDfb7EMwHPpPo1rFQNTua0PCEE8titXPwQPLoUPCto4prdYR4WZTnn5/l?=
 =?us-ascii?Q?ZhLufgm38Nsiik6BKXpkI1P6gAsMOB8EM4Y112mEWBYrAXSivYdrj5VOqVd8?=
 =?us-ascii?Q?bqk9ePTErimBBs4yHrG6CUQfxGZMKsTZUDhPAOQHWftzN13fhSrdNxsouuAF?=
 =?us-ascii?Q?OXL5q4890nXdJAiFtVHZulRQ9enhuBGhHbE8FWzSgZonn/MX0YN+GlEhZ8sn?=
 =?us-ascii?Q?cFMLQHwIUvQN/p2xDQWX4fz39gMfntdy3TxRvDLEqV4+Pkp5sh0lzM27XYAk?=
 =?us-ascii?Q?BpsZpdYDPwC++fmoj3O5zGZG1f74w16YLyvzoAuq2FCBBdMVC2KBl+xgxCL+?=
 =?us-ascii?Q?5OrxJuciuUoHthIpz3XtJRu+62TzfqZnQm2CuNKOUUrrn1KQd55d2A26zw+V?=
 =?us-ascii?Q?ipE8ubgWpsiZtVLt776rPOpf4fRIbNyoQ5q3vCUcRNX8Tfj64o0X5txkKSGt?=
 =?us-ascii?Q?+snggmUJ1P9X+bBnF3jRVJmkh0yjVLuyj+UlLQebKN6ECLcreu5mPks6zCCb?=
 =?us-ascii?Q?69sgiXo6BjokWIWSDXdAp2Sb9+MQm3DDX8QBNucVCCE8Et0oab/Dsh7cwDoB?=
 =?us-ascii?Q?Qzw6WROe6wS5fEf4BGcXbVq/HwI6g4k+0y2uxHkaXGnd5gKk6NdtLrNwGvwv?=
 =?us-ascii?Q?sWCsefvUYE5C3/rdUrvez9kb/b+Qq+gRqV2xjcG6vlO5JcbRkoL9gw8KZXYt?=
 =?us-ascii?Q?BIxdhNPg01fCXLwdeZnh+s3BsRzT02KuKL8ABB31TZcFjJL7/B4CVsTzb2YM?=
 =?us-ascii?Q?HTN5HSZhATb0zNG1nvxz0QKdM9M2CVkKWNPdm/PDEClRD2f1E4BEzsWpRuaR?=
 =?us-ascii?Q?IlAHYHVwznyL8crSjQdaT/HvBbvOIVePsS5EHyeoWLmNPB5wGbUPUf+i3b4C?=
 =?us-ascii?Q?2tCDOQ4sIUEnPfwlHhW+ISNZLj8BUnkCsIersVH7ncixhvoTRxvedMzp9g3L?=
 =?us-ascii?Q?pB/wfPQfSL6rEW1Lwze4cc7umlpZe3pPgdtccC6lNPPDpthZEc6DpVkMOF7b?=
 =?us-ascii?Q?Uu8uEjXlGgQ4YuK88A5ddZC12LNzUhMjCDbLN/MkZfeOddqFkG1rdNzFZUsw?=
 =?us-ascii?Q?Gubu8HSknV8XRLJlfK4alI/m7XccBurcIaQA8FwdZWUXHHvLdvC5HzPCR5Io?=
 =?us-ascii?Q?o3+Qj31Qj2BMfyMLPV4KV5yYUF/0T9EHWBn3QgWtftCn91yTRiDbJZjkzZ3E?=
 =?us-ascii?Q?lSOjAwWWFsrIDVd/sTYMxOmqiJWWwuR8cHJmxI02VLAPZ/Lj5nUaog6vi3XT?=
 =?us-ascii?Q?GT2qNrta5B3NvIl5X85V5IRHrIAFsz0MHySKdA0Bs6bGRSfzT8xLm7HT8ndI?=
 =?us-ascii?Q?mqMJnbQrC6UK8yrcgQLw6kfW/ieLkRJYWFbA9JlIBIZbY9p3UWG21yeVraYi?=
 =?us-ascii?Q?4v7aMxfT/NIs7NdsEPP9/GZPihsQUOjKqa3xWpVOO8gG3PB7YVVFRMTIOc6z?=
 =?us-ascii?Q?P1EczUAfA8UvazwuH+kuLwmhM//VJbvxAfCocMoCKEI4JCAzbBq39XbT9Txg?=
 =?us-ascii?Q?CuxMO2UWpp9kfVsRJu/qe9zslmxvIs0nAaTg56Fa8a0EHomUnyaPVX8Cdl/k?=
 =?us-ascii?Q?ylztaDGgiwInG70pb9e3BYLiPcKECnCPjsmYdfsCjqqobMGtqWFYQ8dlFGar?=
 =?us-ascii?Q?eQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923d4944-f6da-479b-d732-08dcec2dde4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 08:54:52.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: plDNaY3O+xhIK+EPOCQhQxU/S6Tqdreb6JnGI1DOWdCpR/85gZJXMAdr/8UymCRW9k9q0Q7om0Mb639p0S87He1IerjBccrBTuZUqRHEPEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6130
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Monday, October 14, 2024 10:12 AM
>To: netdev@vger.kernel.org
>
>From: Jiri Pirko <jiri@nvidia.com>
>
>In order to allow driver expose quality level of the clock it is
>running, introduce a new netlink attr with enum to carry it to the
>userspace. Also, introduce an op the dpll netlink code calls into the
>driver to obtain the value.
>
>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>---
>v2->v3:
>- changed "itu" prefix to "itu-opt1"
>- changed driver op to pass bitmap to allow to set multiple qualities
>  and pass it to user over multiple attrs
>- enhanced the documentation a bit
>v1->v2:
>- extended quality enum documentation
>- added "itu" prefix to the enum values
>---
> Documentation/netlink/specs/dpll.yaml | 35 +++++++++++++++++++++++++++
> drivers/dpll/dpll_netlink.c           | 24 ++++++++++++++++++
> include/linux/dpll.h                  |  4 +++
> include/uapi/linux/dpll.h             | 24 ++++++++++++++++++
> 4 files changed, 87 insertions(+)
>
>diff --git a/Documentation/netlink/specs/dpll.yaml
>b/Documentation/netlink/specs/dpll.yaml
>index f2894ca35de8..0bd708e136ff 100644
>--- a/Documentation/netlink/specs/dpll.yaml
>+++ b/Documentation/netlink/specs/dpll.yaml
>@@ -85,6 +85,36 @@ definitions:
>           This may happen for example if dpll device was previously
>           locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
>     render-max: true
>+  -
>+    type: enum
>+    name: clock-quality-level
>+    doc: |
>+      level of quality of a clock device. This mainly applies when
>+      the dpll lock-status is not DPLL_LOCK_STATUS_LOCKED.
>+      The current list is defined according to the table 11-7 contained
>+      in ITU-T G.8264/Y.1364 document. One may extend this list freely
>+      by other ITU-T defined clock qualities, or different ones defined
>+      by another standardization body (for those, please use
>+      different prefix).
>+    entries:
>+      -
>+        name: itu-opt1-prc
>+        value: 1
>+      -
>+        name: itu-opt1-ssu-a
>+      -
>+        name: itu-opt1-ssu-b
>+      -
>+        name: itu-opt1-eec1
>+      -
>+        name: itu-opt1-prtc
>+      -
>+        name: itu-opt1-eprtc
>+      -
>+        name: itu-opt1-eeec
>+      -
>+        name: itu-opt1-eprc
>+    render-max: true
>   -
>     type: const
>     name: temp-divider
>@@ -252,6 +282,11 @@ attribute-sets:
>         name: lock-status-error
>         type: u32
>         enum: lock-status-error
>+      -
>+        name: clock-quality-level
>+        type: u32
>+        enum: clock-quality-level
>+        multi-attr: true
>   -
>     name: pin
>     enum-name: dpll_a_pin
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index fc0280dcddd1..c130f87147fa 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -169,6 +169,27 @@ dpll_msg_add_temp(struct sk_buff *msg, struct dpll_de=
vice
>*dpll,
> 	return 0;
> }
>
>+static int
>+dpll_msg_add_clock_quality_level(struct sk_buff *msg, struct dpll_device
>*dpll,
>+				 struct netlink_ext_ack *extack)
>+{
>+	const struct dpll_device_ops *ops =3D dpll_device_ops(dpll);
>+	DECLARE_BITMAP(qls, DPLL_CLOCK_QUALITY_LEVEL_MAX) =3D { 0 };
>+	enum dpll_clock_quality_level ql;
>+	int ret;
>+
>+	if (!ops->clock_quality_level_get)
>+		return 0;
>+	ret =3D ops->clock_quality_level_get(dpll, dpll_priv(dpll), qls, extack)=
;
>+	if (ret)
>+		return ret;
>+	for_each_set_bit(ql, qls, DPLL_CLOCK_QUALITY_LEVEL_MAX)
>+		if (nla_put_u32(msg, DPLL_A_CLOCK_QUALITY_LEVEL, ql))
>+			return -EMSGSIZE;
>+
>+	return 0;
>+}
>+
> static int
> dpll_msg_add_pin_prio(struct sk_buff *msg, struct dpll_pin *pin,
> 		      struct dpll_pin_ref *ref,
>@@ -557,6 +578,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct
>sk_buff *msg,
> 	if (ret)
> 		return ret;
> 	ret =3D dpll_msg_add_lock_status(msg, dpll, extack);
>+	if (ret)
>+		return ret;
>+	ret =3D dpll_msg_add_clock_quality_level(msg, dpll, extack);
> 	if (ret)
> 		return ret;
> 	ret =3D dpll_msg_add_mode(msg, dpll, extack);
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index 81f7b623d0ba..5e4f9ab1cf75 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -26,6 +26,10 @@ struct dpll_device_ops {
> 			       struct netlink_ext_ack *extack);
> 	int (*temp_get)(const struct dpll_device *dpll, void *dpll_priv,
> 			s32 *temp, struct netlink_ext_ack *extack);
>+	int (*clock_quality_level_get)(const struct dpll_device *dpll,
>+				       void *dpll_priv,
>+				       unsigned long *qls,
>+				       struct netlink_ext_ack *extack);
> };
>
> struct dpll_pin_ops {
>diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
>index b0654ade7b7e..4b37542eace3 100644
>--- a/include/uapi/linux/dpll.h
>+++ b/include/uapi/linux/dpll.h
>@@ -79,6 +79,29 @@ enum dpll_lock_status_error {
> 	DPLL_LOCK_STATUS_ERROR_MAX =3D (__DPLL_LOCK_STATUS_ERROR_MAX - 1)
> };
>
>+/**
>+ * enum dpll_clock_quality_level - level of quality of a clock device. Th=
is
>+ *   mainly applies when the dpll lock-status is not DPLL_LOCK_STATUS_LOC=
KED.
>+ *   The current list is defined according to the table 11-7 contained in
>ITU-T
>+ *   G.8264/Y.1364 document. One may extend this list freely by other ITU=
-T
>+ *   defined clock qualities, or different ones defined by another
>+ *   standardization body (for those, please use different prefix).
>+ */
>+enum dpll_clock_quality_level {
>+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_PRC =3D 1,
>+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_SSU_A,
>+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_SSU_B,
>+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EEC1,
>+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_PRTC,
>+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EPRTC,
>+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EEEC,
>+	DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EPRC,
>+
>+	/* private: */
>+	__DPLL_CLOCK_QUALITY_LEVEL_MAX,
>+	DPLL_CLOCK_QUALITY_LEVEL_MAX =3D (__DPLL_CLOCK_QUALITY_LEVEL_MAX - 1)
>+};
>+
> #define DPLL_TEMP_DIVIDER	1000
>
> /**
>@@ -180,6 +203,7 @@ enum dpll_a {
> 	DPLL_A_TEMP,
> 	DPLL_A_TYPE,
> 	DPLL_A_LOCK_STATUS_ERROR,
>+	DPLL_A_CLOCK_QUALITY_LEVEL,
>
> 	__DPLL_A_MAX,
> 	DPLL_A_MAX =3D (__DPLL_A_MAX - 1)
>--
>2.47.0

LGTM, Thank you!
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

