Return-Path: <netdev+bounces-50569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D47F7F6245
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22699281B1A
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37DE22321;
	Thu, 23 Nov 2023 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9L2g6QH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F57CD48
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 07:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700751814; x=1732287814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WbNW5m6+qFcPr0949Q0CCtphpA5FKGmRiPEyzks1uaU=;
  b=P9L2g6QHrvIItz11oB4yE8Y17ew2vd8HjgAS6w6KCZrVmnkYRYT5K4ez
   Kp7qsKLdQOiTYd6emcTEqV4X81h4CNyBH9/fxGOpbMqTWM2z3/khkQb+F
   ep+aG17H98mshjN8FuZsAG5tA06aU1YLGFlXOLLVxHH4XGidu9R5gdNK0
   KTtSauvpwwl/1PnhaF0S7+pYDe3m8JMdVks8QnqpVlZtkWYXsTeqvxbQD
   BQJGzXb8G/pNwstMrWpU77b+//GFZqrQoJL1U+O8SL7QztZjOFBYzlPIc
   a5o2goDJK9QiV9bg6VSDmjekXSGcYr/h5LMsKaUk8rRoXPV7lWaYqJF9X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="377308469"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="377308469"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 07:03:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="8870936"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 07:03:33 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 07:03:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 07:03:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 07:03:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePEpmF1LogsaeOizf3cp7I2HE6Vfjp+tQTJq4vCpvNFCh9Fr6SEsMi4rVQuQ6rdV11mhjQkaTAkh6PVgn0h55ybmi1MmUGmg2LUcHN3pKYDr3mS/Ub9ktN98/8zJjDDPyxQm8DPjeoiZi971JDXcrmfpiRrRVFuUGr7q4wgzoK3NF+cXaeaw++c7mr5v5ggifXTrE9dTe0qz/HXxXqX6o6yh4xkW99Ht/OVa4dcAFVIqhy/mLyjJh1bWymiSWBl5gRjZLWsp/XfefHO4N88fhlPij1UrSrc5WzJOo1ZOaFYoJtTmulvxbd2vZc3pbj6vn1mml1Ut7pX71XC7YmbQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyJJdclIuffXCDSP1mPKvA5eelIDHEsFn7qWBmNuDMQ=;
 b=BpjwnXWjMyQHLjPaHl+PNE3uuvH33qMtBnuS0rQDQ06Zkjuknmdi60LwyIkZ4kYYbn0P1b0oJ0JUPuwD9So2MspCuVBbSf/NFkskldVX79Og5tfTPb1T+2K2QnAOQK7GPHgz8KNON9Xn4A83P8VaWx0xUOYsEtTdDVYyOQJSi4NJMeVWbHf0IxMJbXutDKzYrxGQlFaT6j5ALaenvZPCmNlyp3hZDy8wc9VQpTSPuDgNd67f+XiJ1Z9SKT2Xn4mnh5l03r2Q0XjcoXI62lx1bvJFOAZkDO1m+iRCT9wP/6y3sQw3MPtaI4dGqruKHl+KJdAd77He8vv73P6ihF0Ffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 15:03:28 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::1498:c32d:2d2:975c]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::1498:c32d:2d2:975c%6]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 15:03:28 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 4/4] ice: manage VFs MSI-X
 using resource tracking
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 4/4] ice: manage VFs MSI-X
 using resource tracking
Thread-Index: AQHZ6fxAcDH+Hy1XhUeIvnwfbWnrAbCIaFxQ
Date: Thu, 23 Nov 2023 15:03:27 +0000
Message-ID: <BL0PR11MB3521B8B9F574CB3C9E48795A8FB9A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230918062406.90359-1-michal.swiatkowski@linux.intel.com>
 <20230918062406.90359-5-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20230918062406.90359-5-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|IA1PR11MB6418:EE_
x-ms-office365-filtering-correlation-id: 700056b6-0b6a-4956-1b22-08dbec35592d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mmXhoYR98MXhCzHfLBOppvPohiG7rd67S0QlS4/VdhG49CN4sfg3cn+SW+wrtQXqcsQoYfXnDNwS5+mOWglRm2t0MQeXN60rFOKIPkOxbdsRsnsu+NitabmChQU81I37On28IJDrr6irJVaSi79j5EctCGWKHZSfAM4vDJcnjzGNHDLt6n7MRDMEdg6PLb+Rb3ZrKcszWria8GQZVUB0CbbJ55p4cfGj6XRja9teUtfb69EHGYUzxfDef3AxulcoT19y0em4yb2c8Gt1BUvuyb/hrRCeSpMixqn7SjdD0KcIxHZfQYm/XcSbrXCo5gZYIeswd9b/Z0eMdCFcKJcoxqgL+rnDHNb+YyLD+XlBYl1O8YlyRBAq+8fXJ4cQXkIImK0o/joeDZPKqJlMdzs7FAWI1TUoUbyM+r1gA4OpzSyjIwn2AbfuDo0Hzhuwp5fu98zUogrvPIkATUcSilIDMUTAjcjFxX938CRoJuUOorQ277Cg1QvM3r8Fi2bKZSjZaarw6adN2yfT+jmnAndg7E3aZEvqO8wMsCbFZ7ArvBz+Oekg9+CrXv68c20dEhaILzpj25Ic9Um6rPE6hm4Ec8ixp63zPlTu0gFJLiHGBvy8RfEH2cbDR2rhjMvT3cRS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(2906002)(52536014)(41300700001)(8676002)(8936002)(4326008)(66476007)(66556008)(66446008)(54906003)(64756008)(316002)(66946007)(76116006)(110136005)(55016003)(71200400001)(6506007)(7696005)(478600001)(26005)(9686003)(53546011)(38100700002)(83380400001)(38070700009)(82960400001)(122000001)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wpPyqf/8SUtQusn777++1VFQdWw2XrRAP4bER5RTqfBn2EynMcGsNkEGxrg5?=
 =?us-ascii?Q?mVmIUpFbUuHpVRxHCuD5bnxfQG2mkh01P0ajTa151YyXItK5gB45xixunbko?=
 =?us-ascii?Q?KL/nn3uOdadiQIdH3LV/Ravkh9+i2dzL2srgw/rDoqV0SaM+ZRmDxfMpMCWH?=
 =?us-ascii?Q?pNgHjsQvU4SLJeeBWZIYDex1k4TC5u+XAl+6O1GL6daRcillPeVrRS1ejDBq?=
 =?us-ascii?Q?bKwUR6R08vFscedMGh1DP0A4TsNa1+VKZn2uwS+pAVYTU3urGUgIiQPd6TOP?=
 =?us-ascii?Q?K9ie3Lc8uW9XhdvzpOXAEdr5IoqO7Uu6w6qkruttgYP7R2WWn6rtYFdJlGK2?=
 =?us-ascii?Q?40LT1CIXlKydUcFufPFpAZIZFyZiI/+4XqGkP/Ml5KzhoRxKIOC+BFzg0fSJ?=
 =?us-ascii?Q?WhOLlvuixgpMm7G3TPgPtfUCGvBPqEzzdh0Dz+axJP29TnMpZPSwCVDYJ8sD?=
 =?us-ascii?Q?SHEtLyqOxtpJ3dO5Yhk5SBpT6/nKZVZea012tGw46lz5KSBd17bfGYpjd/VW?=
 =?us-ascii?Q?bLEJDQqCWwQ0MeQ6zjK6HNehjLXIpwnRVGSuXbehJMZf0ue9nroFlsNsCxfg?=
 =?us-ascii?Q?B6s4ImNd9k8//fz1gGzC+PXbJXHKSan3T9D9gkoAlFEqYCx1Tv+/HE4Xv7I0?=
 =?us-ascii?Q?kXHbEKcNSi1DJoXgqu3uOQxMvnAoCJNw9L9BDKH7QELeaVbuIAGsFbzoaPA/?=
 =?us-ascii?Q?SlKSmP1UzHkbdOpP+CJ7iZfX014Y11/VtWCXxj5gkfEDStlbrpjk8zhRwqDR?=
 =?us-ascii?Q?9SVVbaFcCg+1m5AiJ37utmB5Av28s39Yvck23Tkt/BndSDTBDba3UG1cqf6E?=
 =?us-ascii?Q?a41/xiRr4zD5wMGfbp9/w7bWr8fEACblcGkQYNk7+2TSCkFuuIvqJilj0OSJ?=
 =?us-ascii?Q?EpE/3PUVT2X9xbJJVG/GDqrZIuLJ/gxe5nOsbVfYuDIu2mxU2ty14M+a+2On?=
 =?us-ascii?Q?UANhNtyc9/IFri2a+GEOXYnD6D7soPfPntIOKhdk0WbzmVH/Scs3+OITPeLl?=
 =?us-ascii?Q?JZJjxbwbET1VycJ3PXpT7sloEi8cxwLNOmRwcH1Ml+UgIe5Xrki5+qJUtPgM?=
 =?us-ascii?Q?hw9Zzuj1h4YjmVIT7BubibsrOA8poKzS7dE4evOi3IqPuWrqmmuJ8doVEVTq?=
 =?us-ascii?Q?iv4XzcOqshbM9h+DCyKX50qkmCtfOc2kh5xJVS+R7WDx7InlvTDGzL+K3XJJ?=
 =?us-ascii?Q?Zb/0hAozShbH3CvhBwmkOv0S9NNK17JscJid/T9S09EeXOPNeSZJzvXUtjNS?=
 =?us-ascii?Q?mzpTy6s2W5CZChVJJuQS6yaAGm16enPsykwH2ztaGGNH45SEqU4V3CrWQf1v?=
 =?us-ascii?Q?0wKTHw03DOGyhHarPDG1UShn7hTtDXmtMLbGbJm4wmd1OdKn5k9522eO4gaK?=
 =?us-ascii?Q?eT0bjDWrJeyNRpNe67yhgrFg+NGeFYCw5lhwlRASsvCoQiZnDqQDOm11NmYt?=
 =?us-ascii?Q?L8ZvsMSnd4NfNR7U80KMDEIt2NyjQr4XDI9o0lZojMa7LCMieolwqGrVzizn?=
 =?us-ascii?Q?sxSs1EF9M1ewZMGFQbeYfWcdbbMZkn6a9F/Jy/3msdDthfoLdFeiSJ9dtU9+?=
 =?us-ascii?Q?mUByq0ImJm2aNmem/ola5NHOGvnCCuNGq/pCwz/NaRc09DytybmtwaLE69dW?=
 =?us-ascii?Q?LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700056b6-0b6a-4956-1b22-08dbec35592d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 15:03:27.6156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQpFR+CZgVoqfiJDwhJdcDWiLy1DgdH2aJZG2mQkYv3mt4/qel9gayG+2wYMeLO6BFGIYgohRxAqJZxY1LCK4cfuo5kchMuVLTbEB1CuJDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6418
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Swiatkowski
> Sent: Monday, September 18, 2023 8:24 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 4/4] ice: manage VFs MSI-X
> using resource tracking
>=20
> Track MSI-X for VFs using bitmap, by setting and clearing bitmap during
> allocation and freeing.
>=20
> Try to linearize irqs usage for VFs, by freeing them and allocating once =
again.
> Do it only for VFs that aren't currently running.
>=20
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 170 ++++++++++++++++++---
>  1 file changed, 151 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 679bf63fd17a..2a5e6616cc0a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



