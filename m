Return-Path: <netdev+bounces-280640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OGGIu3L6WkKkgIAu9opvQ
	(envelope-from <netdev+bounces-280640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:36:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD01544E060
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB4BE300DDD1
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFE62D0C97;
	Thu, 23 Apr 2026 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxd1VGXW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC25F138490
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776929566; cv=fail; b=lSAy6FA9WT7jjE4Fagz23I+T1bf+N4Juv7SPfSJFfNqzz5bG+rwsr6lxNt9dHSsWLx8CQiQKrioQn+Sdjs1FeN8vokp+5Z7YbmKaPK6I1mhi0ELdUqQ9BkrfKg4VO7gVH5TzecotaWLknFvYK5U1dvNfp/ob1EUQGdDjpCSM9Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776929566; c=relaxed/simple;
	bh=E6CXIUhBV8cfyd07klsVouHtS8+S3+trF8JCL0n7GoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fZhRwgbII41Aff6mHQ4tpxGFjqrpXQCtvOA/P/isNYZRfOBxlAuE/BZrGE3G8xQ4oCbv7n804jT+gUAY4hZ3vXV0tkq7NfL7kPTxT9X3Qnz6T42+8zMWHT76+IbAG/PAMZ0hwDOzQR9LmlYaQ/Ic1ViOcJdz288RiX0z5s212lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxd1VGXW; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776929565; x=1808465565;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E6CXIUhBV8cfyd07klsVouHtS8+S3+trF8JCL0n7GoE=;
  b=fxd1VGXWp0iQO6aEQVyMpZHHM0nbFBHOjf+pi08gJ47R5RMswzf0u7ql
   9t5fmgA4unqgnWZ9g89a2Lp/BuDpbESHFo0KAcknrunLSq97cuQ1MOttv
   2O2ACt0OG6lZWhC9BnA0A+56wVidE32ZdVRdY3Zcfiy4YKTSg29JbZ+Md
   4aJGLCgzFi+x+wH323LCxrGyrx4g+irnjmXjs5DQmHxzyEp8ZijIX33eE
   3tzuff9yn7XBauiflb/7oGnlVG9koFgdeYJc0Ecd6qBmhIRLrLOCfGxrS
   FNQFj/Pp1lgaU/aTV9eR1QofF/DcLLY1QYSu0mhGzpkwfSxEvLLu1QdVD
   A==;
X-CSE-ConnectionGUID: oWCEuVauR3Ov2dCxy/yy6w==
X-CSE-MsgGUID: HMy545LUQ4uxl7sIJ+vVNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="76925774"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="76925774"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:32:44 -0700
X-CSE-ConnectionGUID: SxSFvkvvTmC+oB6SCtYq6g==
X-CSE-MsgGUID: xLR2hSWWQdyuzTx9Q/ytKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="231703890"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:32:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 00:32:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 00:32:43 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 00:32:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FN/EMxPyggG9HHhdr0lV63bW5aMbopu3RHCeAUWertVRN8Vww4PYbuegnHAU9GxfNf5XGGwA7MdQWeIW8yVOebIDzbgRx1pEI3SWpIjJedXqVY0YTJsgSGKDZkH99wmHiza2UYStFzIm42bRojsmr56PQG86DX07UAGL4WJDj8+1p8gGl0X3Rl3bluyDzUdZGtqMUJXjcPoWqstgimSzHD9fa+rvcF8LiC+RUpApng77SIwtPZLXiBL7XD+llKU6KHfb+dbfxYJFh+QZ3EJj8askaML53ZfvwMvmCv+1uJvgzPNE0+wsg+zJYm06PghMdd7tjgHtQE+rhb9fW41UPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6CXIUhBV8cfyd07klsVouHtS8+S3+trF8JCL0n7GoE=;
 b=a368Ea7BnABLcoBOzPrHR4y2vB3pmMYk61E1uBIhfICRFKxaRjegnh+1G9NYkwb2cMQPCPO/NPSZXI7Sk7hbenKamCabzzu0Pecezw8L+Udu5ifpBH85xZQeO5giHfi567waIRk758TeMF7smh9hi03U6aoCB7BvprSXD5sx2P7mlRGiS/5kQq+cfdpxNY1dxx0ZzsVmHl9NC4mMr4pEXFcsbcVRdIKEDkFUDUgRFqf3dJ8DfkIflqGjMMPiE7129rUD0/y+QPjAnD4j9z4rxn//uSM28x/iF7Toi30VoZ9cN9jk9eaoeLdCe8IyltwUlEUuIZ5HwOH+o/90/TgaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by BL1PR11MB5240.namprd11.prod.outlook.com (2603:10b6:208:30a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Thu, 23 Apr
 2026 07:32:39 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9846.011; Thu, 23 Apr 2026
 07:32:38 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Szycik, Marcin"
	<marcin.szycik@intel.com>, "Szapar-Mudlaw, Martyna"
	<martyna.szapar-mudlaw@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] ice: use ice_fill_eth_hdr() in
 ice_fill_sw_rule()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] ice: use ice_fill_eth_hdr()
 in ice_fill_sw_rule()
Thread-Index: AQHcuCdLtTxsGIFEfUa9oxyqRUhDgbXsR+hw
Date: Thu, 23 Apr 2026 07:32:38 +0000
Message-ID: <IA1PR11MB62412EF2E672432E8CA40A1D8B2A2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260320050556.422762-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20260320050556.422762-1-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|BL1PR11MB5240:EE_
x-ms-office365-filtering-correlation-id: 80653096-44b2-4de1-890a-08dea10a7f1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: yL0zzHnVCwEJZs2yhSmFI7utaumouSVHkL8RBxr1NjVrmEHNN1pTDo5j0NMESWC9l5jcRcjUp+DMQjFj4ziBlmD6DSPS6shPcQZTAqLCVe8Los+cU8IONI8J0SCVmnFdLPJjf2NN5c+kDYKhf/KGqEvSwXe2wzMPGSUcbsgrvKvjwvPnDqR8CPcyw/+WcTg345JJS3kDaz+MPaacrdvwzx0w7gpfJ+1o0kjqPMyVWqw0PQB3H81hhge/GWYpI3K2H3xfoT8hwtsb/KWWzuM0zQYvh8116yUzgBUumrNYBvM3QY+AglHX+hIf4eqla3yIgFgE7ZyPfK48YlGvCwd/wrT9beEm9wgVQpaa6H8C2lXYW0JcbxeG+l5wBsGkvu4HIE6QFFw798OaxRVOlBBcvxpZHb1cTZHk6XIgJy7CycEzqf+xBdUPqyVBC16dH2Sd+NjmJe/BmSOUTVhqDmAmCYJTCebOZt0vklDNoCgzUK5V39SlQXgMS78BuWx2MNjpIv87LlC/e61MWUmuXaFU8z3Olamk4i0vVsi7xdjIVJEFLRzcGB1L3ktFHjG3VGUX/ABzZ7kr4zV2Z7ISmwkCV0BN1piyWEAZWFj5D1XKSiSonj/JGhJn3D/VC5gNwRzzMmOCQdto3I5GwhKejikxo9klDyMq8o4Zdr52OQYxTwf0pYD3XDwmr8NjPMIK2rVPEgifxc4s6fK6wN1LFhqD2/azvhdk+hGokt6R3SBRZLKStKQczihFhbSSP+xTjsiZ04sVUEwsB1aR2ctZBTJ+Let+2agtB5nyLCd8THu3aq8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cQJmFoFiWxgefu+tKwJjPHxnCXJt4iCR/O7f5w4raFn9RCOgzN6lUhOeanC7?=
 =?us-ascii?Q?Nwxwpa6/KzDKUnygNOc8DkCE7FXLZjvUo/xJ6yb6DPG67+CZkOBgIEa9gK//?=
 =?us-ascii?Q?g2UEDCpHW0G5lHcZGx7IhrsNgwYXa/HhcKQYArGpH6izvJOzZ7a5hKcXBVgb?=
 =?us-ascii?Q?iL1silIahf9Fno0zJAef49zH9nPrwl4aEFluvBXbWjax3Eq2hIw6cqTtUtlD?=
 =?us-ascii?Q?eucrbTUvDHmLEkDrZz7vN7oaNI9+XXyKH0A2WwS17ETAMyomJejv+GVjzUnF?=
 =?us-ascii?Q?tCTatM85dStlZ5nDV08FpWeZVCVcJZXEz8IjEQyYrdod82txXoMW+Fs32/Ay?=
 =?us-ascii?Q?NgJeQG0yzO8W99Ko5RAWyJa7Pb5ivNjuAWUoQQ/g3tDRijnkHP3lvDWOEftO?=
 =?us-ascii?Q?LTdQAU+/Ov2fSOXeb0Bxm+xKbhJ9w/AvmQ2kb67x+jEkLvv1hLdXZvSA/vKC?=
 =?us-ascii?Q?pbzFxupstEFJ+pG3wMiVio6CbkzupPZnfuIWbYQ348zNi7J2/cVwcC8akxVE?=
 =?us-ascii?Q?XMvs6mE0Rv+01ZyPkz2otB78KaQj7A5DbJbHmzWOzBu+wBImz8vl4CxKJYp/?=
 =?us-ascii?Q?MojcGbRnFBxT2DwbLU4jXf8xUB7k/mDWT+x7a/Rh8BhWb7TFFxsEdhw8qo5a?=
 =?us-ascii?Q?9VW60XASvOVCSTldrGtn/j8IHNIg2OdXstpiaVbLJwNXI1mbatZXe4qOVztu?=
 =?us-ascii?Q?1J21IfT2Rvg8VAAMQ2mEJtHyn6UFkttgbNIJfA2nKTaFeBESC6jAgbEUWBd7?=
 =?us-ascii?Q?44L2f77gXA2XtOQ4zvBQLA7ZVKB3xvDz2CxqYt4B66abw2QtI8VQYXUQsFVD?=
 =?us-ascii?Q?xfSrBVVY0Vc+ZoXAqewRLt4zp0VtH+1635fW2CRFJVhWy9w10xn8wypMErfb?=
 =?us-ascii?Q?6M/QlQ6vHemvPP/Ha48Dj50OKhh3r03YZZAouuEVT+h/ICpb8WZatcQOW8JX?=
 =?us-ascii?Q?zEP7DUSSDyy+o3gUdCc5CtWLo68V4mZw57bmCo0VZB/beHczskpcIJr8warz?=
 =?us-ascii?Q?0R4tuX3iiCBIt2VtDl4H+x/govALNGWbtwkmVTe3OZrbYZytwPv8CJFhJ55n?=
 =?us-ascii?Q?+i5L5tJpPZW/f8BuJGI5I7PTKLZ5+OIdt7clm3LAto6xhK7CHUAvJhVToVi1?=
 =?us-ascii?Q?Ch910Y6SgMG5EpM7PjqusfEP0b0DxTwkvrK99Ln1bJ5jmXSkvbPZ2FNEA0Kf?=
 =?us-ascii?Q?kJduKtT1XGLPFQ1Sw4dCfnZ3mnUciYoGlMZChtNM4tbvCVDyxqNJSvQtuuNR?=
 =?us-ascii?Q?+UDtyTYdtUNTV9DVG6yw5JzGOgyvqzwtTICo5rWgv5ifMqpf6y3yR6ynl3n6?=
 =?us-ascii?Q?qJv4LENP0Z31xyyNPwum0WoxVgO0fc8bWdTm/9Hxauv7J64+GnZEfn3ZUY/x?=
 =?us-ascii?Q?WFxrIFtAqiwLf2jOoOSxYEiwM7DRYZBoIHerQQQfZwMtaMf52wAoVd6lAxKD?=
 =?us-ascii?Q?8i4uv3P9HUsokrTV1C16wQ0mqj9Qxc4/c8kmUTx7H04ulIccz7KSejdNh5Sd?=
 =?us-ascii?Q?qes1JRkJX2UCckAtiZDkAOrZk9ZY2PFv4Cm1qvS7qcuUnJjGDUc7qpZashTI?=
 =?us-ascii?Q?zCe3xEgqhy6rFCRetjQG1oWVV1U3+ilo7RT1ATZIyNGCjEzkHNH7fXwMyeWO?=
 =?us-ascii?Q?MvyndKBUiyXr1KvBGn68v2yHbQVnwmCDpadXy3vHDp7qBEf+LXwQMdKjf5lM?=
 =?us-ascii?Q?KqX9P03xwxoYUKUjuU9gr6JG5jWmzD5es4ZSYxP8BKl264eJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: u+KCcn7hyHz2Wy2Ahbw8Ybc4bnUH8alWpOtHBqUbBpjck6AjpZ63/9d6/Fpyi8E1gQJltA9RPvWjhyi7enYh1WhFlpiZ/Bb7HlvSXobGVmr6j3renXa3/XC4TjvhqAIyi7I98AxDdL7Mp/x/GrX58lMlrOnIl/iNbNhMg8yNwXg1t6NrmczrIuDH/6pYp4PmND8joOAlK9bmTVMgqu6LP2PiT4lE7VOBLFFnu2t6IruGp5RJOW0IrTB5nRxFxvQOsV19EGXP0k3/Ozq5pKOKHUC+POvr/18jK+mOm6AO3omKPPqsHvLFZfc/IpNGPUdx5ZAk1CcGV0XgbI0V17YJPA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80653096-44b2-4de1-890a-08dea10a7f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 07:32:38.6885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQfRhRTPPUAoW700QbNb9oU0iVKTjqog/YjUkI6PhLSMguDhQwfdKq6gMY9B0dNOWqzwi/mIBuQeEGylI/MJPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5240
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280640-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,IA1PR11MB6241.namprd11.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BD01544E060
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: 20 March 2026 10:36
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Szycik, Marcin <marcin.szycik@intel.com>; Sza=
par-Mudlaw, Martyna <martyna.szapar-mudlaw@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next] ice: use ice_fill_eth_hdr() i=
n ice_fill_sw_rule()
>
> From: Marcin Szycik <marcin.szycik@intel.com>
>
> Use the already existing helper function to fill Ethernet header. Also re=
place sizeof with a (also existing) macro to reduce the number of variables=
.
>
> Suggested-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_switch.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

