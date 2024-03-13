Return-Path: <netdev+bounces-79603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA2787A200
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 04:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D3AB21DA8
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 03:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64917101DE;
	Wed, 13 Mar 2024 03:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZzjMtu7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B016C10965
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710302028; cv=fail; b=hey2sjUTfympOJJwUHW6Qu5/RfWVuOU3t6H3s9HkFuNqGHiGgean8WIFhR209koFCKmihPqmEyvMiOxbRdZ/KnPOjzZwcWmW6HE8lNz7LSy+0mvlOMB6eBl+MQc0im2zcBJzsIpEu2zRA/2mFRfEyKHYf8a6bDeuXE0ztLYzMyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710302028; c=relaxed/simple;
	bh=RYBGOYGi9Vf6hI+E8fhgFre3Y5uQDlMOYf6pXfRMH24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mp+oM6qgOaZq7FHgWe94SNWZVNCtaJmPxgQcw51HMrCWMgeUsU+U6M3lLS1q+lE6I+4o327IcdR67t9T1k9FaauTzxnp3O99W/lMQ0JDtiyPicZjZzme7R269mcCQKK/O+xl5hviwjRwRHoOng38PsiwIQd9gY3FQu/r6dYL9PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZzjMtu7; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710302027; x=1741838027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RYBGOYGi9Vf6hI+E8fhgFre3Y5uQDlMOYf6pXfRMH24=;
  b=WZzjMtu7xuXFXthZ6cDgMzRL5dbwJeIdfP/ogvZ9ptFQKoLI/nottQ58
   XVTkaebGsBkih8xo1W4J1Bpe0qJ90PWQ/QRjycUCqxy28wQZLiNTYYYHS
   Lk3GwTxZXf030ekDGhbCSXugxq8z+kOqoZuS8lYxwmT+0lbediXNURr2M
   S+txsglb6fUUz4IN71lgxZFFVEcv/p8Rq+WaJ2SjbhhZz4a6LYMVybFaw
   IaAYuYUwSQPjAq654mmZHScbqDy3hxdJ4K2o5qfUxzJOYZ6CWssHUg981
   zNDkULLKGAe/esN6VxyMlffMz8Oo/owFQvO91z/DAnAwGyqPsJdLY6ugy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22561042"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22561042"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 20:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16362330"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 20:53:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 20:53:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 20:53:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 20:53:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kh7kE45BjU280hHo8n8wjumzKV45+zxnejxU3+1NKlv40gydPGzMuijyhARiGFhjdi3wkRb7aNuQ2NQD1KsGsdOA75EzZgentJGAUJESqYcgzHfXiyM6mz0ItFUIZ8+fMEqJlZYQTnix2k/mBr/U+/s6UJaTnoqFlAFO40LI5jk9NMidxZKsbv8OHKvWfgzW/NwxhxcPEUgBD6bU48wvNyaRxSF/Ed6qN2i7bpBSmWyjvEMLCXpN3Yx/FaclFrms6D+Q2nPduKMfa8KNHlGhxUiwKqocElMlDHSfn4vVl1FMrdNQR6PB9GheevatuVpD/208a/pzpQcxnsy2L4fh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3h30UJ+6lvjmEBItXSpGsIhGLqiemY009UN3eVs9PNg=;
 b=K4RCo0ZR2DWzH/3JjNeZ8l8h/n81RSP/o4/zlb2jWNI6plPtn7n/iucQ5ZLuuqE3ai9T8hL3wjtua9pcGvkL9LpRSNtOJWSt43HJMzG0M9beR1eeCSgZCXG8AnkUIUxHH4IiSgKDx+FXqAE5ziZDz1JqRhiDaD8JYKQIG49T/CWcWbnB6kfihA8umRLQie8w40g2JdpnRffScjXODJvIAAw1TMXTjdgFEAikmKtRUDY1Jw+/TFEvLIfGDTFBiuDQUMWwqBjmu7nEpT/nuPzj9OI4Q9IXzCuDIxuZvlkdVw9y7TLPQOl9y+kfrRrtfZ0nGOerUdGvbwlgmibp/2O9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by DS7PR11MB6078.namprd11.prod.outlook.com (2603:10b6:8:86::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.19; Wed, 13 Mar 2024 03:53:20 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7386.016; Wed, 13 Mar 2024
 03:53:20 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Brady, Alan"
	<alan.brady@intel.com>, "horms@kernel.org" <horms@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 1/2] igb: simplify pci ops
 declaration
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 1/2] igb: simplify pci ops
 declaration
Thread-Index: AQHab3EkTggu6qYxyUeCy76wA90Lo7E1FJ7Q
Date: Wed, 13 Mar 2024 03:53:20 +0000
Message-ID: <CYYPR11MB8429F0A60A54DA86E4430949BD2A2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240306025023.800029-1-jesse.brandeburg@intel.com>
 <20240306025023.800029-2-jesse.brandeburg@intel.com>
In-Reply-To: <20240306025023.800029-2-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|DS7PR11MB6078:EE_
x-ms-office365-filtering-correlation-id: b9144ac6-68d5-4a98-832e-08dc43111fbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ut9ie4ntRZv29xfAzlVSouN5btRq+Hsvy08ewSxdajVidWrfX5NrC5hV2bgcM/j4BOdn4Ys6IJlqqL4SpfFUl2kuAw1z/4tApaXuuJ6N19D/ybbP+D2Stpv+MuulSR15HYkolTssd2nPox5uDomyQpbOYzHy7dAfg3lMjsFoyM8PvKR3lCyQEswuoLB8xn6HAAPtrG6ih1JmQuucYHVHWvpSMP5o1eC9oTQAg1QA/An3Xn+NdpIg9K+G2js9U1USgDA/i/T6wn655w0bAvJi9WO9yREsBcejc8ka4q5kCYG7929GgYDhRZItOYtsgspuBJEE/oqZ1tmgrORJO8dSGsvhOP1sCcs0WrbMAoJ06raFXvI7RnJSYE/piw2s+5+rhncHw9QL4005486YUhFtslQ95pFUZ4UB5gGaV7c7UBsKT45sdBj1ycCRsn+wvT+nwXQhKbncdRQkXB+IutRXW1x89kub5FiwzAQ3fOu54XpkFpcPzrtnababysM8ISigzLcc0t/nuX/2GHnDe/lFO4gKkWK5UgB97YZLv1x3POmLfFPKzkgR/xzJwvfTif2JEZlPskdtl30LmaOiHa6TVG3pSdmcQoaAlO1IZ3mDkXfe8z7vaEs3nrr/9vJ7aA4C1KV9/RdiXAOvm0TrJwvDbYwh7xYVArZqILo9apbDrRXYOLCE94GBT5kFghybwkgs/f5owm8S06kLgdX1X9HBuOMXxYr1GxbDeUasAXeQ5ws=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5YiLrnn9r6E3hQRMt7Gt0aMbE7pK/PERPdRJLhOYLwIITny+Jo6i7huQ4nr2?=
 =?us-ascii?Q?H/M8mmBHGcMXwzKoK51wmjOMh49Tjxvk8Jhv2iANSgGIf1Ijhg+sc/5SCR6L?=
 =?us-ascii?Q?+bCj9MDEOusfm7xwLm8KHnD+5wg4Qtb/qnZy06qf7qD4rlWD5RQMpwN+HCjK?=
 =?us-ascii?Q?sEd3YnE6OcWsdkUSKkenwjVhVWOkNkf8Tc9qjf5mEkxvRM7zc3NLY+ZFOEJg?=
 =?us-ascii?Q?tcWfO1EatGt8+B6qkaKjPfQ/IzgG+SmdSKdbYk1qK5SRmFRpB9sgBDnVjjni?=
 =?us-ascii?Q?ebSb9YtYIYOUzMpLVOHaktD7lv/xWcqv/gk6dqa15/qPTnBpAMxLcB4j0SAc?=
 =?us-ascii?Q?aeVxRO4pBrPANrWDVxYHRzw7gm9jCFXcwrmz+noHKN4Tao57zf72sJEbn2UC?=
 =?us-ascii?Q?9KquzJ7PtciT8rqUPxVlX2UuEywB/ZLfU7dGSfcIsizQ351XQCnG+QaqZzKL?=
 =?us-ascii?Q?4PZSO+mrk4TRoEC+vx3bMiKgNchFmxX/BOdwG5Wej63NEpDOuYAY8EYwMoLJ?=
 =?us-ascii?Q?sU8x/bNws2rGDk/nEcxwEgtlDeFsk0FsGkCNirn3ktdn+qbPrqB/ewbZBzpv?=
 =?us-ascii?Q?dl0zV8IxEm8g0ZqynmztmEWEmgcu4iXlK+W8KxEmvH8KFpKLDtwef7nzEYrx?=
 =?us-ascii?Q?J09NGj5oSdgc08gOglPmBUfV/YIWbeU8Rn4xMvMpv1gN0xjF2IgObmNDm3Wq?=
 =?us-ascii?Q?uSQ/pHE4JCUYp01fT/utIYw1MupuQDJdpuXE79clObpYEMVMUtd0Ctc/zT8X?=
 =?us-ascii?Q?sY8/7ekd/02zARbMuidIwVYHtCVouBjcdkFLZ9GPENNSYBhJbRhVzBSMATjC?=
 =?us-ascii?Q?qlUbvttTt5b7pvPDWbeV2gzhUs5ilo8xMZ4kgfUBWLgPhcp0BGhk+X2p0y8b?=
 =?us-ascii?Q?q7W1vlrQbeQiQ13AWoDB5NptOGELuFk97BZz8QMgiCnn3HtpEfr+rTv0+WjB?=
 =?us-ascii?Q?xjzCJoA6U4UMImbT7+qOL0Z1uCF4QMF+aC7rGVL6kbZCCfPTaFt7xKrjsliE?=
 =?us-ascii?Q?OSEwn3LUZC8TGQg4z0KqA1kBg/CwFmPOHgWzvKwrTO4yie71Y8xXlk0y5a3C?=
 =?us-ascii?Q?lZh3mxxJaVohrSCuPxFjlvF91wW1TvZqAdYp1I6HuhHqzsZhtfA4sC6Udc5w?=
 =?us-ascii?Q?aTAQlNPOyVlcgKSA7wPtjcj2HREFK/z2HuNR6PfpS2UjmdGFw9B21Lvg2QN2?=
 =?us-ascii?Q?5zwuIAIuVunItevL/hWwCAUMAu2OGnq/0AeeWopZBOil4AefBR4cpuwyFp4J?=
 =?us-ascii?Q?SnBunjWZxwVBxtLFBZfSjqs9LKtEkncLvSW0s28XNjOxr7DUW61LSLQFe34f?=
 =?us-ascii?Q?iftYJxakqqiiLqyhDmF173QI0gVlNz9ayD6NsICrvmsAAvfShkopim92lCJW?=
 =?us-ascii?Q?pA5kt4GxQzZJ6j+BTAFV9wrAFh2wOFQy6qDO81EpvxrTpiOASW06EnmhKv0O?=
 =?us-ascii?Q?tEwId1WBt4KJM1DcjYc8B4+CmD21I0qRlnVQUg/7I6Vl7vseiPTqaYZOMd0p?=
 =?us-ascii?Q?BU3VmKCHyMbF0pvwjnHklYzMn3hYArxviupIaR+2uBpjd9Su3QAILWfof4Zy?=
 =?us-ascii?Q?oLdvufL5Pp6Y0RKnyfQjV2q1dxweDdJJ57D5VHhuLpaHo8b3T3ryzwk69km9?=
 =?us-ascii?Q?JQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9144ac6-68d5-4a98-832e-08dc43111fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 03:53:20.5685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNanVhL9f6fXGE9pHQg2aYkpLapJCLnTV2HjP1qgi0aJo3/aj5ZrstJyBYJOjbs6yfkwYIHsUPWAuSSFoks0G8xDqYDAil3wrnsgRiqsuIYFGio7QyHqC+TiENmZ4CQn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6078
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
esse Brandeburg
> Sent: Wednesday, March 6, 2024 8:20 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; netdev@vger.kernel.org; Eric Dumazet <edumazet=
@google.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Brady, Alan <=
alan.brady@intel.com>; horms@kernel.org; Jakub Kicinski <kuba@kernel.org>; =
Paolo Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 1/2] igb: simplify pci ops =
declaration
>
> The igb driver was pre-declaring tons of functions just so that it could =
have an early declaration of the pci_driver struct.
>
> Delete a bunch of the declarations and move the struct to the bottom of t=
he file, after all the functions are declared.
>
> Reviewed-by: Alan Brady <alan.brady@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: address compilation failure when CONFIG_PM=3Dn, which is then updated
>     in patch 2/2, fix alignment.
>     changes in v1 reviewed by Simon Horman
>     changes in v1 reviewed by Paul Menzel
> v1: original net-next posting
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 53 ++++++++++-------------
>  1 file changed, 24 insertions(+), 29 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


