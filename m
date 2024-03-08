Return-Path: <netdev+bounces-78619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD5C875E7B
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 08:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7A8281864
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827BD4EB4E;
	Fri,  8 Mar 2024 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0PJ/scX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF354EB41
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709882969; cv=fail; b=nW/St8AtH+7J+Tkkyn0Dn3vDLH9bcQ+qmjC9QnA0vmuTRsZIBHK7i4vqRsWhgSNJ1nVuiRVADApZJOPJTFev8fbPym264R0+C4C//RFgGz2Wz/Q6qitAgRsurmc6aBPw6MaSaGR2zN4HNEvTTPb0Z0ZpaspX1/Doy63YLCZKr7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709882969; c=relaxed/simple;
	bh=xpOPvv1DMn0QbtDmGwQt1dCT3fcz64+XUM/JL24QTRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BFaNSdRoxH5aPGdhRgQmra5Q2COzFJbb31Ovt6nvhTzpJq5Gis8ndOQ0GZu0M9wApRB3AIfIKOKvE8f0mlYVILKcO7WMLuM98IUWHU1uisL6ooMEh80A3uDPRqm9Pe6m3HuFwqFKYDNBI9AHydWu0w+kIulM/J3zYUnV0HkCZiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0PJ/scX; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709882968; x=1741418968;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xpOPvv1DMn0QbtDmGwQt1dCT3fcz64+XUM/JL24QTRU=;
  b=G0PJ/scXzmpkpauPu6lrVzwQzZ/vq86llOB5GguHfgj8HTIb0ttg7+yR
   La0SHcJ5DIhRYde3cEuPq4Xh2Ga68btzqVeF3sPgeE+m44Df0BIWIBU1X
   brMN2TzwIuLNA7fQeEjo40RMW+adP3aEQi8CHTyDLlWfRDsaZ+Zc3FVY5
   UeQUDQghoFegP6fKN4a+yl2nJtQOxs/UGmBMDWcHGrUn4mJ6pa2eZofEe
   EVkQ8wxOwU1U6zCTIj5BfUmdXrfFqTDCot68QadqAuKQ0/nJKi+haGtb4
   +Exy8lgXrEHfr5/fYz7dxy+OjbCWONwVAELDjAPepeAXhYtKysO1emS0X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4451294"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="4451294"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:29:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="10261614"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 23:29:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 23:29:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 23:29:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 23:29:17 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 23:29:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjqCqOgdfz9TlFy+9V9mozm+EwJ0toR8igcm3WgtqjJ8w8vBG2qUTN7UC5T+WKW5ARvISZI5BgSfYJRA/6jNyJ6zQdlxVm2r/86oWXOeCmK6X13m0TeMF9ObCYH+IhxSNxpFjUe3M5XCajolcn3BhJ1QElT0rpeDCvq/LpAPr6934s+u0MZFwmbfYJroNNBCZIoiFk/kcu1VgiEXBkITd3lQDOt5thwq65ycrmB9Z9IrNM2N7FZ/W8EJVf0x7dTJl6rzxuiXYTowJidWSpbDRBzgaDd0RsYrnZ3tdNWCwFmL56VPX04nG44cdiCq1nePLWostVYizabJmbpd+n1V4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Iu7YsVr+qqPRs63XEslZXwpFtr2P8M27iIeh/c1xeo=;
 b=cNM5UoEfWGJk7ckDdljg+XQjY8ECxr+QWcM73S5kTYMg7cUk0St5+TlrRGV7x9F1sRWJHM46FpVivF/DDWzpYZ3iQmi3uO9qmDnKmDfnXUzTSyucdaXwi+etjJyoj8K6G3EDeKiR/vXyGr41e9UU1J/ZskbNLEubKSJoPSYIhe27HWdshrzukkPmjOp0Ww/tzE0HQytB3UvBf0d5XNXTPvkwr2z0AmvXOhPPeULiGqi4UTMiGeNB8puADWUzMWWCzQdTITM/QfM7CMnM0yVFJWdwkkCETPA4X4PEJu047hGvsY8D2BtvwYAg862s3TtcOmOJp4ikzakKP5+vG1QIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Fri, 8 Mar
 2024 07:29:11 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2%6]) with mapi id 15.20.7386.005; Fri, 8 Mar 2024
 07:29:11 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Szycik, Marcin"
	<marcin.szycik@intel.com>, "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Marcin Szycik" <marcin.szycik@linux.intel.com>
Subject: RE: [iwl-next v3 4/8] ice: control default Tx rule in lag
Thread-Topic: [iwl-next v3 4/8] ice: control default Tx rule in lag
Thread-Index: AQHaa86e8i01a00FukWLNGBCnWIeILEtfPKQ
Date: Fri, 8 Mar 2024 07:29:10 +0000
Message-ID: <PH0PR11MB501312B60BC7372B3F5C465196272@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240301115414.502097-1-michal.swiatkowski@linux.intel.com>
 <20240301115414.502097-5-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240301115414.502097-5-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|PH7PR11MB7098:EE_
x-ms-office365-filtering-correlation-id: d24c773c-da5e-48a4-77f0-08dc3f4172c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7uGZ/e+WK+NvCqXhYSFv4i06d2fyeclK4bHyuX94jX/4oA6Gh6IOtwvRyx/5WyoMpM6yvj9gB9GKHZ3tit9JRtd7S5oecMsrdYdXfIcC3/v4prPSFGp6HmIPJgiMqB9zTikQmISbiT9kNOd1ZqA1JbeERP7u2XnKiBZ1FWd2OWMn8idOjSdLFB3kjQfXMrv/lDew/2a8BHl9A3XkcbU5uxE1nv29C1RH/7OTRWgpwcap63B7VtrtjH3nzh/DGURbIIpHACKaLKtWOCVkNzazio8EeAkzZxVXcAlZ6nsx2+/OJ2DXnj0EwtWoYS40w9u0cdFfB720yhIgLp4dYRFiUB7fTHzhcg4HH7DgVvlKQh0RJ8KZ/M7SkyoU4cuBXnq4//BE/j3N/6V1hYrmpD2inmGYSFI79wuPZ3NIPADDpDtOZ/swGewLBqYrIaUmK4e5Y0S9ChroIesSny6TZay1eu+UGiKKiLj1Fa9rpGPcQb2/jUTqJYQIwHnf68kBh5VqHq1mKrr9FWj50SjHC9RnZxMf7MDhK2ch5ahb1wA8A2BChqxvPhOGCTMAWX9x+s9+/3RbA5PZvdsaJGh8u1zC8LihvRPrs/1JE2U1UcjcER69msRbAf51Q2PhVvETZMQG/nBh5pGH9EmYvTUi68BtWjbuJ2TBOhEUEu+HMAnbywPx15emlBnB7VkFIllIFeNUaWxdKw1FekyYS0/C2eBAuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gE2L+5fCu4a75VWMMZEQiGoIINhQ0czsta34uYL++3pIrbrsW/M/ZIO7EIGo?=
 =?us-ascii?Q?lDfQDymYyn1jW21xYURVaf3TZ1C0zcgTr02o3XpavpRcLDjLuESjA5LEYg9c?=
 =?us-ascii?Q?krTPFZbnrj0foPQpQEVZ0GFtwk8qcGjNkmmfleQklOKAUu/wi5qZYi1V4WX4?=
 =?us-ascii?Q?TpcIilA4gl1IgUJBpHDQwDcDoa/yQvxudMu7KCI1fpWqxj9EDyNNkUZaWvwU?=
 =?us-ascii?Q?8AySwVwW6ktnqI2MCPaUHVzT58CZL8bbVAp/xgOJTbavL8Hvz0m4VDymgjCv?=
 =?us-ascii?Q?c5bHAgKOUGB2n8p5KS8doPmjoNavNLLimI1aQsaWYVc7CkyZw1JJ7/JOs/V5?=
 =?us-ascii?Q?cexPoMv0huBswVZwFRFYGSdCPuOxWLdntEvLnj+dmPlvfHkrOBvMyV8/I/Cj?=
 =?us-ascii?Q?rfAJxC+epCAx8A/m/m3rqk1IA2IRYJS4VFXiy55SwUhDFg3J1hx1O2qRDrfd?=
 =?us-ascii?Q?xQZ0XSqDIpOr8iKmLlkEzlAtoWZIIr43GUSJWyOGGMxno3Hnn8BvxoTu+0hr?=
 =?us-ascii?Q?4YWZ36+DdLt/UGfJOw4knW/pWWCi7P11glgtxT9MSjcMSChOZKRzbAqH146p?=
 =?us-ascii?Q?qkB+Jm89Hk69DC5q8sihAt6nL9Wgy4RE55w7g9Gih9iBdptE6qKlXK2cYYcK?=
 =?us-ascii?Q?frfP+kCUX2ad6UqfDep1b4vgHibC9GG0ZasDQt+DS2QoBi7ov5IuoRKPO73r?=
 =?us-ascii?Q?7sL0XaKxFkwG49Gf+PIm1OMSL//ML35UO5geTaXFYfLZe6khFxQ43sG94GCj?=
 =?us-ascii?Q?5p06Xtc/tjG2ie2ppOMMc4vQIlhINmlzZhxkCNzy963xVAAnX7D7dVPPGuU5?=
 =?us-ascii?Q?mmTaa8AKuslSUx090Ctl7vDd+pGyaOvEwujfWzGnB8+rvk5+gzzsqPnAGMKI?=
 =?us-ascii?Q?t2PfkSTY/jsy3kI+piIo/1Lev220RosZNY3tULcZoUEeZYwivKGZelVAuc6g?=
 =?us-ascii?Q?BtZze46OG2wV/nYXqnpy66SO9MFsZzdwwniu3Ev5JovpJuJkTTzWCjVMuGlt?=
 =?us-ascii?Q?vseclouniWckXq7J7Scc8xpOfJImesgzyPXbqt3QVUuvtbBNM1faOIoxcZmP?=
 =?us-ascii?Q?q+DmtBh3YOXd/f5mC8uyQofhRg8sexwLpdgK5qxqP10NjrfvhVf97KYWG8Qr?=
 =?us-ascii?Q?3sNj8sJUZVPY02aeFey5KF9rkqxCPcccpbPP0IUr/2c3oNvi/ajYYDgoiRhh?=
 =?us-ascii?Q?lFBc8bBjw6luSZ0YxsOcixYH5s1uMnXZTlwHfOqaJ3Jd/oYhoJdpBtNELWdJ?=
 =?us-ascii?Q?QMShWk5bVoq9AdxoImElevkIy39HP4ncZhCsXPQ/rSDRHJbC/nsjSL+/uOQh?=
 =?us-ascii?Q?yV9Ys8LKVjT1y1wxVCfvJlCBP2FuBrWM69AV1kW8OA+2dIQ1zgwjbuPEjYi0?=
 =?us-ascii?Q?fRcugr/3x/bXS7B6MPrFmdbl+lZgVIN6MPEqOD4pf4M3PaQzt4m9q3W8HONJ?=
 =?us-ascii?Q?q9wfMANBefQvVmK4u8hdR6iB+wR4gu5FhitDpR/nwxopPb/lXBOB9/w8Myra?=
 =?us-ascii?Q?gXw7OrhE6Kdpq6XiFVHhkE/LYkS+1+Bjo6cg0otHc7kEkRVG5O26GWz7rn83?=
 =?us-ascii?Q?ZhwjuHORAX5q8J3JMossfrFFlFceFd6bNjjOyUvlr1jRvjKATWIDwdr2Z6vV?=
 =?us-ascii?Q?tA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d24c773c-da5e-48a4-77f0-08dc3f4172c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:29:11.0261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTTeuhyZg7KWjfcDamd+12RbjVnhBNZjOfLJh4D+5eH/ngHJsNYLV8EXCKWp5aF+zdumCgT5OwYwjSEqxPkEwketk/mUh18Z5ZuZP9H+xsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7098
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Friday, March 1, 2024 5:24 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Szycik, Marcin <marcin.szycik@intel.com>;
> Drewek, Wojciech <wojciech.drewek@intel.com>; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; horms@kernel.org; Buvaneswaran, Sujai
> <sujai.buvaneswaran@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>
> Subject: [iwl-next v3 4/8] ice: control default Tx rule in lag
>=20
> Tx rule in switchdev was changed to use PF instead of additional control
> plane VSI. Because of that during lag we should control it. Control means=
 to
> add and remove the default Tx rule during lag active/inactive switching.
>=20
> It can be done the same way as default Rx rule.
>=20
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 44 +++++++++++++++++++-----
> drivers/net/ethernet/intel/ice/ice_lag.h |  3 +-
>  2 files changed, 37 insertions(+), 10 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

