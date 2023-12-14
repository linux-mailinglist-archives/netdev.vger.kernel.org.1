Return-Path: <netdev+bounces-57418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C811813103
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B421F21499
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAFF537EF;
	Thu, 14 Dec 2023 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpadpD59"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF260197
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702559466; x=1734095466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vjfWp+MAItX7qBFJhFMU8wmxMZjIA7qSnTgVoKbbULA=;
  b=hpadpD59PxV0HeD6v0APBgqDZOqzX/sEp+ibKQBauRLpPMcQNuG7yTs+
   moUA3jysBMdiWP1XvHQiFXZhPnibmEj4NjL98cbrhGPp3o5eFEFmSzPyr
   zCCrd80lCt3jA1HjmRdErXQMq1He/uHCNrgDnVpUkrnYfF9YwU6SKNdDt
   a6KSkAUzbAC2NRRs4HcKpMePE6wjpy0fiCsfOndOIIqI8fo7LFcl8UktC
   SeJlkjloMOc+TgXzYqqTGtQVxmi2BFL8H3b9Qt8B5xuIUGHw/i7V9C7Me
   m9WBJrNf1L7RHXTJ88uLAaxTbsnuI2g/xdaMs/9Ip70U9Hso8YOSjpvti
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="393987278"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="393987278"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 05:08:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="15849907"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 05:08:53 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 05:08:52 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 05:08:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 05:08:52 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 05:08:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cS6MIfaEkuKtM2eJKUJnkFHVZOG+n0scZbpye2nlYxqsr4p2V95ryLX8qiIYFpux5uiXf884LdhL6Lls+7D1IpjIfh+yb0mHE1mgiKe+bMPLz4Qf9/2xiA3UiCKcL6XtcHt+dxyd9Acah4yXbV1hQ0ZGuMAqp1Dz+YMWwHPGkafZ4F0J2cg2NM7sOop1sIpCGXH8puchK6kbQab5U1FfyMNfrFK9e5tGVuUPrTbrrkPk1koSv1tNO8oCkAaMW4o8/ed16HiUD3d3cSestI7bkwb5se0CeEJJLKqykwXYQEB0t3HsQ7J7xNC1KtnIDYq/KiiHeu/1zZtMaRHXmyNjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNa2QgAzAXMompFJFh9llPY6QQnCH+WYuGaZNXQAPLM=;
 b=BtsocjvSmIKcIyG4qUJUGE1xv0xFr1B1rXTUbfN1mBbayU9gT+r8m6m071VV5X6yHhohLbm3sf3UQyuMjWcVKnWXOhfowL7ZmXu3Mdc4Sy4k63oRb7Z/dtav9Kp2EWH3jfSD7HdZaoTWxy+KoFkiv85gfLOawHaJNOjdWcgZ23VjFlKWQ6nlUdxeiMSaKBQR4hXDFbmvLl6IELRHxIb8taleYAEjxt+JcRXMuzft39jF9PxUAiIHT64ZmEwMXvmCRG7/hAzXz8IjC+HkJ0NwpQUJHoQ038cq0Ki5iNsaKDJCKtXJxqdBjJ7cKFWyUOlxVsIRvMmXuQz3HRGq8YWuyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by SA1PR11MB8542.namprd11.prod.outlook.com (2603:10b6:806:3a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:08:50 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::1498:c32d:2d2:975c]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::1498:c32d:2d2:975c%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:08:49 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Zaki, Ahmed" <ahmed.zaki@intel.com>, "Julia
 Lawall" <Julia.Lawall@inria.fr>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "marcin.szycik@linux.intel.com"
	<marcin.szycik@linux.intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 05/15] iavf: field prep
 conversion
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 05/15] iavf: field prep
 conversion
Thread-Index: AQHaJ9/ztLRdnG3nCEO3LYbgzt1tILCozYGw
Date: Thu, 14 Dec 2023 13:08:49 +0000
Message-ID: <BL0PR11MB3521AD123C2947DBCFC728F78F8CA@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
 <20231206010114.2259388-6-jesse.brandeburg@intel.com>
In-Reply-To: <20231206010114.2259388-6-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|SA1PR11MB8542:EE_
x-ms-office365-filtering-correlation-id: f16bd472-52b4-4862-e33a-08dbfca5cfdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kMLkJ0Wq3aXpg/d90SwkY/SJhU+0uyIgr6idtYsxzBDAbcnvPjnb+7xPxa0EB7WScXITO5xw+HlMiDskJwN6x7IETD/uHgdUaRcTfwM2nkTEq5ggP1h7fJwcULHoqFXIqofWgDLmp1iHp7i/R4R7TlTkIr3SFOTiHmghMpjPRhKBq+ho/Ubm0NM8r5/PeZwX8zZzD7cDLg+svHa8MTN1tpTCq9EU+eEaoYPl/iFU9L8L/XTFfgewwiEEagicMHRcums2LLQ1/eBXHW8MWW0prvpVVWHjrHwAPJD6oxgxXGMC/Zl94ZMBvkP2Jvx5/6r5yy/Ngxl5PFCOzdqC0/YByKPwNIrz5sdK8uc3sUWcD6/8y5WUMnNnSuVWCw8Cz2X9p5fsAGCH1ZDpMxEkHn7QPDL+hdW99Wyf0K6uVvhQYloNIWGj86WTODTFLd3Ga6qh8HIGBRC1SyVUMk0sCgSuIbPTHz8SHcY/2699dK5m8F33r//HLD+4/IP8NglpSxphCkrJ9LqS6zTHm4Nr+LA2IcI6pcG+SQySmOjKk0T5M2KzgC1A6YIstgUsoX9GAqDYiWHk614BjmYJPg84olBgWePgrzcr9pN+jJMtujm2ayySPByhDY2VNCAZXbitdbi8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(53546011)(7696005)(6506007)(9686003)(83380400001)(26005)(8676002)(52536014)(86362001)(41300700001)(4326008)(33656002)(8936002)(2906002)(5660300002)(38070700009)(54906003)(66556008)(110136005)(66946007)(66476007)(316002)(66446008)(76116006)(64756008)(71200400001)(478600001)(82960400001)(38100700002)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ppUzYzrnrIEgWUW0NhSrXeksWeRIMRZqr+sZotFpu2c/GI6kTINUvFIAN6gl?=
 =?us-ascii?Q?7u3ErH3oxMN/IY/UviqCUkRlhaRo/ydtMq0FR28QxJAybb8t0eJJZRRcnFGZ?=
 =?us-ascii?Q?V5k/7Bw5tocKqzHWsBOO4/9kBEgRnUPSGDLMVqHMO0LcJUihoD1Yzeb1n6Y3?=
 =?us-ascii?Q?pGtP/qJMNB0itmZB62CYlxKNLB5DdDPdiQ89HRBvjPV9V2EJE7RWbl6VSIfd?=
 =?us-ascii?Q?KC9kmRKtzOEWvGNwSbDqN39FgnBeVlQlP49c84nRLjmujueo3/72wW6vM7GF?=
 =?us-ascii?Q?pjr2USjO3VYYkhBCCkrQuBKt0uHBvl5X5wpTxVYwl+ZVBIAjkTkgIookzraT?=
 =?us-ascii?Q?e49JelCfG+gDthY3YJJngxRrD6zegNIhYRMV6OlMWLrZOzWssbJj4cqzDL38?=
 =?us-ascii?Q?yc02vst/9MIzwO3bypxBGWt0mFC8nbJa4u6PDqjYtGsy+Yl7PMWEFDiyInNO?=
 =?us-ascii?Q?jU+JY6ugX37rKD5Fm0/II2TLW6RByxoOpP9SfzvT+sxcsupMYBUFoEh1lyi5?=
 =?us-ascii?Q?OW1AKWlA6xbV5sMX0GeEf+FO/IXeN80XqLh7tdXDCtbvojUVqiDyh5q0IV5l?=
 =?us-ascii?Q?IlUy8Mxs8mKfsuJg6X714mznn94TnYrmSCJvhLdMxht5Dbbiwn615n2ZmkGs?=
 =?us-ascii?Q?foawcyCDwJ006hLaJDMlFrMer/468py7w/KtU5HAd/Mcg4cB+GZ1k+dqY0bs?=
 =?us-ascii?Q?eUiA4fipDmmjBGnwE7EyKu6+SGo6zzYhSr5khAyuNMf18Z9p+/uqhZBYZslY?=
 =?us-ascii?Q?gkKM71DI862+Dk+h7602tXh/EJeH6RJ1k9HFiF8hih7jg8U7mF0/qkuX+xV1?=
 =?us-ascii?Q?L0Tf0nFohF52MA0zGvaGT9yQa+Xn1jejLd6p2R8uUaUiBzvnnf0hNfW5+bWB?=
 =?us-ascii?Q?9a7Endeh1FxpHWIasa9TOTsVPfSE3EMO7pP0Y8+mH6Q9R4fb03fiCz7mEttZ?=
 =?us-ascii?Q?q3V9Qiu7IPJXAzRFrCWiJA3K/BrUD7l0TwvO4i6+luJ1pr1bt/LOIRLbtN43?=
 =?us-ascii?Q?i62fhWOXPwZkML5aszPUCQKpINhEM/VbkdXd9j8wj5eXEy63KwsIn04nWVh0?=
 =?us-ascii?Q?FVyVmkKQXxcB2k+jkEDQ3BWmq4J0+ZAM3Uv8s9kZK739zRR4lyWjc0p8gM8r?=
 =?us-ascii?Q?t3wB7HjA2zx8cIAcP+7YTm9WhsraVmMUqxUgE8HFNYEWocNAqg43qGdWTYuM?=
 =?us-ascii?Q?75Iwf7EQOGNavkk5r4EhamCNjF9p68tE+7vMxDspDI3fi32pSW1iey9oFi2s?=
 =?us-ascii?Q?dq0Pf0901ZhiBEAMFZYpNvxx8KaHO0fiOd/k2qtirhNUymEz0KcH6XYMQqrv?=
 =?us-ascii?Q?bYqvg7sC3jOBLtsjPcRIsZypUpWt/ePkJ0/sQE0F1t23pM/zsCDMwQMOwq8F?=
 =?us-ascii?Q?2vHn36dWYCP0okwbJkIirL7TIXRu/X+Dw21T5OGrqxHtnbOWX56K+Rbo4J4B?=
 =?us-ascii?Q?nDayEnXJkjQxad6X+TEJaVfu54kjysnD/RkuoQItTRiQQGUv8ONdgTJBk3Z8?=
 =?us-ascii?Q?i/A43Yivw3pN1KWme01u/gPCzcILIB4P69k8k5OSBVuQ2gZql/uDttQFDK49?=
 =?us-ascii?Q?H5p8r0AptkC8TpxMjPxHM8axQFJz1ZFQQ4rgeEzUUTvq2rwvRCqpqMSFqUSX?=
 =?us-ascii?Q?fw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f16bd472-52b4-4862-e33a-08dbfca5cfdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 13:08:49.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+UoXoNX3y5ZlJyWIKzb4/5zVhxL3xpFYUHg2vPzjHj4w8xjIe1+GtT7VxIt60noT6MgStqTS4o/5Uuub9bEDEhSiTNqj+Wa2cYRNoOyipU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8542
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jesse Brandeburg
> Sent: Wednesday, December 6, 2023 2:01 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Zaki, Ahmed <ahmed.zaki@intel.com>; Julia
> Lawall <Julia.Lawall@inria.fr>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; marcin.szycik@linux.intel.com;
> horms@kernel.org; netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 05/15] iavf: field prep
> conversion
>=20
> Refactor iavf driver to use FIELD_PREP(), which reduces lines of code and=
 adds
> clarity of intent.
>=20
> This code was generated by the following coccinelle/spatch script and the=
n
> manually repaired.
>=20
> Clean up a couple spots in the code that had repetitive y =3D cpu_to_*((b=
lah <<
> blah_blah) & blat) y |=3D cpu_to_*((blahs << blahs_blahs) & blats) to x =
=3D
> FIELD_PREP(blat blah) x |=3D FIELD_PREP(blats, blahs) y =3D cpu_to_*(x);
>=20
> @prep2@
> constant shift,mask;
> type T;
> expression a;
> @@
> -(((T)(a) << shift) & mask)
> +FIELD_PREP(mask, a)
>=20
> @prep@
> constant shift,mask;
> type T;
> expression a;
> @@
> -((T)((a) << shift) & mask)
> +FIELD_PREP(mask, a)
>=20
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: updated commit message
> ---
>  drivers/net/ethernet/intel/iavf/iavf_common.c | 31 ++++++++-----------
>  drivers/net/ethernet/intel/iavf/iavf_fdir.c   |  2 +-
>  2 files changed, 14 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c
> b/drivers/net/ethernet/intel/iavf/iavf_common.c
> index af5cc69f26e3..5a25233a89d5 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_common.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
> @@ -331,6 +331,7 @@ static enum iavf_status


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



