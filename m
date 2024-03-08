Return-Path: <netdev+bounces-78622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3A3875E86
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 08:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325CA1C21DA2
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49294F1E0;
	Fri,  8 Mar 2024 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cj4pwF9Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEF34EB5B
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 07:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883014; cv=fail; b=OfywM5Yfowm2bSPZ5H7pXDliNLqWSktsgmq9gen5cTankxqZx5uNOtPbjLFxATtl9ctdH5xEsG0Z9qPrGt27KZgt4Gj6ZSvS166yb9xHHSjQn1V7BJ4Ft4/8OfCIcgTy9kjwHXNKWdUl5W21DVlI22/SpFLGFeqe9CCWU8LH+Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883014; c=relaxed/simple;
	bh=wn2voeyjYTpYI3Lk4m4lxhBLNJG5BhPOR6pQS6I5jEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AAZp7swuTtnXpxe7V04FZJtpSl0hqjGLaCVeY+5om2XgK72ScKxDm1ZoiCnw7mpKLcXNbIsoimuPm9yoqN2Rar5NefTzZ0kklydlDXUtrQwgKCtSgbE6l2snkGjJvJ8Cet9j2Ze+jatSjU7oWdu3rklm/iLZ3zCeM19Eobm9GJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cj4pwF9Q; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709883012; x=1741419012;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wn2voeyjYTpYI3Lk4m4lxhBLNJG5BhPOR6pQS6I5jEc=;
  b=cj4pwF9QgcL2lYnYgOtmTBQaONHNl//H4WsDiMHXI9bSYVj0gswriucD
   iTkSkEkruslWuBmyUcJksM7hN+YMvQVeyEELFc+3e38WpWd4l22/Bk3re
   IwxgPreqTbJN+XJe4qwydXYmBldKYuCUe2QuGjg97lAWn/Z29sO6N3iqG
   f4aTw7eXPFJCC3Hd20cfSbl3KSGRGfJcCGNC7JoMSslJzdTFFsPjK2nXZ
   ODNevxBGs4eJBOroQK8fuvXn4BjmTkqe3pououjuAqaWr+smFecDFewYl
   XCRCHS8tufCaIdeeTYzNTNzYi0lIqEEMcfLwk4X1vvIzZo/hlA2u3DpEV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="8404531"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="8404531"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:30:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="10378650"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 23:30:12 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 23:30:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 23:30:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 23:30:10 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 23:30:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ds1aBVStsepACtbf/QTC3HDPwBPgCDZJFsGidtw168YRbispQfOshyo/TUWwp7Vy7Z6qFKeD2eP7bNFjIJ++ZS8BwcxYPbtdiJM0P3lt+UpABJOxi6m3Jvlqi18aIbLmyl66dRenH7HsSzgypQrUSaptDf9To36uiREWZ3YXMzxd7UIXsDEX4jDK3w5nl+2PrFEpjSDeFJHI5RoaSafxgxD9Jw3CQwt01LcyWNn83aOpbqjHrRcyDhgfd8bHWK51pLf5D96gzOSAAg0iIQ3pQ+wQolvgqsofVPZstyDhYZr9HKpmuqQr+nHhl8DsRyUk8141/uCSz8KJgyzs9mFiaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHhwxkny7yqOfBvvqrPsg/DsmBydQqFw+C6UTcoF9n8=;
 b=kfUzeGUa7ASeqVIJdOS9ZZ/KKy5qJIhchHxuIa9UdFnNRuf7lPxnA4DvML+Q/7DNBJIfHgCbkv0upLJcuerWtX4I2M84NT/HVJCN2ZAuqNvMQs8OgfpZq/NpyMcwW/z9FHbKKVwUPcNE0pKp7QVojCM7lV0R2Jra+uzDmbbQCkkC3vYya3dQIRVrq0welQnTMHeDymz7wwy3Aaf179aaDFNrOW40uA104NlyIPWzx/MBBHm+zsV2MTl3iBLZqUFHHIm45UGkcesSKmb5QTVa4STnr/iRmyMcJJ1qridYvzTPYHCgCSYOgULx/SPWFbg41hiY3mZEM70fNYULXpwgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Fri, 8 Mar
 2024 07:30:08 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2%6]) with mapi id 15.20.7386.005; Fri, 8 Mar 2024
 07:30:08 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Szycik, Marcin"
	<marcin.szycik@intel.com>, "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Marcin Szycik" <marcin.szycik@linux.intel.com>
Subject: RE: [iwl-next v3 7/8] ice: do switchdev slow-path Rx using PF VSI
Thread-Topic: [iwl-next v3 7/8] ice: do switchdev slow-path Rx using PF VSI
Thread-Index: AQHaa86ii2vckGrwGkuAq3DVUnfLG7EtfTPw
Date: Fri, 8 Mar 2024 07:30:08 +0000
Message-ID: <PH0PR11MB50135379D17A84A6D6F9EDCD96272@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240301115414.502097-1-michal.swiatkowski@linux.intel.com>
 <20240301115414.502097-8-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240301115414.502097-8-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|PH7PR11MB7098:EE_
x-ms-office365-filtering-correlation-id: 14e49324-1a1b-4216-a8bf-08dc3f4194dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xHnWJvVMlzxiOJyi3CidOy5rZL5qFvJD9HfwvTV7JEHqc2TMUfI40hJKZBllKT2Zovskqd6+zeu4/A2pqPKH93JlF9BrZJa87K0ACS3U7zgtB8/Lm+MGXBNcvv29/u5E6Z+HRfkyzg4Qt9gIHSSR4s/33GKNsFu5435mO1vr9ySN/nxC6JptLwn7dcHu5MNU6Pjs/adZi4x1Tcn+FXzRLbwl/4V3gXVMsLQvh/YHFLyqtyWkZ7mO/OYuGm0Dni3sWrEbRkE2glWiv8km6yluk746RtA7ZlMqZfElP3OCQopum9b+5s3TVM4Qsh1h8KMoJx7fBLLKKRo8I66ZF/4wwP1DNC4qhvdXFcgkRcM/0Yh3tEx1c5pgdOgS2ORJCNB8hfO1qRHJFfOaq1NxUww4sOssYiT2hhu7hMbOfotttdSAZjYZN62U2EDwcHEEBaRYBtExzrIANzE17pnMDVPkV2yz+csjB/ab41j+BLoQBhOXBipGo0okJEOU74nd+0o/b+O9rxdPMnk4ogfvYZ5GTU0YgyWrkCS4HJABqrO/fXfKjKmamEThK89ZUM7/uxNH3n6WuAMr6lBDA3dLuDbKFuK4zSUnd5ki9KZosEh9JH9LKwVUMGFWJcV2vQR/zc6odU0IAbgu+wr6rD4HDxAz3SdWFls4yGpIV2o+qogwCKLPaNw/0bX5Y0dJJbSWkp1o/Du/BdnKt04c95YZBTasW+cmBuhIjeO/bIh5AfFO2vc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WoF/DUs98iVXmvJ/5mlgnG+mHrZRSfBExFPa1ANTQjXD332iMyk057ZC9Fbm?=
 =?us-ascii?Q?TQYAS4kc0EeTWELBHTpn1AADHkHPQp6twYbQnaYcrNJN0iJIYj9FpRRT09Ut?=
 =?us-ascii?Q?Rgd2G3C2BI90Rz5+BZrK5pN5aFk7TuHyqY/5OvWPtmNqDwXvYb6z59mm0/ad?=
 =?us-ascii?Q?aqYQlh05Na/ahNS4O5YTlwuWu2Uyi+zS3FfxBDwkD9nUmJHM4uAP4TQrDm5P?=
 =?us-ascii?Q?EqkwFdoulBkhoV8bZehsbpOw9eJqg+qqdsHGYtHtOQ6J0p7tRiw+53S5Qmi7?=
 =?us-ascii?Q?R0cB3fTVOepEZ6j9f/t/C/fY78uA2OWyQrpTwCu2/DvIqm6zjLlpOri35iVo?=
 =?us-ascii?Q?bZBVO2dpTXztkizZDilrfx10eVVru1R+3FQdLqI8gwsiWciMSK1tfANTrMdi?=
 =?us-ascii?Q?0y+BwA7rUl7yAmnD0NfOGOhtvdOlmz1Rgfd/yEO4RUADA3q9pG1chsmWy1jA?=
 =?us-ascii?Q?IMHXtVWczBlCmBvsQQyMLgHuCZcSolsxNVS7Ppi23WXDEMSaDcA7hBj06tCR?=
 =?us-ascii?Q?8zg/kLmsDlKQ0RFF7ShzZLtPnYMLEirQYbfcKdSq+UYHwZlUyc7GibJysYHB?=
 =?us-ascii?Q?WOiPEih+sqiIrBH2AOBGYszvz9y0MhiRs0mzV95+Y7fNkuy0mTddNk6AUoiE?=
 =?us-ascii?Q?n3S3bOu92jMNrR29mGxxrT3hJqgdcoqxSAvIq5mSz3mJHv29ii2vZlre4nak?=
 =?us-ascii?Q?BFVw6P0w3+/SnaoDDez7+svdYhQPS1k/1i6hvPPmiqnBlnFuKkIQ2ghCb68K?=
 =?us-ascii?Q?eYm1sWXGIjL+0s+jygfXLjcctZEqxTgK3I9bualvkUg+Q2EUn4ROqRU16K17?=
 =?us-ascii?Q?Q4tMuF8HIIMMPTlZe5D6V8Nm8GKjzVaWbjsJt8eabDGf3SsmkEFEs60rsdgH?=
 =?us-ascii?Q?OsmkAhwTBpx55blzSBNLMpai1w7m9A+LgTVKiIcnYXwRESn+F7kus+42RSi+?=
 =?us-ascii?Q?0YzMKTpNrWuSzHqVFctxXPtPz+DYBX3Mha4BPB3KL3rYFcAHb0s+1F8PtFtx?=
 =?us-ascii?Q?iRatJwyeSRYgXShv12y8lmZjMgmh/xSQGs+nUQvth3bUsrkoPCJaYREGeVjk?=
 =?us-ascii?Q?oIkzDZF7azTAVxtocpTK6vvAWJy3kTP2nmka9zk3uDu+tQSEUh1CEd1S1goQ?=
 =?us-ascii?Q?qzLkA42WVXDaCInT8jwjm1NSJMmi/d3PvGQSYRop/fR7ZT4Slqt/0qPRMydN?=
 =?us-ascii?Q?2Q58gY79M2cFktIBwBm0Jjl+5qXXT8B85KDkizt6gZRdWmypEAbx/KRi8lbA?=
 =?us-ascii?Q?z4ZcL7gemN/A3djhMGOIWvua6LCRQOaPxwtrpI7PWbAxH64CWfIqMBpOpMc1?=
 =?us-ascii?Q?lJPvFmI/oVcvIx7fpEniX5E2cdRYsiFgYqa+OThCjTJYE1ZJnyssKuNdW4oP?=
 =?us-ascii?Q?Rcr+ZGlvRbbqVMioLh7KwV93GCfQi63w8cnhB4wmCgHo90fJVsKFt7YIrsZ6?=
 =?us-ascii?Q?oX2mnCenKmtHLSaOnhrMDBtxtMUQWm/A5vO6SGBcvxJ8QOejV1AuWJc8noYM?=
 =?us-ascii?Q?/9Sh8z2I9cHB7EFLtPyO2n2DdLcQ1SIjTrQSWAOhcUKdQdMbrHLM/eLKbHff?=
 =?us-ascii?Q?3RXuMb6fGlnlZPZHb8OZKpiqUScw7w9XDLfCqG7BMY1UqbvfL/Mx9NJjfkXV?=
 =?us-ascii?Q?2w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e49324-1a1b-4216-a8bf-08dc3f4194dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:30:08.2241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggD9hEFzFauDGUiMKt9QNCj+YMQEUSPq9rATFeO0BcMHwIR0OCM6aUUsWeogLYRywTgw2vv23WTX52y02Lo/7OP426WS6cU+ATtxHTeb1Dk=
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
> Subject: [iwl-next v3 7/8] ice: do switchdev slow-path Rx using PF VSI
>=20
> Add an ICE_RX_FLAG_MULTIDEV flag to Rx ring.
>=20
> If it is set try to find correct port representor. Do it based on src_vsi=
 value
> stored in flex descriptor. Ids of representor pointers stored in xarray a=
re
> equal to corresponding src_vsi value. Thanks to that we can directly get
> correct representor if we have src_vsi value.
>=20
> Set multidev flag during ring configuration.
>=20
> If the mode is switchdev, change the ring descriptor to the one that cont=
ains
> src_vsi value.
>=20
> PF netdev should be reconfigured, do it by calling ice_down() and
> ice_up() if the netdev was up before configuring switchdev.
>=20
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c     |  8 +++++
>  drivers/net/ethernet/intel/ice/ice_eswitch.c  | 36 +++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_eswitch.h  |  9 +++++
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  8 ++++-
>  5 files changed, 61 insertions(+), 1 deletion(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

