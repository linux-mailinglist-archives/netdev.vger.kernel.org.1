Return-Path: <netdev+bounces-16024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2035F74B052
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 13:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F321C20F8B
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 11:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84703C159;
	Fri,  7 Jul 2023 11:55:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FDDC13D
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 11:55:05 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A271FCE
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688730904; x=1720266904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+FE6JZOZwDcc9bCQDJjvtlHJ9Usowfjkc2yEURnC7us=;
  b=n5zzMKO+HDUNTsDOve9K1KLNab/v4yx5gZ8YOgGshS9kWm6Kf8zVBZPN
   bPt9Ae4uOAxcnXpkcQq3X3m8HkzCCqwKpq+TPHO0Cc0uNw/b6nbQ+mp5O
   DQkdneiTnTbMyrFnpyhr4TiQEwPquw+bwqtZTn3UmN+dvoonaVu4kNON5
   YFCLL5XjU5li4mLZBjL3dcAe0shoGnYAYDW67+3KhdQqN2pdKQt9NHqh+
   WX5oRgswV7xIlJCjcpoW+kyuZXAzW9FnaM1KtIDoTxFceMe1h44d4aSd/
   0Pc5E+myG9J4Wy7Rf/JlAu4gUR+4QP13K5dsK7Jo+y4m4cGA5rMKPtY55
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="362739290"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="362739290"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 04:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="833381875"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="833381875"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jul 2023 04:55:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 04:55:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 04:55:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 04:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONqQQHTsPOQQ2x9POBpCs/n2Nep9g5hhruxw/42n6hiJaoj7VXH7BZps+h3PbdMg9rGt9/sbPEJN1DI1yG3FnJUSgqZJsIm9lCSu+2Xe3Ye5TYJSlaXNmYEUhpCtdsyhhlwWxbW0XO1iqTyAM0vFVqXQ9nKB+UCIDcJFExyzgOWMCK1BEW/5lCr72AKqX6haTFU2u3zBmhCD0otbQ5wARu7xeXhMmXVLiCn/WhGNzScXUknUKQOJc1tPhGuHIHq5z410VA11QeIbRUx2uErfZuId8MbURGGRvHyuawbP8n1p75n7HmkwjSn9p56/H28trJPYbkYzKhxmff/BpaKGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sr3DfB6hCHenAOHyfJjxDBl87iUkeKSc63vM/uUc/2E=;
 b=Vtfz2p1w0PayTi9qWhP2Epk1zJVq08c7dG4HloQQ8Lc8cQoQaYddnN/GaOnRmSKeboe1SXeL58m3pgLTf7ETDqfDl+ya5xXsE6/Nk2JWO+2EazUkdI32B+KBructtWHu41gcm7JWMxXJj3+yX1zo9/kWJKYJSG/rDMXpiy5Juj8PFPppQaN2rTWleBvZLtxW65UF+ubPAGSPUcu8YEYdXdF7OOT2B6r6zjGOUCxCEmiEdo0jnyX9cWPXofv3v/S/MXhUw7DqQl66GQ28jjXnNoKgYhvXaIKTWspidohbX23TdtDt4b1/CpOZiamkGXhEzd6dMbZoEfaxr/1izgLDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by BL1PR11MB5351.namprd11.prod.outlook.com (2603:10b6:208:318::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 11:55:00 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::93f8:ecc4:eb28:7e65]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::93f8:ecc4:eb28:7e65%4]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 11:54:59 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Ertman, David M" <david.m.ertman@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bcreeley@amd.com"
	<bcreeley@amd.com>, "daniel.machon@microchip.com"
	<daniel.machon@microchip.com>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 02/10] ice: Add driver
 support for firmware changes for LAG
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 02/10] ice: Add driver
 support for firmware changes for LAG
Thread-Index: AQHZo8XM9TsNU3J3pkaFrUDEr9hRg6+uS/dg
Date: Fri, 7 Jul 2023 11:54:59 +0000
Message-ID: <PH0PR11MB501348D45D097184AE6B6BE6962DA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230620221854.848606-1-david.m.ertman@intel.com>
 <20230620221854.848606-3-david.m.ertman@intel.com>
In-Reply-To: <20230620221854.848606-3-david.m.ertman@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|BL1PR11MB5351:EE_
x-ms-office365-filtering-correlation-id: cb6719dd-472f-4572-ed49-08db7ee0fd9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hA/femkQYDy1jtf9BrpdNmTvs0eXLOom3WD2sRHVlOKjUJZ9vITJBBZQwaFBfRP5/nE7BzaxV84hCTMSRlmzj3ZgLB5PiiDkPWatn7q6Rb80cxz28F/0I/GwqRgwxxV16ZbUJ4c4ZyhQk0hLPLgsWdoWyLleTdGgFpkbcGUxkoNKDRFajKYEX2Anz0VM0adc7GZTNdENsoU/FXc+i6ql2sn+j7KtU4xEs/WuTPQbh0pZOr72T7hEvMd8sX+qVMPJ4Rn27AkvcrlZurjLsX5Da/2jjY9yJmB3wwtuXCSQpsAl+1aNlwJH2Cft+/Nh9+ZVR320vi2a6y49URBBpRfceCGGCr4upD6UVXGkIc/5ridgjOG8bGgYb/NY3V6kTim/2v2TSwG8ilW+/Y8SrPZkXczstwAcarB/6QyZXkBVfCLWQrZUjuXbCt6KpFL3okwlTh5xkcn9u0XIpaAnDJ/reKuPpbgl2HgaKRngmWTTqNagz0HJHznHr1NIvoI6rASY66dZdw9wM2NgVTQPcbKoe9SGRjSARWBk+Zy6lUDoZEgBg3eRDH88PFcnAiN/oIkXgFJbOLJvC2dvZU0AxTBpyH3JBMbOH8BmRCWoLlYCuH27cCiFPpniYkrfeaNwvisf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(83380400001)(82960400001)(122000001)(33656002)(86362001)(38100700002)(55016003)(38070700005)(110136005)(54906003)(71200400001)(7696005)(41300700001)(478600001)(9686003)(8936002)(8676002)(5660300002)(52536014)(64756008)(66446008)(2906002)(316002)(66556008)(4326008)(76116006)(66946007)(66476007)(186003)(53546011)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WshoZktOHdlr6yZf5/sV1G783vezjWUxGp6u8BCa2eQqP+IblzqGYcwzlZ0o?=
 =?us-ascii?Q?1ZFZn5nriVVKvF5E9NUSlmi5+gf4nL5tAxJrRHiJ9IaITkVH+VS5yUAmfNeb?=
 =?us-ascii?Q?DGHk0DzliDAjw2ZxF8UKxEOUhCyb7J5JRURzcgXs4dYJcsquw8BgGo17kATj?=
 =?us-ascii?Q?LQt1LqqDAYTb3yhJHDz33tDzphcZTfW1NihSzEdq8/IjNYbW+KJN0DjYGVso?=
 =?us-ascii?Q?5mSnYh4AAghCLyVM5ZhpwV6/aJra/K0bqaRchMEP2jFzoBcr1P4AnGDPvvA0?=
 =?us-ascii?Q?nr1PfFUIIdy6Qget/PIlZyPP2COUrYertCSKy7PGP6Bpo0xxediH1lTFekjg?=
 =?us-ascii?Q?b9ymDQREVApWCjAeu1PxpPpMTzkn+fi9iW8NbRWpjDBPJg2hY9ztpiCcFRdG?=
 =?us-ascii?Q?6etA6jQOs02t0A/vhlOCONAj4rXDOkuXcLuDC4jGMTZXWGYB79botc+CGOkQ?=
 =?us-ascii?Q?F/B6ZBlE+2wNOsl27fvV9rFY1OaKs21+ltjjxH4cUrB18yV3+3LU6Roo9rQi?=
 =?us-ascii?Q?wodqVmglNtL0+trnLi5e3SzGfmZboE3w+lW5qovM3plCLQmKnW1b9940VTtS?=
 =?us-ascii?Q?HdftS8QqBChxrjPMP4L7rIUl0YwJURmz4oHaQt4HLTfcbiU3SH/+qmNKRLe4?=
 =?us-ascii?Q?K4myXBUObM2JL4gJdv9Lqc+ZJMYyDYhrl/pVyY3MgqWawkszMv1YymMEQmWp?=
 =?us-ascii?Q?xBJfzY39SzGXnsgwiXerQMUn9pyaLwQq8KTMbPIpJbfrbp+oiWacEuNNejRj?=
 =?us-ascii?Q?BHI/t8FcgGmwYycUwABc10LnT37jQHckGBj9hzkgHFWyg8z17WLywWdZlghT?=
 =?us-ascii?Q?vYuj7EXU53pt3wIQPHYDg6NGdNzCv1gPz31kCI6tavmVPCzC+nZKCfNsNA6/?=
 =?us-ascii?Q?gs36ligjMoSyql91EWcBoB25g0SHRDo7g1eyE+8eXUI7JUyMa65qrTCuM/LT?=
 =?us-ascii?Q?D8JLtYzrNwp19tLuRqrHH4dPacIk+JccfTcMlUTuf2wtJQyNgSYErRskr1Ax?=
 =?us-ascii?Q?5nFvNoSDH4akl0q+hwEh5mSTK6haX/t9lzEhPfiKvUXQyeZCM/3P9pjTg4c7?=
 =?us-ascii?Q?qSGoGwYtlhA0CQ1MkI2GS5NNsEQPFWkLoPaSVMi3YSaCDQYbxDtpeTKq5uyE?=
 =?us-ascii?Q?HcKijAU5HajPMojfkYk9VXmvL1t1mamU6EA1O10nzEz7PwhaUkXOUIodj9ir?=
 =?us-ascii?Q?say6sjPsvxNqG663tWMxzpwxIgbbGsbodkJXUHn80NnuF7twPq3kE6ZobwKi?=
 =?us-ascii?Q?2OC+u3tX55eZHYnuaBVFXqJR/hRIbx2dZ+V+s/Ql5oLZthidKivcmR4OPjO2?=
 =?us-ascii?Q?PDDBVqNjCZkXSo1oQvySkEQ4hd8bSmZL7hcF5FLh2aYoIR5r15deAa6m4tUK?=
 =?us-ascii?Q?0c3TmwWRbswD++i48SoU84XOkNQwh60/ZtQr4y/z/zOBQaJV1csrUigaU5W4?=
 =?us-ascii?Q?4WoPjZNUR1N0893mCGSTnv7Q4xnSs7gNCaNwZgDm0ASqYdBQe62niRId7Pb1?=
 =?us-ascii?Q?NWdWluCSXtLIjEey8paoR0Oi10hqNtIP3Zu8IC2HjIc106e6hrKjoV0Xrqj+?=
 =?us-ascii?Q?2IRFJsk1bJ+/c+48zTsN2VRWvK8N+obQd3cZe3SERVnDVsfcOHSm8kzDzlIJ?=
 =?us-ascii?Q?OA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6719dd-472f-4572-ed49-08db7ee0fd9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 11:54:59.5611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ieFX+FfLlEDi6qzoXO5JaiqAvhSKCMsEC2JMjipEH/+nk8XwgaqcPuNXFB9w4KuDxvGX5hPN/d2kxJ3cf3Tn3rZzT/e8WeTvR1Zhy9HU+58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5351
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Dave Ertman
> Sent: Wednesday, June 21, 2023 3:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; bcreeley@amd.com;
> daniel.machon@microchip.com; simon.horman@corigine.com
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 02/10] ice: Add driver supp=
ort
> for firmware changes for LAG
>=20
> Add the defines, fields, and detection code for FW support of LAG for SRI=
OV.
> Also exposes some previously static functions to allow access in the lag =
code.
>=20
> Clean up code that is unused or not needed for LAG support.  Also add an
> ordered workqueue for processing LAG events.
>=20
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  5 ++
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  3 ++
>  drivers/net/ethernet/intel/ice/ice_common.c   |  8 +++
>  drivers/net/ethernet/intel/ice/ice_lag.c      | 53 ++++++++++---------
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.h      |  1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     | 22 ++++++--
>  drivers/net/ethernet/intel/ice/ice_type.h     |  2 +
>  8 files changed, 66 insertions(+), 30 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

