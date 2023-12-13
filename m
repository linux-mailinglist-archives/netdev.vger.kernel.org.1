Return-Path: <netdev+bounces-56695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5EE81086C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 03:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FC52820A7
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 02:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F8F568B;
	Wed, 13 Dec 2023 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0z9wvW+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25133AF
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 18:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702436268; x=1733972268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BPh4I0I0MxQ/trO9hBwYoT3Y90uzEoBpM4caD6ZPOlQ=;
  b=I0z9wvW+CSLC2kUCfHn0+n9dR+EQXNG4HFbaJKgHT3zR0BTy31ThpVSs
   kUPBL9leu0sAhkQD5voExhwwgd4NkPqlliuO69H3MqZPx+i+Km/UxEIrN
   SE2Dvo9ENhunYm0SJSHnB9fkIZS0t4+zbF/9Lg87Uezkbhrz5YYkX7XjH
   M+wGVWGASFVn01xGglsikxZZ/APy/LSBpog35dxs3bib/+RuKaEWK+GDa
   FGZ3MpgBOaWIme+MLx3g0JFJ68S5se5+6rgpTQsT4u49BpNzcNKPh4byi
   rYcvzyM77+Y/S0mgyC6Pi5rREd9ZI7j2afGd7KHgoeqtyf/sdDwsF3B+T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2077777"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="2077777"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 18:57:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="891853526"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="891853526"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 18:57:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 18:57:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 18:57:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 18:57:47 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 18:57:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFz78gK0e6ZZf9UeR91BtBJ0Vzo3rzYn37JmnYWVMSICG/lQyLxgrONlKMl3jqiJ+h5XAWirlWL56A/g0z6+NJxXCpno52buXbtEJSNoID8AWe0Gikimr37eKoTDZMmU6ShegQ2Ksq3v/98j+UlIIC4nUw34v+Qih/7irgL/ljy0ZEFMIhvct+YtCudPwFHGf5kY7pw6sOfgYZs/3HC2pNEVxvwgO9csEIKgoYS4czxKj1mu2yfdcYFF27EpqYcuJEBmhbuTxettmqmpXX7b/IGG8cCwYQMx2g1td1aa95fRm+Z1xmRV6l85y7HjwwwCqas1E956ZufckvIHzb/mmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPH8v8tv454syH9u6xLh72EpC+ZksMkuMekaq1PIp+c=;
 b=OyWHhtQz3v64f1L0tuLIrLI9NJCM7Gc6IkV4uRvVAhEgtpC6Yhi8ltTqhwwt3bMesUQM+u9TIsNin3El0ybASxAD6u7IfU+a8ON8dm5g6RB+b4+dwvcpAwopT25KKAqHFmDuYQsaECTA4+4k44JzaZMmQhAAsF0UQrcjaKvDvD5q4rldDMHSG/p8n/NZh102vwrgj7Smlq+s1SIsg9r0oWYhnFhwOnuhC74PKS2N56rqAKUMCp6SCl15mTgejjInRyoBRxAbmYN6QKa4usXxjUCsd2p7Lle9d/deg3Rqj1a0cKGN4+ikP5MUYnw1M9NRWObhJuSaNyi2K9m1DA0s1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 02:57:42 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f%4]) with mapi id 15.20.7068.031; Wed, 13 Dec 2023
 02:57:42 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "marcin.szycik@linux.intel.com"
	<marcin.szycik@linux.intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 13/15] ice: field get
 conversion
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 13/15] ice: field get
 conversion
Thread-Index: AQHaJ9/0+9xETpsP3EC9wsJEt2kUHLCmjvZA
Date: Wed, 13 Dec 2023 02:57:42 +0000
Message-ID: <BL0PR11MB3122C5B0DFFB1DDA264DEE63BD8DA@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
 <20231206010114.2259388-14-jesse.brandeburg@intel.com>
In-Reply-To: <20231206010114.2259388-14-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SJ2PR11MB8451:EE_
x-ms-office365-filtering-correlation-id: 98ee749a-d52c-4418-d2b8-08dbfb874692
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oy6g8q7642n00U+qikngZ94e1JaezOyTE3TZ5oz9tT0xJM3Ye1iwKwasjblSykFWVsuOiCeH0vkIuNhtd3Qg9TlgcXKYNkOQIdGPmDKl+Ib3f/fGVaWD0As/JJvXgpTp/V12vNQ3AaU/qHq0qUOKS262Wma6fFfk+KX695Wv2NJkCNAZINkDHvVxwGHnZSuJOsy6+wwF8+6LA4VjERZgcDneHxgePh5fZkDiQkrf5P3edc5IVOfVeHAmu8CUyGKbSFw2fDPGs3isCxz1C9nk80d6qV2bRLnzN3GGIuTbTzMGbW0xmjp0+v8845OnVDqkROhsFdas7x48Zba96nRef2nMpidwwbfoCC6B0JdoAq34tB2pCibMMYhlAzY5aJBLtYYtJwsqHJNvoqmcaDQc6jGkvvVChj8+tkXHVZNA3C6Go5vooluqhJyYeCDt/ySItp+YXKamicTUpTbWOiGeUeRlxm7HwfjLafo+GrEJ1vFy2dyiQe0Z8ZVy48dWusCFBlWxIN+ulKdi8M1OI+0XjN9JOCUIE5cpddwzYc6+GBcNiYHSyt8cLoeeSf2urnYeRf9xhywF6S9RWIXvIopZIbYpRlcDEvCVheG4pASISMZfnftJLf7xMT6EQX/tSjmF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8676002)(8936002)(2906002)(4326008)(52536014)(316002)(5660300002)(55016003)(66476007)(76116006)(66556008)(110136005)(66946007)(64756008)(66446008)(54906003)(478600001)(38070700009)(26005)(6506007)(7696005)(53546011)(41300700001)(9686003)(71200400001)(82960400001)(83380400001)(33656002)(86362001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6RyfY9RMH0u00lPy3ICl904ybzK8dM6CAIKMco6rMfZ9mc+orFMWdGLJaHn+?=
 =?us-ascii?Q?Uui4AV8i+J8R0NE1QElEhkZAQiyt+itIi6qmtqoOXJF5vMXUmROb/4Cv5y4N?=
 =?us-ascii?Q?bZmvKryFmrOYqBt0IfqqXZfbFCMdxII9L6vbkaugmX5HjMOhTFE6akYNQ457?=
 =?us-ascii?Q?z56q0eENtwCG7B9I0FpK3wOKTKBEr8kPCWkCyAyTPeZuveg0A5LOTAKRBYM9?=
 =?us-ascii?Q?drGWDwzsQFJfxUQ0w8Oy4uMqdl+c+d4rjFv+m4bose4ObCNSX+Zo57JHh/LP?=
 =?us-ascii?Q?yLvmDoTW+SnyVVxOhAZUbCUZoFDD/OLPKf4wYHX2As+oPzReotbJPflwL1rx?=
 =?us-ascii?Q?pzGvo4kQHZNqNAts9J9s8G1kuhmaubkA23qT86Hye8EhzSXck97JYo7OrsbU?=
 =?us-ascii?Q?qLAvsuRhQ7rChk/kP3Af4Y/ZPnpTGtMgW303hSfw4jZFe3iUmnhP0wbt+1mK?=
 =?us-ascii?Q?LT1jkXSQApYYYvn9ySDD+yfoijhmXVU8CW7evnN6c1D2pP4eXGsfCgqgRFZ/?=
 =?us-ascii?Q?73mCV5rowTToOFTybqn5DGlhtVGWpzZD7RG9jluWsKPL0J7d1rVpIfu7hWru?=
 =?us-ascii?Q?mwbsI46AFpJDQzHxFgMrDQOHBu5Vy0i0LFkiSbW1RI668DWBzLKSNJpmzMSR?=
 =?us-ascii?Q?kGhCeZxlbi+wk9e+cGMnW91vOEiIF20ZOo14icMyqxPLJmgcUiq+SDrP5J15?=
 =?us-ascii?Q?SVD0PGsMoq0eBag9fP6V5ck0yEzEca+WQtNPQpeBoaXneufyz06t6jc5QoDP?=
 =?us-ascii?Q?fLYTh6AJGelhwi76d/yS4/rqNP8spGEbfWsLm1is+CKLSPF+rEZokAkjApk5?=
 =?us-ascii?Q?Fhy2tveHC1y6QHJq6uh84wTTNY6Itq/LW6LokZIMbLb0l1amWh0TvDCeM7iS?=
 =?us-ascii?Q?wjWXg3B1P9QETxJ4gp7ZKvWCrNBZVRzcAr0OpgQUbo3zXaOA9KHKA60jgUaD?=
 =?us-ascii?Q?zVecGPTuscmfrfORgezDbq/Mc5cMAEp5W9SFnN6J58VZMx+xQlGYZHXq3O0g?=
 =?us-ascii?Q?H2LAmWTzXnRH45VBQtdUVD6eEi3G7ujKgrBipIpNYrbpEu2BIwXuC4GU01Wm?=
 =?us-ascii?Q?7w/tkAyEL+voyf4X/K6B8v8cuoK3aVIRU4/IMF0eRAfCJprjb+N/d6+tmM/f?=
 =?us-ascii?Q?GAag7G9oZnvfZq1vvzsKyRY0oaUJ00byp+dOowEvjVYLI40Z/zQbDpObF5jd?=
 =?us-ascii?Q?lC1YL0BSiF6JQWFI6LXWZKMH3qmvfK3gKDvcQ6e18lMww//3bwBvlAuHBbB0?=
 =?us-ascii?Q?japbFwZVDQAQ3BL/EmQKA2CBUaD6t9+Gj4nHUSxSCHBfC2mK5oyDVwD/Ea5E?=
 =?us-ascii?Q?iJd9uQoMmvHP5T8ofr6CDGLq7Dh8aOEBFs3AzOFV51cnH9hEghnykzlYNvhX?=
 =?us-ascii?Q?3SKAKuhebYR64gUM1/MV+aTGFZsG0lBoWyyaWTnf0+xHBBy13Pgmy98VLwLW?=
 =?us-ascii?Q?yIfFs7wWCh6C/x8r7+DHptyPTE258kMwHA4nEFokW4hu4EAtJIBxE0gN3Tvb?=
 =?us-ascii?Q?1a5c8vmLwPsCLWD9NMsU8Oj8u31vmdV1WlFylnnNoCLaVCqkJ8h1DZkNpNg+?=
 =?us-ascii?Q?4vbwg7hKn2c7RZ/Foq0yPUBHivquCO5U/yPoaA0AQ9TrqIsY5Hpy4nNAN+gi?=
 =?us-ascii?Q?Vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ee749a-d52c-4418-d2b8-08dbfb874692
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 02:57:42.6063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5EF7rMOli3k3tuhW61L0UnrdI0ikKIOo1NRyMeJqZ/GlNRyhALtMuDh/r+tEMY77yzVnyKos1WiqDndx3pM5jl4rxyu/X1IKfjj7zXr4Bn85pZk+EBvWv/pvFp9QGA+s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8451
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
esse Brandeburg
> Sent: Wednesday, December 6, 2023 6:31 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Brandeburg, Jesse=
 <jesse.brandeburg@intel.com>; Julia Lawall <Julia.Lawall@inria.fr>; Lobaki=
n, Aleksander <aleksander.lobakin@intel.com>; marcin.szycik@linux.intel.com=
; horms@kernel.org; netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 13/15] ice: field get conve=
rsion
>
> Refactor the ice driver to use FIELD_GET() for mask and shift reads,
> which reduces lines of code and adds clarity of intent.
>=20
> This code was generated by the following coccinelle/spatch script and
> then manually repaired.
>
> @get@
> constant shift,mask;
> type T;
> expression a;
> @@
> -(((T)(a) & mask) >> shift)
> +FIELD_GET(mask, a)
>
> and applied via:
> spatch --sp-file field_prep.cocci --in-place --dir \
>  drivers/net/ethernet/intel/
>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: added a couple more get conversions
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c     | 12 +--
>  drivers/net/ethernet/intel/ice/ice_common.c   | 25 +++----
>  drivers/net/ethernet/intel/ice/ice_dcb.c      | 74 ++++++++-----------
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c   |  2 +-
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c |  3 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  5 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     | 48 +++++-------
>  drivers/net/ethernet/intel/ice/ice_nvm.c      | 15 ++--
>  drivers/net/ethernet/intel/ice/ice_ptp.c      |  4 +-
>  drivers/net/ethernet/intel/ice/ice_sched.c    |  3 +-
>  drivers/net/ethernet/intel/ice/ice_sriov.c    |  3 +-
>  drivers/net/ethernet/intel/ice/ice_virtchnl.c |  2 +-
>  .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 13 ++--
>  13 files changed, 85 insertions(+), 124 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


