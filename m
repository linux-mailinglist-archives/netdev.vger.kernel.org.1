Return-Path: <netdev+bounces-42547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CED77CF4EC
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6951C2084C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA416179AF;
	Thu, 19 Oct 2023 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLO3lCXz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590BD179AC
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:17:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCEF124
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697710652; x=1729246652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8O5EGMrshitr28Vfr/Mue1ah8mLaSURPDx88OfIvV3I=;
  b=cLO3lCXzaNUn6LG5HIbRDYi3Cts0GNsnzDS1R/54Wf7t/PX6z+TzCHL8
   ZhvK3kgaY1Uw1hWiOp0CIktZ36eoFj6pLFmmEhRjLJYb1eGDu4ys2dZmi
   pqkQtBjnLF7bur6fDK8mIAK9n59aNHNiffMFEnOpftuxM/xCs8aFccdtT
   Dyrlyzjvr7N+hwKCv+Kqu4tGQW3ysZhdyFR8ttQWHfDC9nXmc7i0QQkVG
   dgFAjzvpQxZblD0SXbZYrp46bi6TtJ4s3BfbhGxN0IKGM4xgUufkcaRF/
   yx0xdb6Z+/2N9inwz6yFEP+g65wcPWJd/xM7M8AiSC71rzUjuCkWuq73Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="386044231"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="386044231"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 03:17:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="733515413"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="733515413"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 03:17:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 03:17:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 03:17:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 03:17:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs23TV4FOrtGENylExtuZZyf9r992Jx31/OzD2F8IzvD1YrM0Bv/ogXNqy1pfEFoKu8PnTYkgGzoytGDYhYWBmcTmbOy/MDnG+Y5JIx41TYp3fwh3/AVx/291QmLsgNBFmZIeVA4heBCCIwgHUxMSMcAYqksqctBGtvO3+K/VCWMoWFGytM11kOP7gtDCCzGUOxVX0IwfZGS1CbtkgnOwe4fo6yuND3sxcwLAuAi7UXGG8mVeT9bas7j9EEs66Cadvtb+YcLhublEm+QLVeN5bRP0J767ZtVfXcEo6oWQKs0HgKeDMQ2FfkdYwmYPffCsI8DNLxQpnG/SHA4z+eXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAstaVh/WxXpamnYRu/PecsBTraWq3mx1eatdfm4ztI=;
 b=S1JuigO3mXZIM4rct6HaoxEz7hDXUOd3NIvtl0Fo3FluhJ5vKDNKgrPrG4cOuBjYYhvOrju19ITUwlYTM7Np1MkqBhX3iDjFwm44pEUrdebXgsotHl4FViQZvO6WOify5doPXZ8H7bDPlbeIAjlM8dLTWDq2owWvRP8ZyY5mLeclm/QoC3CLXaveKh3q6RcXBdrBx+LhmMH1uI2FHZOVxahDFzTIuaRNYvNVp+dmY7SzL700qph2WEavOT3asqn67hMDnSiV60aVFucGksysT0qGfHHDr7Uv70cCnMo5icEqbtIbUd+09Gg6qIRFLJbgcToIvAV1XNPbZIQZICaZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by IA0PR11MB8353.namprd11.prod.outlook.com (2603:10b6:208:489::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 10:17:27 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::a2bc:136a:3f41:c858]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::a2bc:136a:3f41:c858%6]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 10:17:27 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 2/4] ice: add bitmap to
 track VF MSI-X usage
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 2/4] ice: add bitmap to
 track VF MSI-X usage
Thread-Index: AQHZ6fw2/y7PsKynG0KbscyqBLlQV7BRFtow
Date: Thu, 19 Oct 2023 10:17:27 +0000
Message-ID: <BL0PR11MB352146C87CF7BCD0A1CF50B48FD4A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230918062406.90359-1-michal.swiatkowski@linux.intel.com>
 <20230918062406.90359-3-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20230918062406.90359-3-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|IA0PR11MB8353:EE_
x-ms-office365-filtering-correlation-id: e02e8eb4-2e67-488f-5dbf-08dbd08c9899
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FIe++NpMGs4M0pouvT6a0awIsGHsRbvsj7Sr6BgfwmK7bcOr4gAWfvJ/luB89LP0vXGsh40u9sxPn+VoFEa8gNsNMd1NJYE6H6HePZT8z3qJU+0P1Fi1zyzXEE5sZo1KQXKjFDSqRiru93GWTMJceXGadGuppBqITQ/amcmGjB67oAgt1srSH38Qx8Nqfcbl5ESkjLzHKFJYhn+sYOCG/4fR1CQFro4RmOUlW9T6UOjDN1cpQqJZr06HYF87W/5Zp6KjDXaqoUf4PTVTyr5wAhjXrAk/nGAxhm1j8Bdztx/A3BQdKDiAjrt3o3uvW/qcAn+povvgRALSkxv3O+d70fsLprdaK9uNNr9KhD8h1WD9FnJLsqfH3MhLxNlYM3sxJXY4uSP2SUmlbhv+hXJqWePQUfaUdLmfY/cFcBXzrkuDevfYoX1vgQYI0wcHOUuGVc28FHTtLNr9ZP4tqcdtPCz6FDKhP/xaWvpmiYtxVedM2v6z45nIWbjF8pVrcceOojcleIXG17xbRT0HmsqvtiChSI73aKu9ggQA+Mimf2C6Jcq8tYRaS7fJz/UNcGO+BY+ss7Ht0r6ltmVSrjmVlcPvAruEGYOkW2zrpzimWLDqPrSkjcyaLjJh9eb988W1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(6506007)(9686003)(53546011)(7696005)(83380400001)(71200400001)(54906003)(26005)(316002)(41300700001)(2906002)(66556008)(4326008)(110136005)(76116006)(5660300002)(8936002)(66946007)(66446008)(66476007)(52536014)(8676002)(64756008)(122000001)(82960400001)(38100700002)(33656002)(86362001)(38070700005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x5Vj77y0LmmcUb0jrYTwv6ziJeqU4eaV02QloAXQ6zfAmNb7TdnElT6i7EMf?=
 =?us-ascii?Q?hY/mOtpklmyUwSNVMS7TgqdQw5l96YHulhPqimVSqkCXMT9s5uT1gt2oJH25?=
 =?us-ascii?Q?8QtvUN0CKr3uuFfi6quVKMv2tUuxjELXX7KIVV80y8Ikei6DYctvl69YepBB?=
 =?us-ascii?Q?4duPPRTTyuWm+/mHcvZearuQSePilZzNrJFhDw9XyKKeUS+AWlE7ywwcRtUO?=
 =?us-ascii?Q?Yri3517/gwNg+KlWryhIbcjjF2m7KE3BGMxY4PSOK0FIDjRuO1LAAJDVEQz8?=
 =?us-ascii?Q?JgvEyM5w2z4Fdgpb24aJ2pj1NpsKmFDkCbnv+j3UBUXaW/DAWKbdhIF8kLTi?=
 =?us-ascii?Q?U2HOW8wsylT61jySfG5B/huDYsTLgDqRdCjn/5wxvEg1hvkuB1ThVjXDJjHd?=
 =?us-ascii?Q?GGJTEkCZ2JnwXF3N7Z8+AmEIibvI03xKy6wiQjFyruRsqqPIb9Lv9jCA5Qcu?=
 =?us-ascii?Q?MixQhc8q5sumlCD1ov3tZ/oF993aULjNFxKRLW8vwoFwSj6phJDh/nlSRwo7?=
 =?us-ascii?Q?kOe3JhdoBg0YxNTgoRw4F1cqsOiE+KvUxL3nMi2bAhFsyq3QsuITLJjWClkx?=
 =?us-ascii?Q?rCitA9z+Nr1EC/K6e7/w0kpQWaPVCMdXVcE+gDDFn6xYRrEf74HNpkXFUy6w?=
 =?us-ascii?Q?OOYdUrNN+SMgmsgeuY3dqUKeVIdp2nhXT1Tn15FzjqBUd+fJ6uWpTFg9dIhh?=
 =?us-ascii?Q?XFCst8leovQ7uSrLKmrtjWGpTuQ2PHD2Y7Tz7ubTpoaS29WuFnu0QliV9UMg?=
 =?us-ascii?Q?NrFUocFvmF/+pKJVATGvGtDyLcFDrDPUF/RrJLLVmxZdnGCDr88HuOsZ9Vmc?=
 =?us-ascii?Q?Xg7IGS4pm9vQdGstDmbVJZT2pkR90Gp7USHbNbQifMrCnP3f+y4JXvoSiQy3?=
 =?us-ascii?Q?G4X+4ajg0X7PgNdA1cFMVnBUetmdcUd30Nu1fBKgM7kxRAuoMKHbIxu+H5QO?=
 =?us-ascii?Q?2ISwyFaH5lBg4rgOdP3o5cCpDPEjZeIIBOU+SXKjy5ezJ8OhOPw+Mlo4H4zT?=
 =?us-ascii?Q?ieDvHyEY/JeeFIu8bB0zQ5kIrORAAyKHgPvWMVVcoo9KAQuThljxUSFOqRtn?=
 =?us-ascii?Q?UfuSSmOvLcU54KlOFK+VM22DUWyyKUwx2LRNF6cwgPZhsJ1eDLxUz8PE+cq7?=
 =?us-ascii?Q?3rtkNO4YkbIqrsidCDZkPVydvPK3myx5iXMStDI8zlWWIu7lhh88wWeHEu3G?=
 =?us-ascii?Q?YEA5kCWoP88tDgWMY9aBtpmtYFd4Ew9UZwNoKlBinXUugIve7Bpyp4VLsVdN?=
 =?us-ascii?Q?ijajX4i7o08n1ApdHP9+WtAIJGceymks3oJrBonVtnGzxkEyKttyFZ1vmSSN?=
 =?us-ascii?Q?CHbNvofODFgE4hktnbhyzjg6XNJQXKyyY/5AD+ctLmVwP5TlJQ2fmky5MjJZ?=
 =?us-ascii?Q?U8BR0RT+acZ6D+paRbyWXfjsJ10ow5jO6wAVWl/LMFeVRk9Yb8Fyo8oe3kXB?=
 =?us-ascii?Q?jI1za7hZmgir/Te4gRe61ugLMfyRhe541zI8PwDEF+srx+rb6S95ycxgO+nh?=
 =?us-ascii?Q?Y8wDtJdr3QTaw0YYBRiD16JXd9t+/yu15PVCUzCcNx8+9l0Veqol9lYbsc0M?=
 =?us-ascii?Q?57xgFXLaTzvQZzloYHG2wPyjmlbTwntPoE1eEGIrpu/DoYAmphD+dJ/DJjJH?=
 =?us-ascii?Q?Ww=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e02e8eb4-2e67-488f-5dbf-08dbd08c9899
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 10:17:27.6991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nw3i8bOIxNlAKmNocp8eaJ/KSKTShyiddVyz1hY+Kque2DHuYfsRJck98qPl4ExVkp+OSMgrEJQa4hjgFvA/gAVQRsxsNVjKnLqtsrD6xng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8353
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
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 2/4] ice: add bitmap to tra=
ck VF
> MSI-X usage
>=20
> Create a bitamp to track MSI-X usage for VFs. The bitmap has the size of =
total
> MSI-X amount on device, because at init time the amount of MSI-X used by
> VFs isn't known.
>=20
> The bitmap is used in follow up patchset to provide a block of continuous
> block of MSI-X indexes for each created VF.
>=20
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h       | 2 ++
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 9 +++++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index 051007ccab43..5fef43d3d994 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>




