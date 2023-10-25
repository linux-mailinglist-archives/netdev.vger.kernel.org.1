Return-Path: <netdev+bounces-44260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE717D7667
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B471C20BDB
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B43328C6;
	Wed, 25 Oct 2023 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQko0zaF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65EA12B6D
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 21:11:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E21132
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698268273; x=1729804273;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5gs4lXG8KLyQ5th+xdGtP3lwAApi+meNjeDUNbijJ6U=;
  b=GQko0zaFGHHiOOY9A4oncsBDZmjXDpJmXn3uByVqQforJLZ2wLL1iSnS
   os/NSa60DUdRN/FzgVom/6Z3FDNn1WSebk8a4yQGGUutyWkhutwih/nPw
   9qcdjkpn0JcPDLRt34Kg+uRBUJJrTwYFBrUU+GBnhYAuQmKCb15AvEsIz
   kxk+E1zC90kA9M8l3XPRMBhDDKhr2/UMPaUzDtvBuwzBsfYzIhLZ3avPD
   UiMKd1vu1gSvL3EFyk7kD8pGkCubKvIiCwPl5kxttRv+K5zWK36F13M4s
   0CxzRihuOOrEY97V/vdfX/+KjRyxy926giOZvxNtLaAebk66ZHrNeokAk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="377769618"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="377769618"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 14:11:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="788253485"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="788253485"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 14:11:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 14:11:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 14:11:12 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 14:11:12 -0700
Received: from DM6PR11MB4218.namprd11.prod.outlook.com (2603:10b6:5:201::15)
 by BL1PR11MB5256.namprd11.prod.outlook.com (2603:10b6:208:30a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 21:11:10 +0000
Received: from DM6PR11MB4218.namprd11.prod.outlook.com
 ([fe80::1c69:1b8b:5fd7:2e93]) by DM6PR11MB4218.namprd11.prod.outlook.com
 ([fe80::1c69:1b8b:5fd7:2e93%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 21:11:10 +0000
From: "Brelinski, Tony" <tony.brelinski@intel.com>
To: "Greenwalt, Paul" <paul.greenwalt@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "Michael, Alice"
	<alice.michael@intel.com>, "Greenwalt, Paul" <paul.greenwalt@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Chmielewski, Pawel"
	<pawel.chmielewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v5 2/6] ice: Add 200G speed/phy
 type use
Thread-Topic: [Intel-wired-lan] [PATCH net-next v5 2/6] ice: Add 200G
 speed/phy type use
Thread-Index: AQHaAhpb5Y2LY3eiiEiTF8qQ6rjRULBbCzrg
Date: Wed, 25 Oct 2023 21:11:10 +0000
Message-ID: <DM6PR11MB42181B8BB51EB523239AD4F282DEA@DM6PR11MB4218.namprd11.prod.outlook.com>
References: <20231018231643.2356-1-paul.greenwalt@intel.com>
 <20231018231643.2356-3-paul.greenwalt@intel.com>
In-Reply-To: <20231018231643.2356-3-paul.greenwalt@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4218:EE_|BL1PR11MB5256:EE_
x-ms-office365-filtering-correlation-id: 8188989e-edaf-4377-7457-08dbd59ee99d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wce/LTiUu+IkqLuKurxHHUCqNzckyxwkTIstU3NEG6wVqCo+pLz2s9uHsK/uDEwEqqoJt8uIlC7uHrq/vp5JVJ6/KNvljgLf52rAPwY6iG08b3hQuuTuKB4n3jJ+BBkgQXPFnDiCEmFeFNcJUELtencfJYcsnE51FBBScxNc/sTEy0EvAINEguBHaRcfLEJ38Syzqlis4SbXnYKIKwkr97sXPYpT/izllpYqc9wgsna/bdC6i3Etu/zOuDhLvrUsGPkKMl7kC7cc7bELX/P29QHn+gswuTtMEaL9A/jxcrv3jYX7eF8L/Jc31dC98gWIC04VV8N4B03x9yeO51ls40IpRj0Uhsj+EcbBAWsbG2m2Amj8hje7MW0g2TtQovvPJa0w1T1i74S2V/NrY/ve3apznMLGufVtKhO9ORPU00nUrgPOqVsJeYUTeHDG0tfvccnGiZt/TR02HAR9birCzsOzpT4JOekPPHT8xq5g3Je91G9TBIMV/xOSDHCvh1+sdKeRHtdvYBhspBHk2f41Yxz+udQ5iDrrFCzkPXXVINrvAo74+noB8dZ0Ea9PAyGTb7BIR0LVDPnRuix4HneF4TT+ygbZsNvwPbYimxmKcKX3YsXgfbQAs7cUJpLvfYVI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4218.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38070700009)(2906002)(53546011)(55016003)(478600001)(5660300002)(38100700002)(4326008)(8936002)(8676002)(41300700001)(66446008)(52536014)(66476007)(33656002)(66946007)(6506007)(86362001)(54906003)(71200400001)(110136005)(26005)(7696005)(9686003)(66556008)(76116006)(82960400001)(122000001)(64756008)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kokdVcSljZDE5hFdHX0ddQdp+ahrXpq/lcWHch8df8DjKSOddu34KumPalyT?=
 =?us-ascii?Q?UhJ8w3gSQrQ47c29hykbBXKiNByxxuJCModpbEjpG+qzJ6X1h+ufXutoCgEO?=
 =?us-ascii?Q?TYJRPfEj6jjQy41gTz9Be2Bt43kDhAWAZWJY96Uto4suSQzySBLDHyiD4bhP?=
 =?us-ascii?Q?n6mrcp7k+8uPSK4opNr1xnWj8FWgZ145VaqIx8gs1x4oFViHunBy0kynQJ37?=
 =?us-ascii?Q?NYp2uieMp1JB7j3uiSb9X6L52sIQUHv8D7v9BckMtjG8Z1y5slWhHg9LYX71?=
 =?us-ascii?Q?f9QQRFNCrvitbJk5LVwpIXwB8YTb/CYK+Plc0kuA6HWpWeayS5Wt+RrqeeTV?=
 =?us-ascii?Q?Ed6BYA1r1qRel/J+e0iq8vX31E+tniZNXH+xuoUFAwZwxdmoTig0ffMq2QII?=
 =?us-ascii?Q?hEdZeUE4cs0wvzDQPMCEKT9P993nTfdDWk4t8ijGYDK0NNAeSBS71p1Vfqg6?=
 =?us-ascii?Q?Vgx9Ky1eWpOiBlVbD4tJl5ToXQD1/+x9JjUS8VgVMJJTdXTSiZ9JAzbmmthg?=
 =?us-ascii?Q?VhKZZ/9WA9W973cRKWOaftQIBdpFQqeMgMOXcekd3SW0jVvHzy1NLG6fVcUD?=
 =?us-ascii?Q?3FWr71SwfSnjm6+08nHbfploaWg0JR32vDCdaqAwGj3nTU6qUVFCQuv/ODKb?=
 =?us-ascii?Q?BZuiveNGcOWCrBPgl+tOxFxMpMVeIfYFcXkg4A0fDw7djI3FJZG6y8ReWWId?=
 =?us-ascii?Q?+6Mo88DjaaOuXMmVBzRUpcKhWqMPkC5etDc32s0GQ5spJ08FdnGyulOhyJsp?=
 =?us-ascii?Q?F+B/Q7SfiSTOjPUwFPagh3tXLKGFINalfF6o6o9oZuB5olldcJxzqGGgZTXR?=
 =?us-ascii?Q?OAcCmOZsIqv2aKS0RC/gE5rAlnw4ofZwvBzQ6rkuV0gZEnuJtG2e5iObIy10?=
 =?us-ascii?Q?Z7oyMfsJfQ8SeoOFRS9KC6UTvJ81pdkFkOFQ6ZF1By/Tnuf/Kr3092p9neVz?=
 =?us-ascii?Q?vd88BwR6Xnp0X2YWLN9CATy30UCmIh30NcrgfHPMgIcHPcKYwXpsON1/a5Ej?=
 =?us-ascii?Q?c1DxcJXgEX5zeGM9BYuk181cNNdzztd9k0H1ukaRmaGFxEo3flXJpzqSKzrR?=
 =?us-ascii?Q?IEN+srqkMdm94FHY4qv/BnSLRZgBJQGpearyqNdDmhgvKDQ38vR3S0Lz2xvu?=
 =?us-ascii?Q?5sUBxDQo/+WC55s9Pv4ug+UANa+08R47QLW8HdLBIqJF8c3TQgOu5+z2VUIH?=
 =?us-ascii?Q?r5GEgN+zNWD54S9xD6gOC3Rt0o49yOmliYmFsKP2fXAXevn/CVEINe2spKkN?=
 =?us-ascii?Q?EJW1Toj/ZntcFxe+W7ncIqR9w72McFJvlVXbXEzh5qm/VwoQPZqq34xvcLIN?=
 =?us-ascii?Q?8pB903pIK4aF+FDaocWCd4CKpOTiT4se+X7NWhPebxlNsooBwRkIJ+/zHguf?=
 =?us-ascii?Q?3gHnC3b6QBlDAaKsKSYXripDyfReWzCmRi/G2B3BFE7xetQGbXFuY5rD6gAu?=
 =?us-ascii?Q?V/iCJCsIEEIyiUMAqrGjz6SoeGE1f24y53dYogtlJFtauxTlSt+F3dp3O/xf?=
 =?us-ascii?Q?tKsuwKKPgFZpSmZ0hSrDomzRhnLsQP4XBZlxNLt5XW/w7v8MiQO6k+tqBiRO?=
 =?us-ascii?Q?oJPXoIrBAUZPvLh8rtPjNQzjLFFpcmvZ/Vu6JGuS?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZpJAH2UkrD5hnC/gDfkBRSmp5H6p9pZycF+rKv9CVyowqYnUhBrb8Xc/cgmUZwbGDMoh2taKPEVER/Zo80h3GIjdVlKsQdHDM24Zp95b8P8wFsS2EmOE5DL/TPgKFD2RwxXgENsG2W5qyRFbtJ9fMxHDAWEUlTrq8qae+cS/T1cx9rymQToJLZhSRHWIXje80x9wJszhVHSJcVEzG5/YgLI5udAtsJwVo96wFHmc47Y4mTkrLDlOpv4FPJFBhq/iDvdTVS1GyZbH/G82YlOY89OFXUimBGwgTAG3nCv3kpnuOS8QTU9B/XhcNTZk0t/8VhToCs0jZiH7uc5jJeZSg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfATIcr9kDhSA1kwGP6sk7CCPngPHdUYgI+o/9vnovE=;
 b=EmYCz0oxIbqrvDVwpY1ylpv8w2v1nLpwyProXKq1BYk9KNOoxP3gnDdfIk2aCOV/zHqqsYVTwLR5FNXGXybYr+vhJ/Jy7/OtEDeuXb4anYfojNCbBWcD0KAUbc7n2mywMHY5ygDwlCoi79vuXCeTTl48UuWMfrsDQyE2MRclh9G9gdGpV2hCqUDunpPBTA4FkoHR7mpdmqh9ppPzSLoIBdmIorZiHjqAQbF+B73BaBLiIvC5MPo/LerP6iysGJvOxP1u2Rtxq/zSsIfJ+v5UyOag6LMoWFJsuXQGaIhGNkg318QGgU6+Ca4Wzj8fSG6bUxT4G+ZGEIHCtk+J6Oo/MA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: DM6PR11MB4218.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 8188989e-edaf-4377-7457-08dbd59ee99d
x-ms-exchange-crosstenant-originalarrivaltime: 25 Oct 2023 21:11:10.3916 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: JVi1gxCt1FQPB5MDM0YprVHH6ICCJcmjh3wgHvay2RlOwf9eXxrxok9XaDhwG8YMO3Y5IfXqTocn7VvlYiNEc0RgBDo64ZeR+ZLud0HPHsU=
x-ms-exchange-transport-crosstenantheadersstamped: BL1PR11MB5256
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
aul
> Greenwalt
> Sent: Wednesday, October 18, 2023 4:17 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: andrew@lunn.ch; Michael, Alice <alice.michael@intel.com>; Greenwalt, =
Paul
> <paul.greenwalt@intel.com>; netdev@vger.kernel.org; Chmielewski, Pawel
> <pawel.chmielewski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; horms@kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v5 2/6] ice: Add 200G speed/ph=
y type
> use
>
> From: Alice Michael <alice.michael@intel.com>
>
> Add the support for 200G phy speeds and the mapping for their advertiseme=
nt in
> link. Add the new PHY type bits for AQ command, as needed for 200G E830
> controllers.
>
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> Co-developed-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 11 +++++++-
>  drivers/net/ethernet/intel/ice/ice_common.c   |  1 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 26 +++++++++++++++++--
> drivers/net/ethernet/intel/ice/ice_ethtool.h  |  8 ++++++
>  4 files changed, 43 insertions(+), 3 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


