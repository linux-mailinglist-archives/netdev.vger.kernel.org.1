Return-Path: <netdev+bounces-280416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHXvG43E6Gm9PwIAu9opvQ
	(envelope-from <netdev+bounces-280416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:52:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E790C44633C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC670306D1D2
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BBA3559F5;
	Wed, 22 Apr 2026 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYQd3D5w"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492E73F9FB
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862099; cv=fail; b=aqh0/UfzM5Vm5VOT8ewToBCo1EIF/JnAw0GYXMzpTd0maKp+pWYoa7TyIbYiA4Lzj4+4T4TWmcNyU97ecGYF27Yec/wSMWJcSE8y5HeS3HI7/uziuW6hg6z9mv/KGpySB0CUi5ka6O4BcGnibmS1i1OAjf3gf8hnhAKWecBMSMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862099; c=relaxed/simple;
	bh=0N3u2z4ENc2oHMdVRV2BHQ3bgb3x4b1D+2lJtaH/Aa8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hTPtMRwossfOemEEgJLH87UiXsrtXYozEBIHGdEPYI45O3nxQIbR32QAlLVqgpccYYpwRkw98Va//XCrxTQgy99J9Y+/hyqnY/aqLjs/t5hYFYSFfA3To/6x6wIHKubmxqxeSDs5TmDI5RodC1tkXufU8+qDcEl5hTEMTJqNn8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYQd3D5w; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776862099; x=1808398099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0N3u2z4ENc2oHMdVRV2BHQ3bgb3x4b1D+2lJtaH/Aa8=;
  b=TYQd3D5w3ONKms6+zxt4iwbkTOY7dbBeRpjAKcMfGrqFNNMAOsOcbbBA
   N4Gl11TXJOL4i7tTx7Muru1gp8Lm5/ITUvzZYPkya3QyNYG9W7+tcF4dg
   IoNCbBqj4Ncl+/YGXBo+zHkCGtmgchqxELRFeFF9EzXQtu3g1SgezeXVS
   kNB6At2iwpSV3Yk3mqyu+14qk8bt6hINojmI8MDmajz9hAJuTe/SRjgKE
   DCcwg+kLaV6BL1dN1BvjDrc8fpxASbOUO2oTR9PxJRNZ0lUHe8CQUM+XY
   fyJWEZk6uUEBifq8qUnq33jCZxBSa2IQtxsnw+yBPCjiYKyjsR4sHsVs0
   A==;
X-CSE-ConnectionGUID: eV6/GTPbT+qoeSGYtj0ReA==
X-CSE-MsgGUID: 3XCFyza0TnG32RPaWyRZZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88114263"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="88114263"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 05:48:18 -0700
X-CSE-ConnectionGUID: NJQrcE+XT/aQLCWSUzwFjg==
X-CSE-MsgGUID: XtWVv07NR+25pAZ0esz9Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="234135012"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 05:48:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 05:48:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 05:48:16 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 05:48:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcM789TDP+TAMnm2xkzMC/UXz9GvG66J0ZNaQnWiWYJMrOypsJ88Vh00bhI6wxRChmxxivlbEG4tQRnBdE1Mgt9xnvo3oizf1Vi13+96J2dRve8unEcomnuLo05VFzrozb4WryOSeXLg1VaL+lrSNnml/Gy1TRquP0uXvQrU2JHfj+vUKNyvPKSjcKWVR3vEyHswuBLe1FKIG2IjHO+va9qu8xln2c2/LHVvo5nbYc0+vNzb3PZCcinrCO/FeTOfGJcewCjYlB1teNarOOGepBqZJDHMcNJ6BA5q5ddssrWgy53tbZpO9KJi8Ww6Gtr/0lKeGcUKPVbZYBteK/6HlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaGfxt/wXbbSWq2TNYoa6crvzefupK8yhvx9aINGTrk=;
 b=Tb7WgjRiBebEmgfqWboie8lb6sDWVN3Z/MYTtO6fJXpD/d8yZGUPpAFLF6yjXRwmj7HGSjEGeE7CF3U7vHZ4hG4Tx0tQ7tmYgA9u9386o+oE/0jRfawf+EZqhUxCl+Mn6lCOwT3vIL201El20d6Qvgn24LFWbfo0/CtU9NvKLIh+jjwm49r63O2AwDvxK7QDa9SqCurTUXR1+xOjvQ7K3DW8//SDHG23urFs7yz/5cTZgmR5aR6+RUPXgvV+FsgalDL85OC0tRjbJE/7TVZqAmszs3dOKbTw0z3i0rKhYokvb/NbOWnV73Imfweqvhs3WTJtomYBpAcZLWGtEdWP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB5944.namprd11.prod.outlook.com (2603:10b6:510:124::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 12:48:13 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 12:48:13 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: ptp: use primary NAC
 semaphore on E825
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: ptp: use primary NAC
 semaphore on E825
Thread-Index: AQHc0lSgTjM+RmuoAESUX5vr2Kzp4LXrB9lw
Date: Wed, 22 Apr 2026 12:48:13 +0000
Message-ID: <IA3PR11MB8986259801EE5AD5D87B5BECE52D2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260422123144.485930-1-grzegorz.nitka@intel.com>
 <20260422123144.485930-3-grzegorz.nitka@intel.com>
In-Reply-To: <20260422123144.485930-3-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB5944:EE_
x-ms-office365-filtering-correlation-id: f4bf58d7-e8e6-43ca-c35f-08dea06d6a79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: q54Fgh/PiMpJzX2Qrv9KuYklhpnwnWtjcG8iRiviV1vqtokihLmwD31VHLwUPK7mb1XcWrsasjjnIhqZ7iVbgTQcS0MRdnrvqhdSOOUnUJh6SPwf4z54NiFKD/kvpgaI7StobO93SRkaCyy9F1pi0PPkH6KsWUBkBFPunTFtCuJ2pqx3+JqTUBJXYi9PJyN8ZshGUlAcbqoG/xwmBjeTDjdid3TwCTXB3hUXxWY+lug1QI4YDEfhQuIILa90hXYJDybSWcvqlP9bteSHzOpRaSPAImPm4ow/J+AaXZsVDSJ8LLIeV5cAmToruRR2djO8kA0RGekB2KMpxc8b5l7T97vppEHmLdFv/Yo8fu07O2L+avc3geRJiw0cVvUtxCa6x67pUc2vW3RH4miBFtNZuLCzI1zKAQaaEdiYEiN6qdJfzs/DyhgFcPGgc778OT1v3TlZcuJspccP5PGZUkwaYdJM1UDyA1WDLUUtYIIVzhFVhJbRqJiWV/YHFMbnXrHrJqrcUuhDRzawW7ctkHs3e+zUwM/gUdGX7/iAwkyXq3dvfkQUVwSAr8es+hdym884GUacYxmqvya8mfhBVH2zLgSMFA+2D9MOK+hgiCTDjjTZq9xlGe1EELGiPcZpAFRz1ib91H3qO10vrfAMjSWCFcRRJMmvx+qDxX0pC+36KUjbhhVI78QIZ1E4m0j01XEYSTdqZWez/bg98jOI9WX0BsOWiOUyg95jXw70En0KyCF2jWRNTUw0tqey5WIq3dou3xFrwhFgnOWRG72slMwAN+wHkEQxnPv5yd4ij7iGkJE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RQz5z/+14IhuGq87fHZaS8BAjEZiZnXLr0r75tlx5VYF+RpUjv9y5S2Pa/n9?=
 =?us-ascii?Q?cl5wkLRY0IPNDJ5RDbLYP7SMnwmIVduivQ4E+oE86olnWkA/4Xjc2oNUpQdB?=
 =?us-ascii?Q?pRSsTZA4PeFZUtkhTOvJvN7qLwrHzGa8BWZy8M3FhV+jyt0PdETP0YoGCw/Q?=
 =?us-ascii?Q?NMnhtidY45B1yxyRhpIiZLX6onO1UopU3vSskMRqym3YdhfTE9GUa/9SeGES?=
 =?us-ascii?Q?DyrHYM5wx3I8qNYuMwoIeTCG53VBlzD2Y9L7NAkxgHswje/GEKCgMp/O3Bi0?=
 =?us-ascii?Q?IHwZ6ZJ45gX0xgXB35vNrmetKbu/q6KA93jrrCmbPWPYS+1lI1yWONOo3k+O?=
 =?us-ascii?Q?kyY1ZtrnifCwd+Px/alGZwq15eqEOZ+fi1nhzSVIFBY2jUDzdC01w2a6XyMS?=
 =?us-ascii?Q?GqPZGsaGshnz8RyAq2dpP49WL+WeQLmaHhf+zM+WOz4vIrlkCFGEg1mkFsZX?=
 =?us-ascii?Q?REBPu7oOmztESe7Yik2+2J4sJUW/7EK0trpJtBO46nMxBmiHmIkEZLQGCvNk?=
 =?us-ascii?Q?cexFXEaITWyfrEggQyKtt+iZsgM0+5q0eFrEkdCe1c4lKYDESSaTRI70RFS0?=
 =?us-ascii?Q?bu08XywlFUgbv4AYVr127RrUTp2jsEZUDxvKj/5q4x16X+kA9I/KEdwt8ZzN?=
 =?us-ascii?Q?VY2Uu/7p2+/ekWrz5loVAd8VczFBQafkIZGY0lFX+qt/fvMvrAMN/5TeIK9i?=
 =?us-ascii?Q?dcBkxwTxXVzi1PmTpYaptkGXGa8XfarWexPVIOdaQq7H03PUzrujXmxW4dYr?=
 =?us-ascii?Q?qCVjWtr8ZSHpJoTVtHpUU2YdGZkYuDf/qYNdvbDQ+etvlcwD7zghfKbNDrjB?=
 =?us-ascii?Q?vzOvgqweZPG14YE9RNvZi3ItPkHtTKIy3Ks4qvuxuu4sYqump4w5Xy86UoCC?=
 =?us-ascii?Q?YA3gKyVomZADMs6subNr+p44N7oAyQuw5RcHvmDOjQh3uUXhsnvVLmsaTQ55?=
 =?us-ascii?Q?M/H3e0/Dr5tAu8gHIrFVsyg8E7RUeksSzLC/qAqfcicBzD4j25JLOT1QnnoS?=
 =?us-ascii?Q?XUykvXVPdn/J1PAix9Z65Rc8M5LIHgX7skKD9XTB4SV5nlZznwuelKw+d2RG?=
 =?us-ascii?Q?Y4Rd5GcB1S35fpnKydsm8doKjsKUAQKEhAAHv+9Vg3QzVfqVXItMzNPISY//?=
 =?us-ascii?Q?qwWPLXToIvYTNuaROXhD+gRupVzpTFI2N7oRCpzbbvPBHOz5eCikkt5WTsqc?=
 =?us-ascii?Q?3Q1qkOsYn5PSiRu+jY7JxFIO8vA4wn9KqeSxwnjyWf6ZuxslKvQzhpckYPqZ?=
 =?us-ascii?Q?69ArCKD7d5BpjSXF4h3QzWn+o3O3958JPj8PSeQqIsiViJ173QPV2mAkLCV5?=
 =?us-ascii?Q?N4eqPjwi2aOXco4k7NnRvFV57e4wEm3p7ACMLD0VttU7m7FR70DePA/+noqs?=
 =?us-ascii?Q?N2N6IVFQk0xx5ovb1s6pVdt52wimm5YG5TmEyhGUokQnXSXP70i2gSPTWASz?=
 =?us-ascii?Q?bzaHTHtxbM5IYuxN6cWvpqM01JUp+R/fc7U2BskpygW/qQl9yRS4E745jued?=
 =?us-ascii?Q?CsDklhjpeBB0AIZoumCI0ll+IrMKOtv9CuaHHCrT7z5NW3rmQ/I4kbs8yoto?=
 =?us-ascii?Q?5RRRG/yIHy1Y+WxQgFuCvq9goHXhLSsaHGPpis6cqRBuKrqIKdXuv5S2ump7?=
 =?us-ascii?Q?4vpxDTKjwvE8GxzyhOE9m3ND+zIhXV50B93fc6ZaJ5tzWlwvuxvRW4sGDe5A?=
 =?us-ascii?Q?Vlt0QG82WXiGfzLbKeVqMUJHNb/B7mz5KWT0cJCsWfmSrGN5L4XcXlrx0q39?=
 =?us-ascii?Q?MwI5h+gNH9wEOsANVQH+9/rdqejcBOo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ObwNLSiBe3DRTS7XT5wRKDPQGDZ7Y409OUIFYPyvmoo50FMfNJIRhCFPjE0w7Z8B3rEV3M5gztq85yZlL7r93/PvzyZHOsE8eow+fgoYvy0k6ciRestNXHyhueHbDQ0cQNZ2kGEPvBj1thr2L6AGwLCNX/997mAOj2Yw/U8HeXxwE/VGr34z6sQNl23YISoZLASfP6Y3uVhMcAEk2VOfPMyfGHmLTilfcepEdUCNvwUEfp6w/ndBh5k5w8XCxW+NDGcNjO6kcwz1yyZYBmdvShjYS01P/C7dnG/BzpDZZAmn9P7F9/tKgoVyoa/8rnEmD5GocHx5CRzVqxys4qb0Bg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bf58d7-e8e6-43ca-c35f-08dea06d6a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 12:48:13.1325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryIvtGibE56YKBAGD+/6/UlOSB+XCK/M7lRjgGgq0yGmsbxx5YcOvEUWeZFYXfv2V7RWpAnmkPLtcbYuJeZxVkNuS+2J8mFlwrl/f8h/Rs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5944
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280416-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E790C44633C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Grzegorz Nitka
> Sent: Wednesday, April 22, 2026 2:32 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: ptp: use primary
> NAC semaphore on E825
>=20
> For E825 2xNAC configurations, PTP semaphore operations must hit the
> primary NAC register block so both sides coordinate on the same lock.
>=20
> Commit e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825
> devices") updated other primary-only PTP register accesses to use the
> primary NAC on non-primary functions, but left ice_ptp_lock() and
> ice_ptp_unlock() operating on the local NAC. As a result, secondary
> NAC PTP paths can take a different semaphore than the primary side.
>=20
> Select the primary hardware in ice_ptp_lock() and ice_ptp_unlock()
> when the current function is not primary, keeping semaphore operations
> symmetric and consistent with the rest of the 2xNAC PTP register
> access path.
>=20
> Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825
> devices")
> Reviewed-by: Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

I recommend to add Cc: stable@vger.kernel.org

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 8bb94e785f2a..2c18e16fe053 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -5264,9 +5264,13 @@ static void ice_ptp_init_phy_e830(struct
> ice_ptp_hw *ptp)
>   */
>  bool ice_ptp_lock(struct ice_hw *hw)
>  {
> +	struct ice_pf *pf =3D container_of(hw, struct ice_pf, hw);
>  	u32 hw_lock;
>  	int i;
>=20
> +	if (!ice_is_primary(hw))
> +		hw =3D ice_get_primary_hw(pf);
> +
>  #define MAX_TRIES 15
>=20
>  	for (i =3D 0; i < MAX_TRIES; i++) {
> @@ -5293,6 +5297,11 @@ bool ice_ptp_lock(struct ice_hw *hw)
>   */
>  void ice_ptp_unlock(struct ice_hw *hw)
>  {
> +	struct ice_pf *pf =3D container_of(hw, struct ice_pf, hw);
> +
> +	if (!ice_is_primary(hw))
> +		hw =3D ice_get_primary_hw(pf);
> +
>  	wr32(hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * hw->pf_id), 0);  }
>=20
> --
> 2.39.3


