Return-Path: <netdev+bounces-56321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5726A80E876
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA021F21319
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A9E59161;
	Tue, 12 Dec 2023 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bo4Lj/zD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F384E8
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702375266; x=1733911266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M0DO/1CKPwow6Bo2FuEE3Qa8cqwbvzYf12yIO4NdpxU=;
  b=Bo4Lj/zD+iNBApDHM8jw2zxIkaf9dy9j4aFVpTE7k5bT8ViVpJaDD0Vg
   evpKxOy8+7gGLfSpL/aEzAulOwz6eXuGt4Qjo87N8mXualFVbeeN/+r6c
   cguco5REF+Egu2KqTdnkwTleqQ3o3d7jAFh5F5PZy//He7au/fjvk4X9f
   u6+5M3EBEzQODb6SxC3925ZdA3Z5a4efam7TJ2X2Nr8nrVJzKp2yvCE8o
   7BoNCysFFyatIx7SiCuDigk5H1L1oweGLF1QJ2TE7KSaNUNg6AHut1WdB
   Dg2bOv3cGOqLBzkd6EPfBc36VqxiMerwy/lXjN5G4p0WoJh+wfjsoNJnp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="391956699"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="391956699"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 02:00:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946708465"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="946708465"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 02:00:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 02:00:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 02:00:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 02:00:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 02:00:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxVjusSjjzBQ344ztgnFH9gsA0cBDdY/9R8RdV6a14E3VTiEOnWq7lxjroWSzBkiIAOb74HsOTbCzZveQrDHa0lS0Wfg621WXEOek+6PefFDbH6G0Aw3fyDNfcN9RzRyvq5gEHrueS5Y0ts1ZV70EBBzZroLiVlgTpLReVYEGV3OebJ2Kc4GcT5LA6yyvps9ZGlSp2sIJry1ks9opZS2Fq6hGXwPwHkRs1PlKfOabg/aW7oaYfGvYBBlYT6yA6nsbu2pD0bkFQG8IWDlgPQVt0RemIIQ45G1dvXG9EW536UafWae9V2GqEU4OOrNc1YmiTh2/te/t0ixptxF8hD9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1U2CxN7MarJ57nhmJHaL6SsMU37zww8+31QgWKCGDg=;
 b=alrYltrqhu+hnGaqYw5F3AU9BGFt/R8rDcVYfCU6zOdtgV+/a4H+4EM2xHFPO2Zhvvz5hBaifoKQF/oKkpUC9mDNGSWYuGVlEsyEC6XLRZ8CGq1P34rEEdtBAr6YKob7Y4hIQXAeOy40Pl03ovjhatHErc/X08nGfnqS7NW/KgN/rv7c8hrAf1PdvAN/7LFg70fc8Uy2HDK3JU8+pKxGYJ6ZVKPlIRQyfalmUyvJFku3BLw3yzdxciNR7wtzR41LC0Ix9rtH1H5TBd01/5RuhVmEWIjyhEf3yzQHpu7gtwI30hVlqGmKL1gbTd7rcSlbsU48YKw0xgFOS9Ih8JqLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3528.namprd11.prod.outlook.com (2603:10b6:a03:87::26)
 by BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 10:00:03 +0000
Received: from BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::7273:de04:d24c:2457]) by BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::7273:de04:d24c:2457%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 10:00:03 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Rao, Ranganatha" <ranganatha.rao@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Gardocki, PiotrX" <piotrx.gardocki@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Rao, Ranganatha" <ranganatha.rao@intel.com>,
	"Zaremba, Larysa" <larysa.zaremba@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1 2/2] iavf: Handle ntuple
 on/off based on new state machines for flow director
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1 2/2] iavf: Handle ntuple
 on/off based on new state machines for flow director
Thread-Index: AQHaHRChAM2T33r77keUC4sjHj36d7ClicDQ
Date: Tue, 12 Dec 2023 10:00:03 +0000
Message-ID: <BYAPR11MB3528126CD38881E57659241F8F8EA@BYAPR11MB3528.namprd11.prod.outlook.com>
References: <20231122034716.38074-1-ranganatha.rao@intel.com>
 <20231122034716.38074-3-ranganatha.rao@intel.com>
In-Reply-To: <20231122034716.38074-3-ranganatha.rao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3528:EE_|BN9PR11MB5370:EE_
x-ms-office365-filtering-correlation-id: 0835754d-dae3-44ce-5c09-08dbfaf91c8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +bt2mjTgCcdi1DQw4ky7OKQ3q9IK1HIe85zuNJbIgQc6mcrbEzjlAicoJwLU4TcFi2aiV5FPOShNXLKBGyxhEGuEEEn1ElD3FRy4EcHmarJzlXT8uQWrvmRDInvFAueh0pWDLVoIkARuuE1PTbfkRVLe/s7+oWFM0gbbTDNshKXDSYm1e5p/3ewAv7Q9yOehMdf4DhVoXYUot69gBAIljj8uh1BlM2f6ugjP0MZ6RCcPKQKIphn/dZclU1IK72p5SKDslZKCUjs53dBunqzBzHyrPm0zaktfFZ1vmGzbm3HnOt0VwtqAANo2T+G4Lk7JO8NJCerLS6U0iulZQuRBaKH2Z3mnHufWWwloCBrQnBKKqNvOkiaJhaFS8a96/TnIBssRnrsN+ZpPjkqrDqPFlzcnc/lASyuEgGd8AZ39qPAeI3ABn7XDidHSl8c9Er2PonYzsppSK5f45V9mxAzaVQv70CRoKwvQ7aS9mqXEvyyHkA2V9MhPYktJGa/1V4xelIP/SdygqU8facWnIgpMWubOfgrYQYsYn2bGx7v+wO+7Dqv0iauYq43FG41uIw/H8Phehx0pJ4abfyYNI+DVEJ1V8JX9rcxRuXqgwH0viLSq2jy8e9PVtYFSLkjru/pg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3528.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(55016003)(38070700009)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(82960400001)(33656002)(86362001)(122000001)(83380400001)(107886003)(9686003)(6506007)(53546011)(7696005)(2906002)(316002)(38100700002)(110136005)(71200400001)(26005)(478600001)(5660300002)(52536014)(4326008)(8676002)(41300700001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tg2UUYxWLabChXh0uKJEocDbjZ2FeyJpb5vmxgySPZ58XLw4UapihknLw3lW?=
 =?us-ascii?Q?KRvIZVyXqU6D0a2TygttGC20/NzMywESkzwQjiIiTc4c8+/ZxDmiU1fm9CP9?=
 =?us-ascii?Q?J0gWnkgPV5jh1uw11f0G6q0Z40PFotIg+KqOPevwi10LhhIbAg5EpOlisM4p?=
 =?us-ascii?Q?6/ACGdyhqoCRYRrR1875sh81POBn1/MvA4VHjxLOCIvXyjlS1qa71pwB54gL?=
 =?us-ascii?Q?QQe8z8UKp6zMZ99IGOIRiIvATsBMymkplOUY90mzx/MhcHYjRcHBmPv+vEzR?=
 =?us-ascii?Q?J92yTUK2WlxL/dQ0eCXKcBrx9CfLHd4RayPZGQeo8j/wIoWLQTY2ifYr9yBY?=
 =?us-ascii?Q?xkfaerp2CDdeeDgtgS7tXnLybdGYdZQiQMR0c0TMGkQ1B7Bw956YvTghoVtH?=
 =?us-ascii?Q?zaeRLG4KPNKN3bEejVHjJKkEu8toGWvW2FVFKHAEOYrxWeaAcfOdVvxgTaHZ?=
 =?us-ascii?Q?EbJHrE+DoC89J96oA6WVldh5qn2qw4iDpJ1RQOGP1xOZBUj2kcnyCx47tcUk?=
 =?us-ascii?Q?wUELFoAzE/nr7CtIBYcrfM2nt6i4AiCLX+qh+OfFqjYYiYZNUqBgOIIzGnV+?=
 =?us-ascii?Q?OuCm33wVkYHEhJscqKio0kZ5m3UJRQjxOMfYtSQkyIKo1ndXILrCyrwIsPQb?=
 =?us-ascii?Q?KZkv4kjlnyq4/UOr9hfoCXxIt5ZDGf650Gs8LwNnt4MVPaYNwHA6ynXXrnul?=
 =?us-ascii?Q?u358cLvKi3SuylnF3tkEJ59r5N2NcstRI3q5vqgjfnRyC4Lj0TOpRo/pIFSI?=
 =?us-ascii?Q?clRly1QTIDewF9WUyejuv1zIeibZNofWG/FxP4eksKKeo31Sb1ZCXvR/okHI?=
 =?us-ascii?Q?2z4XvsGjuSCN5nqnX9hl9srCyU/ekyhMS8rcNr4JuDCNuHXbO3dGQWt5NGMm?=
 =?us-ascii?Q?0hW+aAQjZkspxJDX/p0aHNMUwanlYXQo+lIV/NR6pUppcNX4x4A5xr30FemW?=
 =?us-ascii?Q?wWQxFps7NXKgD8qhqFsk6pSa6yvjRqonbxJESSl7V4F98sOFkv0nHlC+M5u4?=
 =?us-ascii?Q?WGKF9oFHIXK2FYQSEKQU10gQNrGVct3vphuF2yMMBSTGnnfxhgDv+3/URHNU?=
 =?us-ascii?Q?68DZ091mzaQUUIWumCITRv7FV8t9i8229Mw6nVNoHP7LMS5hStBYuxMcFWV3?=
 =?us-ascii?Q?SdAAAYKa87sdXF3vDo4sF/xGx5jg2VYaoGyhop3lZD0GC0VjOsq7fKpFC9k+?=
 =?us-ascii?Q?Hn4nrCskIZpWEh+OgMcJ4+1gMXMQKzOX6S3T2K8ZQNfkln/aR5g9LFt5TC0j?=
 =?us-ascii?Q?p0Z4gPyRvSjypFXNal8Y0yatgqM7fkKFvz89qaqrKSms6vUOzW7RrTgKSZ5R?=
 =?us-ascii?Q?BOcMOSbpPnV4KamFHL9XStKqTooCAC6oSAy8/TJ5UnjNgS8PGIwlv8AOgv36?=
 =?us-ascii?Q?K9MZIKe48nLQfVGrR/BdwwvJJCqwjy801VJuLlsCRkRlNoAhtcUkosEQkAhD?=
 =?us-ascii?Q?3N+5zNzso4QFtcksr+Lpc1wRAAD4NhhfOGhm4EZcFvb6qkUK7wxvqmoWJSZp?=
 =?us-ascii?Q?FJ9D+yY3DxTMcWKa1m/DQJCkeC7ZkfpFiU1t0DIMk8EMV2+vtLKdipwXiMlg?=
 =?us-ascii?Q?gMsA/DiN9SEjKP0GTEpgfkpdHSyN/huq2QW57cxsjmTEcINoT/7nPQGIcStX?=
 =?us-ascii?Q?aQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3528.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0835754d-dae3-44ce-5c09-08dbfaf91c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 10:00:03.5777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3UYtOk1AjodoImhcVlqAXOenRhVnWoQRxEsKw8zfnDc5RTuOEiBXofsGkhdtuDLscijpjW2ZUJaORi5zkkiooQJYgY6zHox19m2be6LQG/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5370
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Ranganatha Rao
> Sent: Wednesday, November 22, 2023 4:47 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Gardocki, PiotrX <piotrx.gardocki@intel.com>; netdev@vger.kernel.org;
> Rao, Ranganatha <ranganatha.rao@intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1 2/2] iavf: Handle ntuple on/=
off
> based on new state machines for flow director
>=20
> From: Piotr Gardocki <piotrx.gardocki@intel.com>
>=20
> ntuple-filter feature on/off:
> Default is on. If turned off, the filters will be removed from both PF an=
d iavf
> list. The removal is irrespective of current filter state.
>=20
> Steps to reproduce:
> -------------------
>=20
> 1. Ensure ntuple is on.
>=20
> ethtool -K enp8s0 ntuple-filters on
>=20
> 2. Create a filter to receive the traffic into non-default rx-queue like =
15 and
> ensure traffic is flowing into queue into 15.
> Now, turn off ntuple. Traffic should not flow to configured queue 15.
> It should flow to default RX queue.
>=20
> Fixes: 0dbfbabb840d ("iavf: Add framework to enable ethtool ntuple filter=
s")
> Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Ranganatha Rao <ranganatha.rao@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 59 +++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 567435e23936..98116872f6bd 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



