Return-Path: <netdev+bounces-77284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE878711EA
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 01:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB7CB206B8
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 00:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E3C4C96;
	Tue,  5 Mar 2024 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPCe7Oa5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D886F7465
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 00:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599482; cv=fail; b=ZIOYcJN+dbmfc15H6nCfnUh6ASpv85HCXPp5vceAIXoB5IdQS42NKwyrI8bCBsPHjDabPS3ZmoYHsMMQydFmXb6bUr/3dMlyVt4hpS5ho+tvkb6cwI/ODbL6RVOsWaZsgGbEeuaJNYbnfuO1CnZts/V2khkqmjaJ4XZr0eVA0LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599482; c=relaxed/simple;
	bh=M7CVRYqofk5XNSTcSyNso0og3BwU9DZYDJigXeQAN2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IwmqlixR64tm1SI/hkVrlQ5pH7P5dcK/B3uLEnC9Ufo7/OYuMj8kqQuCMA0nR0yndSmwS4U+aKOQVp8Ks8Q4OORAy+lINSb2L3jNdt5R5V7+ofwSD2MkqF88veCgF/KtXnFslmhGdSLu0jnY7Gz9zf/VGTvl0C5TKQ3dpjzBaQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPCe7Oa5; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709599481; x=1741135481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M7CVRYqofk5XNSTcSyNso0og3BwU9DZYDJigXeQAN2E=;
  b=hPCe7Oa5TOkXVsert/zhjrxDEJvKN/eu5J2YajIl1jKx1WP7KNnAQ46X
   uujiz/15GohIb12fZF8RAhBTAPv6engCfSGH0eXE3FuExlb0TMxgV6TqU
   2BXZzfpNBCTAmLN0YesnB3pKp7+ISEd0nhM/CRHIMvwJI2me3OI33UafL
   /aURO7AVuFX8DKcY2ColSQx3Z+ZHk6aDJWwufaaJm3FjYmYxW2sTv3xq/
   SRsoy7Mn77E5im3mWQu3ukE5o+dNDkf0aTo3peLlYIedfILIp5QHexJSl
   uw5/Od1/K8qOWPCEWaxnyDlC/dV6+35oysH2EJKe4BLrRQlHGgfBeO93N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4004765"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4004765"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 16:44:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9025202"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 16:44:40 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 16:44:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 16:44:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 16:44:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 16:44:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWuBcqgMKqqyZo20IZZA1NrSKAhdDpRH5Nt6PH0V9HD4o/70uoZ20XXm+fpAYEyMDePo3MDOlMI3BISNahmqLYSK/oPJiZ3sSR+cRpZwGbBnOsPpB0bIQFfVqd6267pgsZsK3EDOkaOrtlz0lYNeyE4R5tOgYzjAfwaI0yy2hQ41i03v6QdQ/hgAw9yP+3AyuXT+c3j8rRFEO8kU4/sJgNutJEhI1seGNKz4T4K6Fn0KBQD7M2xYHEpp0rc5aG3K8pKtGgEkOkPLJ5kG4AL6gWgnpr8ttNTP4Kux0LZKQuxdqtMqcaPZ970RNIMzwC4xYVEvX5C7QLfxnQtl8WJTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7UjbnXLAmEXqKdrEc4HqV4lPJ5NWS/PQIKyYJ8EPDQ=;
 b=fKdElEcZRMKkqUyqPP2SRYu83gqzpHXnlLYNB3LNATxzEOdNGcax9XsQt/iDJ8tZmCwakcEJFSKlR2pQvaLprabr6ORud+q5vt0qzc2KzZe4q1M6Aq4ZEmcWGKYG3zfxU5xyT4ujai3CwWSj0l3mtZYmvfLPwElAyavrAvLA/n+nZCtVvjp6uLN3cja3HbZW8/u6S8zThRaFFASy89pHg3DH1A+d/+Sd7GZq1Nf6xAC1ruENA1QkuJ8zHxcBV9TAfNKJjE5T4NOeGsXSRxIBIjuqLXr3xjQeDMuMobqAKL92A3/fsIjs2vlm5QcEVP3PAg4btG8+xeVvaVwxYxbLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by DM6PR11MB4611.namprd11.prod.outlook.com (2603:10b6:5:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 5 Mar
 2024 00:44:36 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636%3]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 00:44:36 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: "Brady, Alan" <alan.brady@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Brady, Alan" <alan.brady@intel.com>
Subject: RE: [PATCH 1/1 iwl-net] idpf: disable local BH when scheduling napi
 for marker packets
Thread-Topic: [PATCH 1/1 iwl-net] idpf: disable local BH when scheduling napi
 for marker packets
Thread-Index: AQHaWifbrOzaziCZXE+CYOuhdq4wrLEod+xA
Date: Tue, 5 Mar 2024 00:44:36 +0000
Message-ID: <MW4PR11MB5911E9D6236EEBEFA56E2C06BA222@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20240208004243.1762223-1-alan.brady@intel.com>
In-Reply-To: <20240208004243.1762223-1-alan.brady@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|DM6PR11MB4611:EE_
x-ms-office365-filtering-correlation-id: 52c09d2e-72f8-4348-ce84-08dc3cad6ef4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uy5R6yDwqu39XkMYCJIZWIrzUPmB2AZHYYuhXAI486YKltYuFAU3nrJx4xT4Ku1GKjSMbnpznBKU92Hg8lPrKwPEGDQ1KGq823/oYmlPoNlTQ/Pouy5LyLaiuLr8oXzYGpgTE1D+nB9PBFkSzxRqWv1/WhhSDz0/3u9dnmImo3U3z/Nc+uPS/8cMbP6TbvjrNsyuKS5oJsGYVz3jIVfdcZyg+Bf9DsrlT16TQlcK7lmlhUYJ4f7RR3Ipj6aqTYPq5k1YJ2pTZxwBn5jTQ6EgmJ9WuNNyBStxMGTJryCQCnNAb5CG/Iq/P772u0d83AZiDGcNL4flNVuljxGtd1C8FL1eazC/1zUWNE4gJSjURAjto8hl9wdDx9By9YiyxM4M+Ivw+7hb11ykATOcLPc6BzJpZXGP6sQ2dVlUldNs3IjSy+9fdYfmHqVjAB3ww3NGxJipfC9Eji8uTmwuyHsicvI5GNyzuE8oX0bNafzlYxY8fMmlEugP7cjnqxS+3RWyOC6iI8e4H1fngJQEjaz1tjvehha4jci76mYscclcUHZMC6eyaY/fCv0ml3L64IkcNc79o6p9Xf9ho/2ivk14fKR+KXzhv5le3EpWzeTBvBZAvUu8LEmyPOQM8ipHzZu5RnEKgQ6zeJs9xRANecWaAC4/u8MiE8YAEKPoDzKnSjHvwKElt800oAon7daEYbWlXkVxEHaTsTnKuWsTxW55V/NZqABXEjXw06mTYQnTGeU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yf7UEKSK7yP9iKuXqJ2lyNi1ASMyFqcddZ2/Jz0Ej72T9J+MINyG7JfmL+s4?=
 =?us-ascii?Q?UmJU8Ow6iXPrHSd5po5TNgxfdTYBLtivYuEh8i7iMYlUA4v3eXZztHGK2w2c?=
 =?us-ascii?Q?edwFjJ3lZUtVJBIbSDMNHaIeHyaOClscrB9aY8f4uhs7swRNIC9vKG5F1Gzs?=
 =?us-ascii?Q?xS08SS7dx/D6aZ2KZwmzgPALNKSAPS7CyEmQDkOQGzMfW6tlt6AFlpCcdUx/?=
 =?us-ascii?Q?M7ddL7an8ooYp+y0PP5DitCnWpVXmqQxzrf1m2Ubx63juEjl6YynoJeG/SBT?=
 =?us-ascii?Q?DGUtTwSDPh/f3MwocIZRQw+iPBEb0sXUKcHDdiPuMDrA2YEqJ5/LZMpJ9FZg?=
 =?us-ascii?Q?0OUilFvImvmdNtgXkieBHKBt//OVVjAhcDb1E2Ekqdy0bWaLMb0TSynNXuPC?=
 =?us-ascii?Q?KVcLPFdUAbG8XsbGviFv+LKhe0LithD8pIKbbncu76Zm9J2I2gAHOv64+WBP?=
 =?us-ascii?Q?eDD5/wD1yXIOulkz9wMG7LNNnZCH5nbwx2eSF1d1zQUxazTrYM7As4u6n3NS?=
 =?us-ascii?Q?GkDEF56SSF89mD+SZN7Q9BCRPq72mHeQOM4bCFGhxrTwGNXUlEN7AN+TPDjl?=
 =?us-ascii?Q?uBpRCkXJlqnzxnvLI8Ayzk8LNh0nZzat+p4YxKBA4rsFmetzHsqaWCLPHrEG?=
 =?us-ascii?Q?OWy2AjXx/Ajo2HzGwH2q7LjNgzjVQx7zuEWaUNeLbHSNY0MnEbwVqsJlCzyf?=
 =?us-ascii?Q?/udSqKU1a1oOzJ9+ilM6FxyImiwAiBFRuwfecsCGLXlwgvWOjd5a3UiwxxWs?=
 =?us-ascii?Q?coy2/tXfHKH7rLuCo1DC3mN2FnNtZtfCazZ4fJL2lvgjSvH36SB7mzNaeo8y?=
 =?us-ascii?Q?m/wT9J8AsmBv/y0fhBR3/sSpgvWUr9kyDaDf6TBHy8X/z8gi5ZbQ+VtXbTQ6?=
 =?us-ascii?Q?CelRWm6NMhVr+olLQG9mKXaZB67j3vl2KBzWQVAWz7ngfs18p5Xb41W6WgmR?=
 =?us-ascii?Q?etH8LAuaDxYI8Wliiepc3WvKwHHAckfVMToM8pwclfVjvs/umntg7X1GqSdB?=
 =?us-ascii?Q?1NgYLUkB5OiGxKRmdNgBNNx2rOQYCYHGs7+SuW7kOAN8u4ZO/OGlvLaxnuRQ?=
 =?us-ascii?Q?Qrlcg9Wv9Boi0uz84EyHsCVey/COQoSQPnWGZ/jnvIRfRBsjlzXTHJ1d2gcX?=
 =?us-ascii?Q?TaotD3HPbH36GHyOsVj+SL3nr3Z/ZUcj3HiUuXSQPdDI7jOqyFAKk9ksw4gE?=
 =?us-ascii?Q?UIbjdoqsl8bekubJuqBT8xUjPHCwh7CAP3Sv8j54I1mrvjAFwX3/aoW3toTZ?=
 =?us-ascii?Q?UPo5SugclYCYbt+zmDeiWq2+f9K7/hpyRvLvWjFhlDbE/7NpffUVa5es05QH?=
 =?us-ascii?Q?hywTX0zvEHvGCaHPgz3FMmm8HgGg1VfcbKOZIqi9C2YYiyfWrgftRynDnSGC?=
 =?us-ascii?Q?+MHaGE+BOLPojd8Zj0PCZ9UMZR2jhtz+Mo5jSkcMj/n1kZbVuVVtZRqH8eiC?=
 =?us-ascii?Q?B7jfEf6jPViWChkcq/7WS60GMaIC0f23s7HAMYXz8ievvklrot3Pnm7MoPd/?=
 =?us-ascii?Q?gWGisVgqlGQpPkz5NKb7wwTCXOPItsaSG3r40aothJ480j5eF+b0Vv7SN3jW?=
 =?us-ascii?Q?sNFFn1L7+0/h9xj4HjRzRGnDeNP0l5T57D9tB5Sq+rnW6UVB28s1fOb40qRS?=
 =?us-ascii?Q?hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5911.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c09d2e-72f8-4348-ce84-08dc3cad6ef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 00:44:36.8264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1u5OHFwaYumGiuPCUqsYA00AY2HDEhutxvAKPZrhjVptM+yeLhAI72MX3OHz7LM/os/GvVUXm38oTW5jklDyNvLg6+V2+noKepYL367ppA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4611
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Alan Brady <alan.brady@intel.com>
> Sent: Wednesday, February 7, 2024 4:43 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Tantilov, Emil S <emil.s.tantilov@intel.com>;
> Brandeburg, Jesse <jesse.brandeburg@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Brady, Alan <alan.brady@intel.com>
> Subject: [PATCH 1/1 iwl-net] idpf: disable local BH when scheduling napi =
for
> marker packets
>=20
> From: Emil Tantilov <emil.s.tantilov@intel.com>
>=20
> Fix softirq's not being handled during napi_schedule() call when
> receiving marker packets for queue disable by disabling local bottom
> half.
>=20
> The issue can be seen on ifdown:
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!=
!!
>=20
> Using ftrace to catch the failing scenario:
> ifconfig   [003] d.... 22739.830624: softirq_raise: vec=3D3 [action=3DNET=
_RX]
> <idle>-0   [003] ..s.. 22739.831357: softirq_entry: vec=3D3 [action=3DNET=
_RX]
>=20
> No interrupt and CPU is idle.
>=20
> After the patch, with BH locks:
> ifconfig   [003] d.... 22993.928336: softirq_raise: vec=3D3 [action=3DNET=
_RX]
> ifconfig   [003] ..s1. 22993.928337: softirq_entry: vec=3D3 [action=3DNET=
_RX]
>=20
> Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index d0cdd63b3d5b..390977a76de2 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

