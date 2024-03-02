Return-Path: <netdev+bounces-76784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 986FD86EEA8
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 05:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7401F22185
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 04:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4FCAD31;
	Sat,  2 Mar 2024 04:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aa0OR1Lo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FE3748F
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 04:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709354402; cv=fail; b=IkIsKLJCrErGqON6CILuqfmy9FZfYHWkyaSjd6La2IzRFnQqwFI5SCQ4MxFRDKfbFoIZEHCwjeKT1h1ITh7TIlld0UZ3rg5s02+kcXRUyH7daRjyoNwX3kIdbYNuOuDtgoQXGt10ndTaL4edbaFZ1lz+gSuIyaHEdAMmzuBWvpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709354402; c=relaxed/simple;
	bh=7HAcNHj8HX0eLJpkDvJwO4ZVl14ktqzcK0uRBGHLb/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G9zvn+cvj7/yi2hsdKluGbwAizLgofpTIleWED120gGY6NvXcXSZ0frXm3wphK0lwXTbLiHrQwtPMTuKm5vAFAAVj564BEtW/qUqYMEYRBYDH+I1hDrJn8DMwzmL3miALsj0jKIDlzDxJVF+vW1ONprKHGoZCj9B+sHYyYbKMqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aa0OR1Lo; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709354401; x=1740890401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7HAcNHj8HX0eLJpkDvJwO4ZVl14ktqzcK0uRBGHLb/o=;
  b=Aa0OR1LoJiVVMSa092TOrBQR0Szo6IIRD+TIJNpgmUXPGAdp3Wf0lmdq
   HKj3SWQDl/H6jUlnTolG5zwAO+coTQYjW3VDZzYXZQcIpZiPe+fwBkHGB
   BfYys5yjm6vf6zqlnj9y7MePdEwebSUBNEVJCfIPKyHSKm1XHxbLWIa1E
   cb/wtjTwakrhRS56wV0fxBf5LVvOukRhwAZvk+msV/mJ1NDkHhK3F5kMN
   AjiTn0blc16ZKq5ssw8lClDsh8xziekIwCGG6K1ZSpFO/i17d5ZDIMO7P
   M0XfpzHQpNJn1ZRtUU9Cu3P5uZMBdPOoJ/NIGCQA2c8CXHMByS3s0QnpV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3834344"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="3834344"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 20:40:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8343436"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 20:40:00 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 20:39:59 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 20:39:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 20:39:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKpzJ6eTijdwQpBdemy9v1jndeYpJ1IlpJ/XJa0RBl3fW84E+upokLW+2QEoeBaeo2BC/yQCDQx17DHz99oCjA6Gxw5J2su9miH9VRLGskH8S3uW78JXgVtQ2AuueXHL7gQt10K50AdPvbdaOLZDyVZOop7vxC3FfM/YlcEjUvysv7nIXM3H4QXemZdO1ZzwdRnYbKv4Ge7QzyJN8p2AaGBhTCHfswKvopIRRqRo0zDg14X0XiAdXiI2ptc4fj0nsrw986YCVzrCcdR/LZ9yLGMA1lgJaJcWM4R61aq5T6RdBGT6CY85m3WGHgyoedvFdNRTELTSOrcnb3R9hQDRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHBL0Uc4tq0/kXQZYelsepXKGTdqMSGXm5Vdzo3fNZo=;
 b=SN/CaljuMPcuikAdODhnSeMNjrrJ0gwC2aFSybapMOzhG2uTBPOsSCSwB1DqoFUlNY1xnprOB7CgEVthaA7v63r+Rk3FrOm0uRJwuV1GQM/EV6UAi40ZrKKsieCcIsHnzvItZRYcgmb6tGp9+7PPnvEukgn5ujEllp5EBam0K7ehggh8FyVlt3HrX5CA352/DKGpqNPblt5C6y6jgiWJsthjG/GdFTFjVcMFtvO07905crMIsTEYtbQAWVZTLQJcLv55CCZDushDZR5dQR6JE1xL7FVloeYIN2SHVPzjGmeMYCFVMUZA3g8SyEy7je2MvlvbuAyCBCL4ZtIokzNYCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by SA3PR11MB7628.namprd11.prod.outlook.com (2603:10b6:806:312::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Sat, 2 Mar
 2024 04:39:55 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636%3]) with mapi id 15.20.7362.017; Sat, 2 Mar 2024
 04:39:55 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: "Brady, Alan" <alan.brady@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Brady, Alan"
	<alan.brady@intel.com>, "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
Subject: RE: [PATCH v6 10/11 iwl-next] idpf: fix minor controlq issues
Thread-Topic: [PATCH v6 10/11 iwl-next] idpf: fix minor controlq issues
Thread-Index: AQHaZcJACxDL0ov22UmqvtKUye/kYLEj675Q
Date: Sat, 2 Mar 2024 04:39:55 +0000
Message-ID: <MW4PR11MB591190901E141FDA643B75FEBA5D2@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20240222190441.2610930-1-alan.brady@intel.com>
 <20240222190441.2610930-11-alan.brady@intel.com>
In-Reply-To: <20240222190441.2610930-11-alan.brady@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|SA3PR11MB7628:EE_
x-ms-office365-filtering-correlation-id: 4df35436-81f0-445c-f57f-08dc3a72cf1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VztkMxlNBrc1B8X/LJjUSQYP+8mbW6Xn+IxLFAsbPBjl1+tOxolNAMf7V270XzQpyi+iSLyCrH4GlPIb5+utUPYOeI3o7anbBfl8jxiZUjjIcubuj35GWCTVcRYGs0YNyoxbzCUDZj371qu7wZK0vHOB2zuzQt++8AYs/9s6Y9h/i8REzoZpkFs7nWRytgSWuMWt9YvDmlYHMZqQy/fGZpfW7whqFjJXT3YlUf8NdEK5vY4PedbdB/zSHINK+RQjqfCAYt5VqfSN17wBIuWqa0n7gQvQ/PSAvW989r1fmjjUoby5/1rE7nsEZD1YxaTKCUEWqBbuLpVoW9qMAugjT6rCSbrAu7wkE1a3VHTm9iVNtjKkfPAHO0rArOOvCHD5uoZdkewfveC3uaMY9cboFZiUnqGxJ9jaQTCzL11l/OocKIyiZztzCL9hrvuC8Ym5n5rSyZaa76ifcH+kU4LXkugCKVrcmm2URQfe7U+S+JqVzPA/9q+AvwhWX9GSBpbteV5je5jTZAPmm/JTFU6U286j9Sxwmf30iLGTe2zq71NDjoBXjEXLsZ+IHNMXqa7B2I8Jk5SA9W6KKqAX7VULL4MZHDycIguSNWtzQbJVRpQe8LTC+GxOlXmV8asIQQ6NlgyFuF1LeLGxJjaUFLMGV9XA4r0lXDETpua4MzQIptNTvOdT7EV7azRmAaNnaPIVz89r4y5nAx45NLwn+ShUmlg6Mjb6r7dRHwHL4FUBhqI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6iW+y1htKlPqV2hYhJ8ReN1+gqeH1pDWp9bf16y9i9fjWDuCaKwekqDtQiVi?=
 =?us-ascii?Q?FM2T8TFimtmsCdUv+SgWc+AAepBYeXUqnSCKzoap0u3WX+hOVth8Bg/jZZJU?=
 =?us-ascii?Q?6tKGxMREjqnmCGxagQB81QUjIFqf+IiB+4x6xp5wKnzdRWASflMNh1z4SM2/?=
 =?us-ascii?Q?qVxS0Y5yhj2eOwW9wg+fH24JCtcL02R0LSPXRH9UWBfix2Q3YTzO9EK3RUpF?=
 =?us-ascii?Q?y7pFWQp6NwyA4KH5bW1JmoA6sVf/enPr2yIYBM1Qzq8Y2Qj/VvBxgPhE1Wcp?=
 =?us-ascii?Q?EdslS1xj5VnBQfljrtU7xq6pRmxq9NEZT8dQdxuZ6OiHX+TOTEXoe5ekRqDu?=
 =?us-ascii?Q?HdTH7Ro+7plbcPpfrKM+UyzBdgPcKFENYvV26fBuSLjDzhLjQD88jS8d2ijU?=
 =?us-ascii?Q?h1U33JsWV/ALQhQLS2+hmQRKxl5P9Ool2rPXM2bM0WfjQp1TjOXgdGvSzXXX?=
 =?us-ascii?Q?es2SuZyAhJwKjO8DWDM9Las8HrIOh9VTnSeMbZEQ4WtJrPQ65lf5VRV3orhI?=
 =?us-ascii?Q?GNywPqms1Av5IlQ5rGNE48G96FkHEAyaKgY8p/D5uD/3xSriSRcBGwfn0Ive?=
 =?us-ascii?Q?yfzizfOrXaYkmMzqJyMq1PklljWeLX9cBn389aPEjKIk9wKXyjVl4c7Ya1gu?=
 =?us-ascii?Q?Nz8YaprauDC3ODWUi/UGn2KUt4SPjQhoascupltos7Un0SLJMvcTnJ1Lp9YU?=
 =?us-ascii?Q?R+lzsLtp4dXSBrcXZx2dYDFTKaW5WlIeVeV6EYo8sm0dH3Egu0Jx/lG9Va4e?=
 =?us-ascii?Q?iR6gU1lUFH1F3SL3xHLKZAO1XsitJo7TmoPNPASkduI+n0DOzWvHoGgMm4m7?=
 =?us-ascii?Q?CmXFhDPnIp18fWMPIJ7iQ2t9f8mGY0s1ja9TIKwBz1tAywE8Nl4a4lxYC1gf?=
 =?us-ascii?Q?Au91jthmogO9enCdC6W4MCRLu0sg0IVzTWTmOi4vVIaO6ssbEw8/ubFmjxMp?=
 =?us-ascii?Q?UKBU2EiBmNbBWT1CZ4Nlwx6AoekS5EriVBIvKi2ZtpEAflIf2DXGJBk2A2++?=
 =?us-ascii?Q?mNJthOqES1pYQiMLlUFwddul1XaHDBk3aM0pZImx+komsGHyV1JFTQGYql/y?=
 =?us-ascii?Q?i51TGDCjPAAQKvxKtLFTei2qzJEONybLQ7oocZNI3V3nfzL6Hh7+kTGWjlLs?=
 =?us-ascii?Q?hDpYrQHqcFuVFCauD/SPIjeO5gno0PzhwsxDkIchJBIs4aEYAf49Qe49iqj9?=
 =?us-ascii?Q?Q1abL1zTQHvxJfgOOI5RDdEeDa/EtbFrBQ/TrFlS2qnbM64z+uWg7LhcVbbh?=
 =?us-ascii?Q?4mu3tbp/aBVlZrwnWLdBqd+Kh0vX2skoBCOx7pNTwtLnE0KG32KpxWUcXkdr?=
 =?us-ascii?Q?RzodA/5xTVQQfLq5cIFNM26VPGpPQL34mWrfVTE2V9xGikk4BPHVfduXGp0b?=
 =?us-ascii?Q?DSKvSRC7BYjt0Qhj2skHExK52b+XQv/gvoCmpG5C5afc+PVY3gVexa9b9oZX?=
 =?us-ascii?Q?pJK/uL+V2by0EQQDkpveS8pIhmIWgbfYdvqAdjj0LTQf4ODFzmFDkwahnzKv?=
 =?us-ascii?Q?lIdt3rj2rbeFlK2krPvftY5jXGeBdiGhH7SsGjZ9lnuPe6TccyPi4/grPZtS?=
 =?us-ascii?Q?cytSRal2HdWkNT8yB3qjm/pnIpaaCuvmie10oJji7zavcIPvqQMFtiZ1dnCB?=
 =?us-ascii?Q?uw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df35436-81f0-445c-f57f-08dc3a72cf1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2024 04:39:55.4804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AG4Xv+CHTkrHPJPHizCi97+2vXk/qKLmSqmGODOTOxMA8X7hYekaUvF3VuQJzGYQOkyLzQ1tolDi/svuaoDueAZgcAZwnEo8Z19imVBtrPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7628
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Alan Brady <alan.brady@intel.com>
> Sent: Thursday, February 22, 2024 11:05 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Brady, Alan <alan.brady@intel.com>; Lobakin,
> Aleksander <aleksander.lobakin@intel.com>
> Subject: [PATCH v6 10/11 iwl-next] idpf: fix minor controlq issues
>=20
> While we're here improving virtchnl we can include two minor fixes for
> the lower level ctrlq flow.
>=20
> This adds a memory barrier to idpf_post_rx_buffs before we update tail
> on the controlq.  We should make sure our writes have had a chance to
> finish before we tell HW it can touch them.
>=20
> This also removes some defensive programming in idpf_ctrlq_recv. The
> caller should not be using a num_q_msg value of zero or more than the
> ring size and it's their responsibility to call functions sanely.
>=20
> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_controlq.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.c
> b/drivers/net/ethernet/intel/idpf/idpf_controlq.c

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

