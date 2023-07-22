Return-Path: <netdev+bounces-20099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE1075DA63
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 08:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D857F28238C
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 06:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB38911C92;
	Sat, 22 Jul 2023 06:44:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBAB8BF0
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 06:44:21 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4000270B
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 23:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690008260; x=1721544260;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/bc0Xh3Qaweq9WGy+9GKC8bTu6e8DL8W0610BUd1eTw=;
  b=iuKpwEGlZhL8rU6hepGXbmbDdmCAsFsEj4Kj424uQZEOey2fgn6MyhST
   3piQgXrBg0txMDXTzGpU4pwwK1JG2i9UU88cKfGZ9kLpmi9msBpVFioL5
   79zjOzvMh8FowATmJb5UyijJT8GMxLGQBm+XIICPTPZMXrC6w7UOqT2/i
   JWil46Nu8hchuxSuemCdcQ+BdE/62vokSIEC6pmWI7C2cXrx+XGRc8xkc
   rRlHXPo+7pgFg2/J64l0BO5NZ992JYRKfyUsJIqpu0y37ELutqeLJnnJs
   EPKRX9i2aM//UtWQ9NMVMHAAcKkrVABEEUl3JYaEVIWufe7ZfWLmANOwS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="453547033"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="453547033"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 23:44:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="795210209"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="795210209"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2023 23:44:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 23:44:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 23:44:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 23:44:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juAY0DVVEhAH8UJlkCLXOgxwW1rYISOr1kfF0Dvu1cQWTRR14WT6fUZx/9KPsEJsPbWOJMxUsgk723TsI045PGbddQtV0TQ0UBd7dpkX2x+SSA0V+qAXC/jXluOK+F1pE0xtHTGokpsLhmf2XH7L1TkCxkF2pmGYv1dznVurwUYs8gNX1lyb9EoaLSWtx7evcQdD3/wqO45gByTWBlovXqHD2gJIZNQWIgV/HwnSFGuyy/aFxSxTPCCbPbMxsrZzbtOkHDRH7uVMAlv43+DG5jqL2VFQXPR3NnrN0FDb3BPecEs+a5E78DfW4z4hOL3u7Wwp8uW0JG1/pU4shGS0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2rw9sd+9F1EfGd3CgBOpMAhST6GxH+FmJm2KArXc5I=;
 b=Dsj1MONyf9x1ZuPdBhpI8wnnyJR4+2GTO/1xi+ZpsZpQ2pisSa5LovM62CMI7+wph7w52ZZsySuWUfWbNySZiIz04eZIppCqUGa3fJba3//x+VkK8PbOZRbl6Y0AdS3l/LarbFsYguRzuj+/ptKramJGAy9GPTfR1U/2/qhvOO0D2BkfhTVyIkQXQPmwsZVUn6753H5qkHrPtMyRfAfAYekByKPoJ1qGJ7vaC3FTJoV+FR2YwI/4PFzO5DM7J5eQs+u6I1VLWweXcJm7k2pAlzQuQDcnZ6zcnehMsOhFFbfYU6oXaw6gOUAt4safMiZoZEJP7kS3EJxPDYKYkIsLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 22 Jul
 2023 06:44:17 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d%4]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 06:44:17 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "vladbu@nvidia.com" <vladbu@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 02/12] ice: Prohibit rx mode
 change in switchdev mode
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 02/12] ice: Prohibit rx
 mode change in switchdev mode
Thread-Index: AQHZtLDZdQinxP0MRkO/CJoqbhdIea/FZmvQ
Date: Sat, 22 Jul 2023 06:44:17 +0000
Message-ID: <PH0PR11MB501303EB1AA03881E6A36EBB963CA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230712110337.8030-1-wojciech.drewek@intel.com>
 <20230712110337.8030-3-wojciech.drewek@intel.com>
In-Reply-To: <20230712110337.8030-3-wojciech.drewek@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SA2PR11MB4828:EE_
x-ms-office365-filtering-correlation-id: 14e45e82-c40e-485f-af8e-08db8a7f123e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: twclqKZtsKR+6/YOSdBWQiybhdGt+93MsgnxLapqqDsdT/VmeD7mnekdJxlBOPXcap7BcdByl1cB9iM7rYQ+Zq/InNIaGTRlhZKJMSoAi9EeGQ0j7R9RKAgspzMVhDkV0TPsTNIOdRA1TUaCNhVRgGOl21e+SphcHlJKVgB4J4VGp0blUXqJlwXl0cxC8AActTgHjenN3Qf8Cw2J4Q3AiL7BstwL84DhRPhs+uviPU4Lvb/Av3r/kkfHOMcaFM80Cb+rhqNrnYjA1TuO03jgpPoj54qx1bW2F+gvjFdWQ8iqg8RmOmAM1B0hkvvfOjGlzNTMIcUKer98NZFj1RwDwjxDOrktg8iYuFiDFKB8NwmQv/HFIN/OVxUX+DRa9ewexQ8VMgH56DBJ5a02K/I3ITyr7vsPTxJOB79NnSipcDjHAMnMp2ycQp4o0k67y71FT/F3iIhq5N+bo4X/D/PGjijU3s9RyOkM8DGKGbX0oDQMgRjRYxMc+GvNmM7rHnD96p6li83M7V0uNzAflDaRg7AebobkvJ5BK1INQv2IVZY5bniGFArTTiRN41AjafJ8ZHEtwZ1QP1eXOTNcR+RL+RL1m1rOojso7FQywPq1bxY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(2906002)(83380400001)(38070700005)(86362001)(33656002)(82960400001)(122000001)(38100700002)(55016003)(4326008)(64756008)(71200400001)(66476007)(66946007)(66446008)(66556008)(186003)(76116006)(478600001)(26005)(53546011)(41300700001)(316002)(110136005)(6506007)(7696005)(54906003)(9686003)(52536014)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4q6S5U9NH9XLdRz7EFRz3ZIE5oUc8glm7mThMvbOwRE21JFFSQudkQSt0y6O?=
 =?us-ascii?Q?tS8BXdLUGrWiIUmJG4G2u1XCgbXZ51bPC0V1iHXHrmkjykZ4dqVUJScPYiI8?=
 =?us-ascii?Q?OA8OmPoSrH1idjzjKnpw8J84FEHa6NHAaTcFtZyWYWWswZZZOz2wOScu1kUP?=
 =?us-ascii?Q?aHPzMGUfUVBO+LMmp9RCuzetPevsnXzx7wyoF5qsnWYzkT0a3cEnABWMlQ1f?=
 =?us-ascii?Q?saAUvfnVbkOTqu6WBGI450MZ7IBlkfo3RKAG4GxECw7gokWAyT10Qo+FOB8q?=
 =?us-ascii?Q?S5ek8L4QRJaW0Cvbgqx1ccafgH04SgSNbW4x/9IAFmLdgFXCsBicdk0xxOeJ?=
 =?us-ascii?Q?CUNpL60W5bj54FXsONN0Gisn0J8y3g7LpPyNV6zqpmBwhjFo27hJI2kfaUAp?=
 =?us-ascii?Q?ZK0FGRnpTkRvswtb/hImLhcFGu+PTLjkJ85obzmeGE/GGoygAj01B+Q5jiG4?=
 =?us-ascii?Q?4OJTBOrvqwETucVVihlzN6Bc1WYLPxblIt7fWbgkVEZ2x4ZiN7S3T1xSBYBE?=
 =?us-ascii?Q?Kx8nF8woPotZdq5sevTY1kpTBdOF7Z1oS0GrCAxaeGDC7mvfA5198YShtMoY?=
 =?us-ascii?Q?mRhFVV7oqBy41Ww4OjiB2tVSTwAEfU7lUD1ipFuGSsG3TxEkO5HhBK6xVSoQ?=
 =?us-ascii?Q?HdOfM0OwcBnPc/Y4MT8+ivJ9tIgmRGI1LefV7DlMzQj3hylzq7+aBpgN9gRt?=
 =?us-ascii?Q?K+58qVTAcnvW2+RbJ49J/hjJtLxX4/NUnKyAMsB256A5t5CdLpVi8KaMPpEg?=
 =?us-ascii?Q?z5w1/iXyaA2mjN/kXsBeiv2Z5u2JwpEUYnLhYgfwims7LjXKswgBscalGcV3?=
 =?us-ascii?Q?qVKpWgxxNYbnyqNMbOEdM8AKMERgDksz/8Pd0HQ2hE6wOpHptOLeJeqwd8bh?=
 =?us-ascii?Q?qPud4xd7zHM6Mf9RbfWMkPZJtRzt+OqpODQ5uQyc6MuAPrVOlpfly9B0iXIM?=
 =?us-ascii?Q?+1Tl99vZJ7yR2STFA+Q9TYCSPFiE39BXXDs1CESLJFI7xnKw5TVkf7XAv6CW?=
 =?us-ascii?Q?UOE3KOMMicgYnzalGGU355yUGSYbAeEvqOI9gCnN8dQCabJwV/3aQLec5lFH?=
 =?us-ascii?Q?O7Nl2yOi8/oM/HmCHJH8Du3/cv3Pbv1Ba8zWRgZUzcehxHX1P+eiWPq3AYIy?=
 =?us-ascii?Q?lupycajcaQm2Oze4mUxaL5X+Vd6mLGk6IU+z/1Pxodl6lckEQhIlP5loFnCK?=
 =?us-ascii?Q?vSTlUiPk4pIB+ReSxQTsNXffOdZS/TXSAkiGwWYKzNvz17wqWXjsmdT2QBBq?=
 =?us-ascii?Q?0Ujmgw5vpBpCUpV0ohl1KLoOOCMA0Tae1kNmbZ1zWraAGoM3oOrHUM1OS1yh?=
 =?us-ascii?Q?kt69mwHWXAVVQEjgiHNtbqW2Tdb33n6krpzPxsHp9NHX2vtXmbMBHEtFkl7u?=
 =?us-ascii?Q?8iSHYhLHAhSObwwch98+cHkQ4NLs2QeQ1eIChzXtbRv8ZfsXt9vkrvo7+I6B?=
 =?us-ascii?Q?IO4V+zhbElS2b4A57qtA7J8oAVWHMPG9JDQNGLiwUFpUtB6NjI5nKlKlmF0G?=
 =?us-ascii?Q?k93bfkfHFs6sYrwBUo/G/bVuNINkpdyY+Ga5xpZ92mhm0U2TGtYSkFh0nZXL?=
 =?us-ascii?Q?JvqOTsOCwwEVNI+m3PTgQCdRgwnFBiz8F1aVGvWQE9TLKHeA+Xo/pvBsVBUY?=
 =?us-ascii?Q?Sg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e45e82-c40e-485f-af8e-08db8a7f123e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2023 06:44:17.4486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLuRZdCJ/IdzYaY9e9+sPyrchhqmZOp97qBXs30xak02B6ZBFD4nhQO020BqDB3/nnVLP2yuteifcIB9pAUGPybBrbxhcdReP6Hc5qeR06I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Wojciech Drewek
> Sent: Wednesday, July 12, 2023 4:33 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; netdev@vger.kernel.org; vladbu@nvidia.com;
> kuba@kernel.org; simon.horman@corigine.com; dan.carpenter@linaro.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 02/12] ice: Prohibit rx mod=
e
> change in switchdev mode
>=20
> Don't allow to change promisc mode in switchdev mode.
> When switchdev is configured, PF netdev is set to be a default VSI. This =
is
> needed for the slow-path to work correctly.
> All the unmatched packets will be directed to PF netdev.
>=20
> It is possible that this setting might be overwritten by ndo_set_rx_mode.
> Prevent this by checking if switchdev is enabled in ice_set_rx_mode.
>=20
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

