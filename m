Return-Path: <netdev+bounces-93315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B678BB290
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4890B1C23726
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 18:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB131598F0;
	Fri,  3 May 2024 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YH8HCIrV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76515958D
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760126; cv=fail; b=rgw3d6PRv1zRlbTk+R8ATQmf7gdhOluVqY7JcENMIAj/m85tCrQLXgl3dk4qR3XlFIV/3Zt4vazNbzWUpLJoqoTlePEbOZd0wV6bMoePzrkTLPZLBZkt9I9qX1qiHDk19TCDR49tyap9YSOwaBe+AYhHMfiweKlo+tiCMmxT/4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760126; c=relaxed/simple;
	bh=d6LOigDCa6S4YO94w58JawquamnttSC9zy1ABXhbO54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=POplhXwOQdv+F22RpzVrCmUgPwNnS6phHN7xh2IxPHaMk45JT5HGdFSTPH2pbJiJAYMsaKN/3aQNQJ3hJrJVAIec4Lidlfi/JJaUmspwaMGM2bknz/rjhSutwQFVrNA+ttgjYGxmzxOawGSQT1lx/W0LeHstXFWvlDX4BB5IWnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YH8HCIrV; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714760124; x=1746296124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d6LOigDCa6S4YO94w58JawquamnttSC9zy1ABXhbO54=;
  b=YH8HCIrV6HMShT3x/as9U8ig9ypRE6V2DR5dnhYVXpXDXWOfqjhasGRI
   DSjKJU37YUowvSHsHMh9zthvDxCqUy2QMexWxbMW7rY8fJ78YOYi/eVoa
   ZtSPFQq5uuxhngNqlvrqt76A78nTC9tMxpW+zwDFe+RXaeZYQ9ilRLrVl
   Ap5sul76KuduPPDL98Hs3TGT7VelQz1imrwNJDIL0dnz0noiWV5mmKKwv
   bGT4i8lX/1hSl2/HbDryqZ3K+8OZz25H2a9BbgH++POGl9TUQg7zN0Jlf
   eX+YkMonSVa6sbxWhpADm+YuArqINLvdjoPyTVZhCz1KOCmMaQYUsPK6C
   g==;
X-CSE-ConnectionGUID: QyakASDGQqC1yeblmULpuQ==
X-CSE-MsgGUID: vQNB2f5eS5u6y1OykfaNPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10425735"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10425735"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 11:15:22 -0700
X-CSE-ConnectionGUID: PcsLGDEpQ2WMbjbKAuq3Og==
X-CSE-MsgGUID: +bGlTUl8Rdm/uWJQrQJP8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="28111253"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 11:15:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 11:15:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 11:15:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 11:15:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jrd7rypJQVz+N6VaxRIMt7bUHcbTpPFu2C2Up5Zrs7A5Wn7yUEVan37ZTgkGCAPWSE9K5FDd5lggHgvar8G3f23O3nFUGeJZb3zDWvEPHLjYr9yePEjhYn4AtDg4r+DMAqhQKHLujPPMVhbFas1Hwjm+/mFODaksNhEJ5I4ubeRyHR585IzoN76jULewtc/lng2kQriJIogVLYuLsUkDRpKhaz+4k50ESs7dT9mA8FJiiysOR1cnnKmsF9ezzW0e4GEMS9/6MfRqFZEWYvYk36HQBb41Ibe8Nl/WU3MmgODCaOdQUzN3uh94SVcOBZCiqdfqvb4DtfC1UVVhBNrEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rns0KyVc19yMFrv6JARRd97N56ASlnPTWSIZeshLpko=;
 b=WkHYanddsTBC36ySpGFGpAmq+MvD93OjXn3NMJwBMlD1MofVUPhXtXCZmO5zfBpbDVK6oKdtvODZ2sWNwLdwLS4J+MYiHtmqLAe4dKvpjPTG1LBjj90dBBKfMdZ/yc0tc27Kvj0IemhW6LEKhEMxsPkhnKb+FaoXC1m7TZ0qPZpxSraVgLIGcu0AzrNdT6b9qDCBYRJiV/QbJbXF2eeb51VbD/HA7ptxBKIKU7PHhJ3rI89rn5KZtg/h8wCioQ1w4PmPHa+oGeJlWgT9zR4nR+HH/pSQwBVFi7g9XRiCX7L+3NTCfjYJlT70sjb24VqT31ZH8TOeppmBfz131UBUcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB7555.namprd11.prod.outlook.com (2603:10b6:806:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Fri, 3 May
 2024 18:15:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 18:15:19 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Donald Hunter <donald.hunter@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Johannes Nixdorf
	<jnixdorf-oss@avm.de>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>
CC: "donald.hunter@redhat.com" <donald.hunter@redhat.com>
Subject: RE: [PATCH net v1] netlink: specs: Add missing bridge linkinfo attrs
Thread-Topic: [PATCH net v1] netlink: specs: Add missing bridge linkinfo attrs
Thread-Index: AQHanXkFyc56ktM2OUGKtPUKSyh5DLGF0LDg
Date: Fri, 3 May 2024 18:15:19 +0000
Message-ID: <CO1PR11MB50895AAC8674CB97F7284983D61F2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240503164304.87427-1-donald.hunter@gmail.com>
In-Reply-To: <20240503164304.87427-1-donald.hunter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SA3PR11MB7555:EE_
x-ms-office365-filtering-correlation-id: a6f5c49d-3e65-4241-ea9a-08dc6b9cfd78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|921011|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?HBZwO+YaT2M0othAiH2JsTmpda60kbFHjuU87xbeBALewSvu5iND/lpyzlX4?=
 =?us-ascii?Q?qjT13IR7jUx6WKsf0HH7OsxuWo7bzqaIAkFwbPC4YmOj1snyoixn0MtZ0Pxr?=
 =?us-ascii?Q?Ke+0WNTWaZEo7k4TYRQUnEnDM/ccpGXKUxwZjgltoxtrDNF3gAp2QfsXbSJp?=
 =?us-ascii?Q?g1TEIPCgYBQfttnnk/qhvam7PO/fRgE6+obIoLNhEjmcbuG++QFHk1fnwtPQ?=
 =?us-ascii?Q?nNnNhaA6z8ugZu8+QhsbFZljqr7RrnGldZD1UR6E9ayDWktilnNgUo3oSTL9?=
 =?us-ascii?Q?hesYPfHI7qzyqiwg7U9aoe4MD3DhVAvmG6iLWWPB5H4Ztrl48zl6OcVCTbK+?=
 =?us-ascii?Q?zmVf9ITpYU9+3dACAH+OV/vTyTqzub5ZRm9JneQmI26AeEBW3r7j5gVhe/3B?=
 =?us-ascii?Q?j3Sgmr6kO+xDgJVG6ik+LSydbqciUmmhcpEDs/7HGsjDzmojnV0d7pPUvrfv?=
 =?us-ascii?Q?T2ICRG06UX7+Onazsj9uULS3yYlfCDqoKMWLHwOXhh9UGKnTbErvrnFNB1Qb?=
 =?us-ascii?Q?oTPwKp2iQdNvQVck3jIEZq7dJvRE0aq8Igu470D57DKELLj+tQh9ppY4F0G3?=
 =?us-ascii?Q?gYKCqASOU7u+FtnpocrK58F7H9uej3LUSne1JrHZvgfVdjjDoH147BePjYq/?=
 =?us-ascii?Q?n5RO2dpOxrJXOlels3RlRskmuTYZmV1cIimxiKWCZ1iYpcpE8lyoNPr8mDve?=
 =?us-ascii?Q?zsVJHKbE6GH76Hvm08dcmzhdE+zFiq7ocPhtinD7zgfVSXFzjPVTqL4E47Pc?=
 =?us-ascii?Q?QJOekqAOThw0mWgKceu6rmj7TVQ5bxuhzkvZQGjOnlP9JgqUNdM6ZLXb1Imo?=
 =?us-ascii?Q?JyCfzJCy3qXHt2ktTG9YsIi2Eh3SqMKbkgdJTKNrR3IETtQbp4y9v24b9G2F?=
 =?us-ascii?Q?ScnzYrbG3ic2N0peEe1VbFhFBysnnpzYHub8ijIAH4sw8pY+DjT88N6mPCIT?=
 =?us-ascii?Q?E8GYMOvOd6xlBSNoVHHHDdGUmiYUOxmBCzHlKRlpqwhuinmpZfijJVwV3tjj?=
 =?us-ascii?Q?NH52nJ4SRLWs7X4cGSIuSvFDgMbEWf12fXzuLvbzYbD/Xk6jJ9x09jh8X/hU?=
 =?us-ascii?Q?LuefhTcPNXmuEofotAkww/W2lJKbSHrQ0qvzFJYOEmirnnqpG/VlyIYJD906?=
 =?us-ascii?Q?MGjE+WaWmCzbAN6AnpfeaaxwnbtDWPPZm1zFHw6A9exag22D/qJBLUnfdvNP?=
 =?us-ascii?Q?M7TeQHRE6JwTLkaT4VBNGip/rP3/IooCAXzTUNDtoZTNWOoWkPj7WyHKzS9K?=
 =?us-ascii?Q?FsMDOBQ1gYToqAwG4bpPxhdIGPDsQ76ioMQdVd6+utfictlOuOr0JMXwUcDb?=
 =?us-ascii?Q?655Z+B+m/oXe3KpuU30t12rOGSHngJ/V9msxwON9BYdtkeWD/X3c79uy4Yq5?=
 =?us-ascii?Q?fgd+Q6s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?umUunFsqlK7q0ny9kx5u3hNESATQEm+zTbmj0zMgrUw2JSQc4dAC9cs8uMbW?=
 =?us-ascii?Q?btokkQD0MEoJ+0//sVY4IPOXjLNtWB145zbEJhXMMVB381NUGqAoZyqsxmAY?=
 =?us-ascii?Q?m/5oNg2+8v+6/YT5Mmbtc8mpFmNuLKfynct/+AP8bvgEFff9fu3HJXF2S89a?=
 =?us-ascii?Q?9SOKIszsTWKc4XhNNuQYXPeElTPzI5B1OC7rLycL+RgRpyf3YeLZFENQB98k?=
 =?us-ascii?Q?jGJo4s/Hs87KAhvw1lYGP4PTXV4+mRv4IEEGLXZ3d7GuTe/g9HILq+giog2W?=
 =?us-ascii?Q?u0OKcaSIqsJEMgjPsI5BC9KnX/FQhgz1n+dfO9w/5ozUZmEpnGrgxejakysQ?=
 =?us-ascii?Q?03RU6DUGfZ25stqWxMguJ1UDj78dfT2OwzBB7mb2HeRp0AP7UKL91lSi+6Ll?=
 =?us-ascii?Q?eWcSJROUTxPPOkg0bSsXSaPFk7dNNENuC8tLXGI4cpu+2HpnFVLYfAbTBEQi?=
 =?us-ascii?Q?PNpjh1Yf5RRF52JkZf9iK4MYLm+BDeG+AxhGxDMzXvH8LVvAnjH254M3jW+u?=
 =?us-ascii?Q?mWgfDj+pdbdlFyOw0MTfunXYylPaU6DzEdw5cwD3ZoxkGzvIJCQmBLt20VwN?=
 =?us-ascii?Q?uK5DP04sNz7IgajbhHPIJP7BUUswOW+5P7dOP06//dtLX+hC4ZK7t1fJXbSD?=
 =?us-ascii?Q?tyS7dB2N7NkhA2S3vi5Zs4uJ0Bd+3qvGVcH16IEYFFU+XBpQ2ePN9hBgRE41?=
 =?us-ascii?Q?rkfqP46cZciN0XOYidWRIFo8eEpwhrzbRQlwyOzffrAqQCol9s7aMDXr1bQ/?=
 =?us-ascii?Q?0RFpq6aC1WGaQrJdqTVX57FD2QEkzoxz7OWkylb2SuqaLwSghqwvp87ogJcp?=
 =?us-ascii?Q?u74IiYHop2X3cGh2YjX9SV9I+4HplZdnHShtrQoCQn1DbvsfjGJPYqoRN2SA?=
 =?us-ascii?Q?zNN+aSYUX4zN+8ToYRWwRrRra4VrI2hB6Xr0yWN9pmNEgCdKXqDxS3Q0R9uJ?=
 =?us-ascii?Q?UDQM3snNFf5Szmp2evqn6VGlcdoZ0s9KdEoVZ/jpFcP6q48YEaub/bWj7mKi?=
 =?us-ascii?Q?dIvpAbK6rzNUoUT2SAmJ0KhzSLRCMB/JvOyu6+CmbZ4DXoHTFcijbIG53jrB?=
 =?us-ascii?Q?XVseRWAJTRT3TU0t9erI1kqg2dEdKQqz/q79jVOtvcFbkYq9hIUC2jq0f1My?=
 =?us-ascii?Q?85k3uis0oRnRws8Gbl/ycPy6JXimIqpsEURKtdscipVn46UI1fX+z0JHr29A?=
 =?us-ascii?Q?74lwAJcWUCXHME1dpVHhLEMuOpWl4U78giqp1gFZP+11NBjRcbCxVIDdtQFw?=
 =?us-ascii?Q?rWHIfLJCqrtfYA2uL/sCsukM7efx/q/ipE2jNaVWMRshMKd0QzVgUMclpxm2?=
 =?us-ascii?Q?PEKcDMgc9n16aBzodhzXbyfqs4oMk9UCX7jAOXOSuS8eDucSNomTT7AiLSyv?=
 =?us-ascii?Q?5cu0W4R36ZqGX1FTVWGP197sX5tfZVA52cQLn2lLx22ToLL8tNR7rGeOKFsI?=
 =?us-ascii?Q?Ui7o0cueMFpVdChWN+D4Q7TuXCYy00QlZzh14uUFciuEevw7F0X+pSsKs/Up?=
 =?us-ascii?Q?dpYV9fYREYv1NOiU1BBvcIoAToyEnaiE5PdIQuauJ/8fJGCc1YU3dDX7TGl9?=
 =?us-ascii?Q?uC8rUIg2yvi94ILDNYZJNaHC8HFlynmEQ5sg9Ssc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f5c49d-3e65-4241-ea9a-08dc6b9cfd78
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 18:15:19.0944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qZ5smh6OzGS71TY6pYOLwcEYaPsWHDRMYG4N8eNKe29a/PSnIAGpBZulF7obJeI3wPtwgOr3iOaPHYpN7p69c/etOPa46MjvDY2pJRpJkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7555
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Donald Hunter <donald.hunter@gmail.com>
> Sent: Friday, May 3, 2024 9:43 AM
> To: netdev@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>; David S. Mi=
ller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Paolo Abeni
> <pabeni@redhat.com>; Jiri Pirko <jiri@resnulli.us>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Johannes Nixdorf <jnixdorf-oss@avm.de>; Ido
> Schimmel <idosch@nvidia.com>; Nikolay Aleksandrov <razor@blackwall.org>
> Cc: donald.hunter@redhat.com; Donald Hunter <donald.hunter@gmail.com>
> Subject: [PATCH net v1] netlink: specs: Add missing bridge linkinfo attrs
>=20
> Attributes for FDB learned entries were added to the if_link netlink api
> for bridge linkinfo but are missing from the rt_link.yaml spec. Add the
> missing attributes to the spec.
>=20
> Fixes: ddd1ad68826d ("net: bridge: Add netlink knobs for number / max lea=
rned
> FDB entries")
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
>  Documentation/netlink/specs/rt_link.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/netlink/specs/rt_link.yaml
> b/Documentation/netlink/specs/rt_link.yaml
> index 8e4d19adee8c..4e702ac8bf66 100644
> --- a/Documentation/netlink/specs/rt_link.yaml
> +++ b/Documentation/netlink/specs/rt_link.yaml
> @@ -1144,6 +1144,12 @@ attribute-sets:
>        -
>          name: mcast-querier-state
>          type: binary
> +      -
> +        name: fdb-n-learned
> +        type: u32
> +      -
> +        name: fdb-max-learned
> +        type: u32
>    -
>      name: linkinfo-brport-attrs
>      name-prefix: ifla-brport-
> --
> 2.44.0


