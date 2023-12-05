Return-Path: <netdev+bounces-53793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D36804A74
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 07:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB0C1B20A68
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 06:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDE512E55;
	Tue,  5 Dec 2023 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDKO0MQo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7FE138
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 22:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701758518; x=1733294518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vejyp5UXojq+W6pMkEXJgfUl3vdxm6iec0eEmKql1dE=;
  b=EDKO0MQon019zkOGuSX8INY5/mvAG7DcSLmZYAlPGNnBdCU5Mv/T2pW4
   V7CfsZ6JZmQt2W54hSvKpd4j1CVzf4G4LJMCGLmo1jR/WpISBL5vU1cH5
   7/oKO/XB2fg8r1CSxlHkt+qXX7bOhPAA9aceI/UW8K+z2965EwY67rpUK
   MuKRIwaQcXVR1dKj+8nMCcqZ1rgfM7RSQYNOrJKgohfJYsxdeLdFG6/yE
   Dd9/dVU6CFVOoss+Nvzl8C2iUKoHaO2lfYLPJetcToeEcLLJMj0fewNwg
   I/c7ZB4mdu5SAR/Q11pzQmhzt7/9z0FVKwt/qTt/iSKY9UudHGzIFnS71
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="397747780"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="397747780"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 22:41:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="12227140"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 22:41:55 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 22:41:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 22:41:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 22:41:53 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 22:41:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQGUPgIoxbhb03iYkIZKZAWcS3j7Qn+Y7doS4eZ+9ukgqtU8HNkQ50ac4C8WQwTxcZ4VkUdlUj+glbMIqKNxEK1qrlpSiyttII21fLuGJ2CYMald8vpfA1/3koms7IS59DhsBItv/ZFl3WYrsl0TBAA0W38Ezglzjji3D0VZPpfizRRYoBb2o0b4+AvJ58Bm+1QjfzEX5eE+FxfVWC7SCKwZWoLZjPE0FtYh3nWMWtTFrCjWSZiax1h8cfkG26V9iWM/LI+TQDI+ob4of0f+X1gn2ny3ut7aw8q5S6kLR+hml3Pa1Sv9kEbYUhMl0Qgck7+W4QCxPiwZtpVROPtb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6GaF4BBx5l7+1xuuvc6aFbdV+kSyomXQ4OUK10Cv+g=;
 b=XMzRHKCh62hZYhydZnpRQESZHOBkmcO/LYr342bYA48lWdBe0ux64E7AqMbpc2we6kQUGDlJQTtVW+WrTE+Gs5AADfwzmYabPNn4unYpF0CrbH1nkfuDM+EghRRsrmxgdftNPOMpdzEhZaJyJAOpoEbJgtZdciP9+Olzl5golMePas+vOyFxTdWnvnj+M5v+2+uOBiO4uJCHdS0D/S274za7JtHPQixUz87sMiHPUEa4THO+VBEcGPsrLPT3Xfsgn5sZwySfzDAVcpKuaTW3OojzW68M3YXR8bPJCfsxgUxhd7NIFk5ni/vQsvo2EOLS97qCZ5pW48LbqmP4pZxdXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SN7PR11MB6728.namprd11.prod.outlook.com (2603:10b6:806:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 06:41:51 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f%4]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 06:41:51 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: Julia Lawall <Julia.Lawall@inria.fr>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Marcin Szycik <marcin.szycik@linux.intel.com>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 13/13] ice: field get
 conversion
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 13/13] ice: field get
 conversion
Thread-Index: AQHaHMCwKMpGIzzr9kGJsJykMx42fLCaUh1w
Date: Tue, 5 Dec 2023 06:41:51 +0000
Message-ID: <BL0PR11MB312230B67D2C2FF30D8B0368BD85A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231121211921.19834-1-jesse.brandeburg@intel.com>
 <20231121211921.19834-14-jesse.brandeburg@intel.com>
In-Reply-To: <20231121211921.19834-14-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SN7PR11MB6728:EE_
x-ms-office365-filtering-correlation-id: 72dcc279-93c9-411a-843e-08dbf55d4339
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 26xRR9J8eYgFZbpNp0XnuHppO8xgohzDf2ZUywp01AXPRm7bjZ66n9o1bGj/tYs9Tu3c+kW13Pyc+clR8Rl7kT9laGRtVPNQv/Rj7NgldBvTGk4kwJ0v7Bkfrmv1Rat0Wp2vZQOGN2F0wi9GD2kjkYZMOighCrjm9OSnVdj0Y9GF+qRv1Isv+CCreNu4TOxTUzF26EscSLLIlKUp0kBpEuhit67AvJ90a+7ZViyo1S9eNPr6mtAt5wHcM2Wth7BwAxxBVfcLAViJ6cJlehCQ7NYQyyOpeh8zhUcO1xlVIrUCKG6m2ozoqq7amU8rEk0b6sVdUy9gBDOasdfOMlRcr9FmL5tifJJUMHYJ6YtNl+KNccJvogkbCJFVgzQvZcwZ7bQVUJqBodB3SA3tgRy8Zzply5sWbAkm87p2NIgRH+4NuT1APX/qmx1Frbb3NxIF8QK8j4E0XCgP1q2hn6YYIOoW9fl6mDW/r1s6SUfk8JzMIwrl7IAK9+kjoI8TwXHlSee44b7RiRJVUGFj9xglsoiP7xXRKI28tMhKvH4IF3UpBYMnLoSsJmlATxKZ+Oa89wmadzBKoh4UfCbTS9Ln87zidTEq9EdtWgLxP/pFLOpkW21Mh4TDUzkLiUogHeZj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(26005)(55016003)(82960400001)(122000001)(33656002)(54906003)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(110136005)(316002)(83380400001)(9686003)(41300700001)(53546011)(38070700009)(38100700002)(2906002)(6506007)(71200400001)(478600001)(7696005)(8676002)(8936002)(52536014)(4326008)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R4Akcd/hrsDyH5kgJUsCGjkf+mFz0iEHcT6avtRuNyzfWhilEfE9PCcaugeh?=
 =?us-ascii?Q?FZf31UAWDsddGQAA2pTNhKvQ7+zh76udpIC0nMV1v+BD5BcKy3I4sc+oP0ZT?=
 =?us-ascii?Q?pyyzO3563LyYYqWm/XiTH3yOk620FxDw2gBhKnoabItydwotFwKr/8vHW6q9?=
 =?us-ascii?Q?MjkqOgckbPtvt6evB1JA7kkSOxpopKNf4PlPpjMyHeK3J5nmG+bKeat9Er18?=
 =?us-ascii?Q?rr3G/OVRPYGZMTXmG7Neax/HswMeMRBNFm8JnuRPd0cZdf8lOime15J6xfBc?=
 =?us-ascii?Q?U/AqRKsgDHsIQiAOgxyc0lFr5xAv3QivA+XO32KWeP2dqQn0KMcgHr93JPsA?=
 =?us-ascii?Q?Rq1MiZ/NB3k6UewBK/NMyGqO6fJZ2y8b0zL3OvZhv24xM4TNRqBZsPPUQX+h?=
 =?us-ascii?Q?/zMqCKi7nqNtYjQVfgKK6fQoYyHgcP95tZrM/Y6NEy9viCyuEIPDN7SKtOg0?=
 =?us-ascii?Q?t7wJDYPqNm/Xido1wHRb6M7QXYITqk3RsYCvQg41lEaoxNqo2rqOJ/8bsZLk?=
 =?us-ascii?Q?IjdszZFbJW6v1Fju59GfwYVOZUhKtLXLt7b/jcN2Spf1ezLO1ftyzx84voMl?=
 =?us-ascii?Q?Krpsawvp95zm6PErfXGGRgqvFpDGHXeNAW71Ytsdc+CUHWgJiH3/wnHXU3Hu?=
 =?us-ascii?Q?FUyRd6wuOoHGzE+64aEgpCDP9Y4WHO1WoamdzCthnXaQronwRny+fgNNTKcN?=
 =?us-ascii?Q?Hik11AOj2hRDAdhwvWGCLrBGuvpc6fYxTLVFOoFFwFymuhrJBh1fNBAxRm3y?=
 =?us-ascii?Q?iyqsK3h/0J7lqVcwTqLINxwOV+d3Bp+xJAoq4rdHh153UBBQrMklvtUPWr7T?=
 =?us-ascii?Q?7ityZdreqUNc1+soeZAJ8mnZKp+b1YNFNAM9ayerVU/PYZgW7pWVOkByQAWM?=
 =?us-ascii?Q?kLJ7JdNyY8g8BCaFG21CfDdWLmwUDess6QEnicPRxY4x6KnnfRF5nu59WIju?=
 =?us-ascii?Q?x4ZPGF83m+ssCMqdOsqJuni+47NzBFEz8Clma6v7eD6IF5WZoNDuRVWyPksl?=
 =?us-ascii?Q?JmH9261iswraT2eD6tLCouQKS0/zewmQNHEtOOWXyf+cvyTGUgJYc42GGC+h?=
 =?us-ascii?Q?Zllifru6dHGqgSEzkQx1xHBWvrh5LmE2KAg26aQmSLtySW0RrhVIrSWhzfWI?=
 =?us-ascii?Q?lHVZ6NvY5OAmkXHs+hZ/VYjfCTOPCsxjFXvJKLBfeVU/wWBMLrGYszcGi1gN?=
 =?us-ascii?Q?9T+jzdJECvXX9MbkEYJIt3waB46H6KdDH1wVTQk7iJ1aWiDk0FdjCtfhsJfW?=
 =?us-ascii?Q?4VO7m57fMi+HYGFQqq/J4MiQEhsfwC3nirbzNwNpET27U1x4PcMKV038h2JS?=
 =?us-ascii?Q?cuE1SR2A8wLF4Ddud2QMrQoCEHuU5SW3vYO/h+BKkGE8dqgAhSKD0HRrrxWP?=
 =?us-ascii?Q?z6Lo5ZBEDd6h79MLwDxXMAHBU2YqQnLzaFzAcy2klFP9ZZ8yOCsOg3SXCbkM?=
 =?us-ascii?Q?G+6eQs/ajm+L26Y6+ksOzMEMvYy7lZkAxvkBP1acMi3GTh2GmbvZyzHwEazO?=
 =?us-ascii?Q?hP+Z6KxJuBJWMaw7VS8yXdEleXLHWrXNGW4RshwqfTbCRSRJDCWf5mOjacFI?=
 =?us-ascii?Q?mc4kaj7NouOoR2Q0Gd5WNNfldmmKNLN3hGkh/aBBCwaKyKy/cbnReTUdRlxd?=
 =?us-ascii?Q?Bg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dcc279-93c9-411a-843e-08dbf55d4339
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 06:41:51.1304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7bXLbq/eTlvabtLLmXbffrmUoBfMqR7jfOAH+zcBM5J5t51qQUppvQ3psCMBsDj9zqYlUzd9eeeUiVVm1HP6Ofro2/p7XTwgR0+xzDdeEzZbGKQohgWhB2eB145VELZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6728
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
esse Brandeburg
> Sent: Wednesday, November 22, 2023 2:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Julia Lawall <Julia.Lawall@inria.fr>; netdev@vger.kernel.org; Marcin =
Szycik <marcin.szycik@linux.intel.com>; Brandeburg, Jesse <jesse.brandeburg=
@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 13/13] ice: field get conve=
rsion
>
> Refactor the ice driver to use FIELD_GET() for mask and shift reads,
> which reduces lines of code and adds clarity of intent.
>
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
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c     | 12 +--
>  drivers/net/ethernet/intel/ice/ice_common.c   | 15 ++--
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
>  13 files changed, 81 insertions(+), 118 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


