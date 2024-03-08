Return-Path: <netdev+bounces-78626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0509D875EB1
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 08:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827ED28300C
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2054F217;
	Fri,  8 Mar 2024 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmnKwM2Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9124DA15
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883593; cv=fail; b=Q3DCd1L7VQ6JY4S59hC7kH2h5fYjSMiSiBzaq8FBemVjCvbYPeNWG1PjxArAmC73743tCriI1GOL5XDlGIwtZ0pEnDfbUJEthJvzKyBoCtU8RUQcI8Rz1JjSQU68AidsJwu3M7bEe7/iWhJ7tv4nlUzV+KlfRBhEy/E82wWqeQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883593; c=relaxed/simple;
	bh=oDZywjMInk0EQR3V99Rhsw6ssBnlGazJNoxOscSFAKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SUQRUH+M1NL+A37q9s4MA7/a8NXXBQjig688wHuPFge/1gvhkODtEMq9FvviBZUvFIojHWivvPI5q9Exign811WCQTgc6UnKquamdMHg2lPDAqTgEj5WcYKvPkbYRWMyqokpJ+Z/rISCyjvurgiMSYtUk57On0p/4M5qeggVzRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmnKwM2Q; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709883592; x=1741419592;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oDZywjMInk0EQR3V99Rhsw6ssBnlGazJNoxOscSFAKs=;
  b=hmnKwM2QoXb3oKAkJWOP/mbcMWdFRMZHKyPQTHbR8fdf0VKOlJeQk0m3
   HfU/xmLjdJUigaK1M3P5UVM7L0ByPYSfomuneRuorRz6ZHwC+ShDolcDT
   GlNRe8gzOgDKH60AU00re44Ml6TQNdpmPbgha/V4UVT1Y7YtE2IYKxf4e
   pqinpScSB9xtFybDCqOTHWmOIgXrLWUsuKZNz5wSStAU7FZ2o/fHKy1Qa
   fudRNnG7ilJxhx5KlFYTkrBo/nryodAYxdIMIUykMCI+Shn9Va8TTtKij
   twaeMO3o+g2AG1aQ/KOhEJgO8kOFMLB1hD5FubP7uUFaMQKfXedDasCAx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4474332"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="4474332"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="47859741"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 23:39:51 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 23:39:50 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 23:39:49 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 23:39:49 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 23:39:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDKxbLxGxomdNd0DMOspV/Mgixaqj00g1Bj2XUUwve6Wcr8NJOP6F1FTJUNIyq6WfMEJ8DycnZkeaq+dbSZpmypYvymDZfXtnZR56zZU/XAafc5D8RFcBBVtKOdt8geMPhP9iSsbyHgfRssRH+Z4HE0X5qTY+CVfyfBReE1IVYqEhLttvXxx9VhgS8R+2i+Y8pIxCEYzwUhcehXGWB11PeHiEH/AkgqLeUnyIjkN1G5qVIEACfFfKYF99eLOcOGrbaFPqs7d8pdkIEZXcxrhyEHwx0bM2n6d+3M10goQkhU6MfV20llgZoD40F/Ht26nObSnPhJepcQndH/Vtm6XOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXPR5+tGdckQI3j7zjzICy+P09BAE6pYjyM+AJOxEOQ=;
 b=ZsN58xsADh2iJ403KNrxojukMbkx2hvgGnAXjbKQkMyKQRsNoCuhlPl8ZWOdsGt+OdpWLrM5fFCeVmYTZShHYEgu7F83CnK64PJae1KVQ4WfVFed3zZz/2D2Eo5TEGCJjT1v+hA0VX5kmfKYfMCljkRg6wdIWLKVGH6SXja2sRN6v1mB6OXUWXq6YQmV3n/F3uOC0JaHUS+IfPAZHmesprjO4Q9feRnoW0S4ye4P52jajNEMZqkkmKsl+7fTMcPjc36zWcdM4ogGdvt/+QigO48JcSF4PS6WTLEZB5Mz7fjSz81JWaMmeVS7tmUn6sTokDqrby/cVc6NS7kNNTWlSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9; Fri, 8 Mar
 2024 07:39:47 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2%6]) with mapi id 15.20.7386.005; Fri, 8 Mar 2024
 07:39:46 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "Drewek, Wojciech"
	<wojciech.drewek@intel.com>, "Szycik, Marcin" <marcin.szycik@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v2 1/2] ice: tc: check src_vsi in
 case of traffic from VF
Thread-Topic: [Intel-wired-lan] [iwl-next v2 1/2] ice: tc: check src_vsi in
 case of traffic from VF
Thread-Index: AQHaZYu6mLGGwzgs/UKfiYLkhqjfJ7EtjGuQ
Date: Fri, 8 Mar 2024 07:39:46 +0000
Message-ID: <PH0PR11MB5013A68360671075AD95F4E096272@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240222123956.2393-1-michal.swiatkowski@linux.intel.com>
 <20240222123956.2393-2-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240222123956.2393-2-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SJ0PR11MB5183:EE_
x-ms-office365-filtering-correlation-id: c8b20d22-6ed8-4d80-05d5-08dc3f42edb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CiAeWnoO/zvL6UvaPrTTuCK5o2bVOmRW7KsSTUJFMdIt5bD2zhG+mRXfE8PVF8mdpGdSCT562nhZ4qLjBJHn47ngTj7JzRykRt8n64aPtnTgZF884naOZytzpm+GL2oBHsa5CRhouCuyEJ1pdh43ri7HgLONMXnmySFAUgQLdjIo7/85tjWIRDgyGWWl//dEQnK6YzPirJg+IAsG4L6x5HW8g1GMdlPVDbE1/oZBdXIiukuaAKTUskTK0sGqXEWYMy5K/sbS/PdjsfPHkJ6eGY61TXrZB0sGvASr1Hs4lhm9WOccPmUkm4IGIspSZsGrqZOaOmlTZKce9ucuLo9f83dGrZZnWpKnEoKhPrapxWbiF3UEhdBPS8vHHYj58fu8r6MJDfo0NHr9HbLPWEaHXA4/p8adsiTFy8StZNsKC0XRwvdBpZNBb/APjXeDmKv4oU4JFSKppRRxGA5MV6tq8q8cE3I3iZctU3zBDRNNb2g83RnbcPsSrEiYdLP4cl/na1EiuMQSzcRhUTZ00dyg1RqA+aHAHHrXW807MXEA3d9T9ONqzgv2xjPLCV+ju2D54hsP+JknaGtIehJXy+AmSNt4mFcOTSzE+ATmGxtNeR3l0chg3lehwb3hP8opGI0lNuDMiDc4nuo8e0y871+z9M1CcAfCBmg7QjsvF0p8w4TlxGwpJC23z17eE4pFgrG4vGz0835gDDs8Y+R/+W1hewBu6VM4wSqs/d99F9EOoos=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m4NmIWsNseZJc/03j2UF8hmuB3EtoPDlaK4/ubwX+2H9Nd38q2EK9UJD2KwC?=
 =?us-ascii?Q?5hZCQWWcUkvUt6nrpSZOqS8O31jWwm6pNCjv60FvCxiRTlWHIkHo7KX/M2Ym?=
 =?us-ascii?Q?WY5K0uVV1oZqGPh3JSCcIt7UqaurMeiKCDa1vNPsO5IIvcVTLZTxrL5hra7K?=
 =?us-ascii?Q?k2RFgfebFvFdLsijMyV92P1CsxSC5d8AAlZyWXhlHKEXLZ86Ik9JSGNVBkse?=
 =?us-ascii?Q?WWtIye4MZpHREOaJWlyPAZu4M/a4KEHUMPVMOyobuAbwg7qq6n2NDWWAyV4U?=
 =?us-ascii?Q?EG3BsB28Gqcy15PTdBq9ORSdq84RXwm9hBt/W/ZmzElbH15/YFeA7YBTRVdl?=
 =?us-ascii?Q?vTdHeU1CGsMtvjvIQ3msk3H5fr0k+64wdC+/4RtSmxLINL1BURoiXdrvYyJk?=
 =?us-ascii?Q?5xcjK060etcCSE1kNBTdpBcc/pM38x9zpmSklO0HaRPRAjoyZBzRTMqmNg7X?=
 =?us-ascii?Q?0S4x1DBjJEhTYASPK1197MQJiHB+kyvxqNRQ04mKJd6BvkWiMCDUUcwLeG7N?=
 =?us-ascii?Q?q4dyeJWQaBEAYI6XPcWTbNGEVRiO51X902ECtA/dhiydGUWVXhpZ7ztSl5F1?=
 =?us-ascii?Q?5DQemloyqWxVRalasmtnJNf6dWzUdqaFfyB1dUDfI1zxZewLXJUNUi0IhhT0?=
 =?us-ascii?Q?4YptuSfhNsDKldeAdODXAKfCE/ECXDxUs28EJrEB6SuIVn/9qRHvbQBz82IJ?=
 =?us-ascii?Q?Xpbzpbcjft8Mph38Li4UylJ8Sizg9nxXjUGTLKkNHIEsG+r+hSaFGLl/5UYs?=
 =?us-ascii?Q?KwpoxaLHNKQRXFGBWs6Giwn6TpxMBjaRZA9PDUNdo+g3U4y0N5nDNm1xYmM5?=
 =?us-ascii?Q?0D3G6BfzDqq8bqErFcwCGRtlQuokjxJubdeL/zjtTM9urx5KlMjpD+UZWS0X?=
 =?us-ascii?Q?sYap3DjhZThmnd+MPuB+12OVhjNvxfyf1PieFv/ePurz8CWgs0bLRliDtQPK?=
 =?us-ascii?Q?vPbzPBG5wusWknJEMsy07xCuqx0/Z2+4mxwuagdO/MoTSJVWkc5ttlqZ27lT?=
 =?us-ascii?Q?oArv/t2QBuKvziqF2rDrvc6TdGqVwT26Lo0w2PvS5hkQHvHiHd/Ngt6Q6o6F?=
 =?us-ascii?Q?Cf2n0Jzpy51NH0Pqd/9wI25So0n3VbXIbTpAPe+bZdSvtdA3b+I6myrsfoNF?=
 =?us-ascii?Q?kT2JCl/4ZPH1mNBOnLsCiXHMkyrKwW7HdXIX6sQ2bNUlCVH+v/bWPw737qLE?=
 =?us-ascii?Q?N7E4PKABtwKiYDd9bIJUlk8bf8347IIwCX/pKO+3rhzAyU0UhDZdVsqFQN16?=
 =?us-ascii?Q?SFL2WEDf1SmnTflnNRe9mJJFQGc7y2ygCvguT2ad25pNh8AZWA3jNm62Im2e?=
 =?us-ascii?Q?RmXDZZU1pyoOS7kH8vjDB9nmcrk0sPJJ0bAs8ZWWt1+LXLmbCSWkjgc9Aif9?=
 =?us-ascii?Q?84X5wV1Tm8aU+H573ymd722jvUL06WmIHDKGVhtGhmQ3xojp4Q979RxEO01G?=
 =?us-ascii?Q?8obeiaUzvXOytugIm5Ln+jK9vzKWM544hozAwysVP3gtbIAibi7CN2q/bwzR?=
 =?us-ascii?Q?bYg+TIuwML96NNDOj2aFfiBhZRDqd/raoxmXCidwaOItxiWCNNYVaQdlp1tO?=
 =?us-ascii?Q?OAPrMi6BkXlOyLoRL36O3XSREL/A8qDqQLHupEpw1+7D89Dftk+QlSGW5Nr2?=
 =?us-ascii?Q?PQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b20d22-6ed8-4d80-05d5-08dc3f42edb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:39:46.7944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ugdD+1KuDHd5Erp8XpfBFXZw8403s+5uphka+JhswEGwyAKMlQmnWY5kPAC9F0+cfo7RbX8YhsEDCSZN1g6EbbcwlywjjZdyPZihRwYCeqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Swiatkowski
> Sent: Thursday, February 22, 2024 6:10 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; Drewek, Wojciech
> <wojciech.drewek@intel.com>; Szycik, Marcin <marcin.szycik@intel.com>;
> netdev@vger.kernel.org; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>;
> Samudrala, Sridhar <sridhar.samudrala@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>
> Subject: [Intel-wired-lan] [iwl-next v2 1/2] ice: tc: check src_vsi in ca=
se of
> traffic from VF
>=20
> In case of traffic going from the VF (so ingress for port representor) so=
urce
> VSI should be consider during packet classification. It is needed for har=
dware
> to not match packets from different ports with filters added on other por=
t.
>=20
> It is only for "from VF" traffic, because other traffic direction doesn't=
 have
> source VSI.
>=20
> Set correct ::src_vsi in rule_info to pass it to the hardware filter.
>=20
> For example this rule should drop only ipv4 packets from eth10, not from =
the
> others VF PRs. It is needed to check source VSI in this case.
> $tc filter add dev eth10 ingress protocol ip flower skip_sw action drop
>=20
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

